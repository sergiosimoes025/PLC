
var slug  = require('slug')
  , _     = require('lodash') 
  , async = require('async')
  , Busboy = require('busboy')
  , cloudinary = require('cloudinary')

  , activity = require('./activity')

  , Guide    = require('../models/guide')
  , User     = require('../models/user')
  , Activity = require('../models/activity');


exports.create = function(req, res, next) {
	if (req.method == 'GET') {
		/*
		var parameters = { 
			'timestamp': Math.floor(new Date().getTime() / 1000) 
		};

		var options = {
			'api_key': '763249739557766',
			'api_secret': 'mZIoghnWZqC1zbXw4GvJFtlYzbM@dj5ncrwwf'
		};

		var signature = cloudinary.utils.sign_request(parameters, options);
		signature.callback = 'https://raw.githubusercontent.com/cloudinary/cloudinary_js/master/html/cloudinary_cors.html';
		*/
		
		res.render('guide/form', { 
			title: 'creating a journey', 
			user: req.user
			//signature: signature
		});
	} 
	else {
		var images_ids = {};
		var guide = {};
		var total_places = undefined;
		
		guide.places = [];
		
		var busboy = new Busboy({ headers: req.headers });

	 	busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
	 		console.log(fieldname, filename);
	      	var stream = cloudinary.uploader.upload_stream(function(result) {
				images_ids[parseInt(fieldname)] = result.public_id;
			});
	      
	      	file.on('data', stream.write).on('end',stream.end);
    	});

		busboy.on('field', function(fieldname, val, fieldnameTruncated, valTruncated) {
			console.log(fieldname, val);
			var elems = fieldname.split('.');

			if (elems[0] == 'places') {
				var index = elems[1];

				if (guide.places[index] == undefined) 
					guide.places[index] = {};

				if(elems[2] == 'lat' || elems[2] == 'lng')
					val = parseFloat(val) || 0;
				
				guide.places[index][elems[2]] = val;
			}
			else {
				if(elems[0] == 'totalplaces') total_places = parseInt(val) + 1;
				else guide[elems[0]] = val;
			}
    	});

    	req.pipe(busboy);

		async.until(
   			function() {
    			return (total_places != undefined && Object.keys(images_ids).length == total_places );
			},
			function(callback) {
				setTimeout(callback, 500);
			},
			function(err) {
				_.each(images_ids, function(id, index) {
					guide.places[index].picture = id;
				});

				guide.author = req.user._id;
				guide.slug 	 = slug(guide.title).toLowerCase();

				var newGuide = new Guide(guide);

				async.series([
					function(callback) {
						newGuide.save(callback);
					},
					function(callback) {
						req.user.guides.push(newGuide);
						req.user.save(callback);
					},
					function(callback) {
						var action = {
							author : req.user._id,
							verb   : 'created',
							object : newGuide._id,
							sentence : 'as a new journey'
						};
						activity.create(action, callback);
					}
				], function(err, results) {
					if (err) return next(err);
					else return res.jsonp('/guide/' + newGuide._id);
				});
			}
		);
	}
};

exports.show = function(req, res, next) {
	Guide
	.findOne({ _id: req.params.id })
	.populate('author favorites reviews.reviewer', 'name picture')
	.exec(function(err, guide) {
		if (err) return next(err);
		if (!guide) return res.jsonp(404);
		else {
			var isAuthor = _.isEqual(guide.author._id, req.user._id);

			if(!isAuthor && guide.votes.length) {
				var voted = false;
				_.each(guide.votes, function(vote) { 
					if(_.isEqual(vote.voter, req.user._id)) voted = true; 
				});
			}

			return res.render('guide/show', { 
				title: guide.title.toLowerCase(), 
				user: req.user, 
				guide: guide,
				isAuthor: isAuthor,
				voted: voted
			});
		}
	});
};

exports.edit = function(req, res, next) {
	if(req.method == 'GET') {
		Guide.findOne({ _id: req.params.id }, function(err, guide) {
			if (err) return next(err);
			else return res.render('guide/edit', { title: 'editing a journey', user: req.user, guide: guide });
		});
	}
	else {
		var images_ids = {};
		var guide = {};
		var total_places = undefined;
		
		guide.places = [];
		
		var busboy = new Busboy({ headers: req.headers });

	 	busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
	      	var stream = cloudinary.uploader.upload_stream(function(result) {
				images_ids[parseInt(fieldname)] = result.public_id;
				console.log(images_ids);
			});
	      
	      	file.on('data', stream.write).on('end',stream.end);
    	});

		busboy.on('field', function(fieldname, val, fieldnameTruncated, valTruncated) {
			console.log(fieldname, val);
			var elems = fieldname.split('.');

			if (elems[0] == 'places') {
				var index = elems[1];

				if (guide.places[index] == undefined) 
					guide.places[index] = {};

				if(elems[2] == 'lat' || elems[2] == 'lng')
					val = parseFloat(val) || 0;
				
				guide.places[index][elems[2]] = val;
			}
			else {
				if(elems[0] == 'totalplaces') total_places = parseInt(val);
				else guide[elems[0]] = val;
			}
    	});

    	req.pipe(busboy);

    	async.until(
   			function() {
    			return (total_places != undefined && Object.keys(images_ids).length == total_places );
			},
			function(callback) {
				setTimeout(callback, 500);
			},
			function(err) {
				console.log('entrou');

				_.each(images_ids, function(id, index) {
					guide.places[index].picture = id;
				});

				Guide.findOne({ _id: req.params.id }, function(err, old_guide) {

					_.each(guide.places, function(val, key) {
						if(val.picture == undefined && old_guide.places[key] != undefined) {
							guide.places[key].picture = old_guide.places[key].picture;
						}
					});
	
					guide = _.extend(old_guide, guide);
					guide.slug    = slug(guide.title).toLowerCase();
					guide.updated = Date.now();

					guide.save(function(err, doc) {
						if (err) return next(err);
						else return res.jsonp('/guide/' + doc._id);
					});
				});
			}
		);
	}
};

exports.delete = function(req, res, next) { 
	Guide.remove({ _id: req.params.id }, function(err) { // falta remover os objectids do autor
		if (err) return next(err);

		var query  = { _id: req.user._id };
		var update = { '$pull': {'guides': req.params.id }}; 

		async.parallel([
			function(callback) {
				User.update(query, update, callback);
			},
			function(callback) {
				async.series([
					function(callback) {
						Activity.update({ userId: req.user._id }, {'$pull': { 'userFeed': { 'object': req.params.id } }}, { safe:true }, callback);
					},
					function(callback) {
						Activity.update({}, {'$pull': { 'activityStream': { 'object': req.params.id } }}, { safe:true, multi:true }, callback);
					}
				], callback);
			}
		], function(err, results) {
			if (err) return next(err);
			else return res.redirect('/');
		});
	});
};

exports.favorite = function(req, res, next) {
	var userId  = req.user._id;
	var guideId = req.params.id;

	var query  = { _id: guideId, favorites: { '$ne' : userId }};
	var update = { '$push' : { 'favorites': userId }};

	Guide.findByIdAndUpdate(query, update, {}, function(err, guide) {
		if (err) return next(err);
		if (!guide) return res.jsonp(404);
		else 
		{
			req.user.favorites.push(guide);

			req.user.save(function(err) {
				if(err) return next(err);

				var action = {
					author : userId,
					verb   : 'marked',
					object : guideId,
					sentence : 'as a favorite'
				};

				activity.create(action);

			});
			return res.jsonp(200);
		}
	});
};

exports.vote = function(req, res, next) {
	var userId  = req.user._id;
	var guideId = req.params.id;
	var score   = req.params.score;

	async.waterfall([
		function(callback) {
			// This query succeeds only if the voters array doesn't contain the user
			var query  = { _id: guideId, 'votes.voter': {'$ne': userId } };

			// Update to add the user to the array and increment the number of votes.
			var update = { '$push': { 'votes': {'voter': userId, 'score': score } }};

			Guide.findOneAndUpdate(query, update, {}, callback);
		},
		function(guide, callback) {
			Guide.aggregate([
				{ '$match': { _id: guide._id }}, 
				{ '$unwind': '$votes' },
				{ '$group': 
					{
						_id: null,
						average: { '$avg': '$votes.score' }
					}
				}
			], function(err, res) {
				var r = res[0].average
				  , v = guide.votecount
				  , m = 1
				  , c = 4
				  , avg = Math.round(((v/(v+m)) * r + (m/(v+m)) * c) * 10) / 10;

				callback(err, guide, avg);
			});
		},
		function(guide, avg, callback) {
			Guide.update({ _id: guide._id }, { avg: avg }, {}, callback);
		}
	], function(err, results) {
		if (err) return next(err);
		if (!results) return res.jsonp(404);
		else {
			var action = {
				author : userId,
				verb   : 'rated',
				object : guideId,
				sentence : 'with '+  score +' stars'
			};
			activity.create(action, function(err, result) {
				if (err) return next(err);
				else return res.jsonp(200);
			});
		}
	});
};

exports.review = function(req, res, next) {
	var userId  = req.user._id;
	var guideId = req.params.id;

	var review = {};

	var busboy = new Busboy({ headers: req.headers });
	
	busboy.on('field', function(fieldname, val, fieldnameTruncated, valTruncated) {
		review[fieldname] = val;
	});

	busboy.on('finish', function(fieldname, val, fieldnameTruncated, valTruncated) {
		review.reviewer = userId;

		async.waterfall([
			function(callback) {
				var query  = { _id: guideId, 'votes.voter': {'$ne': userId }, 'reviews.reviewer': {'$ne': userId} };
				var update = { '$push': {'reviews': review, 'votes': { 'voter': userId, 'score': review.score } } };

				Guide.findOneAndUpdate(query, update, {}, callback);
			},
			function(guide, callback) {
				Guide.aggregate([
					{ '$match': { _id: guide._id }}, 
					{ '$unwind': '$votes' },
					{ '$group': 
						{
							_id: null,
							average: { '$avg': '$votes.score' }
						}
					}
				], function(err, res) {
					var r = res[0].average
					  , v = guide.votecount
					  , m = 1
					  , c = 4
					  , avg = Math.round(((v/(v+m)) * r + (m/(v+m)) * c) * 10) / 10;

					callback(err, guide, avg);
				});
			},
			function(guide, avg, callback) {
				Guide.update({ _id: guide._id }, { avg: avg }, {}, callback);
			}
		], function(err, results) {
			if (err) return next(err);
			if (!results) return res.jsonp(404);
			else {
				var action = {
					author : userId,
					verb   : 'wrote a review on',
					object : guideId,
					sentence : 'with '+  review.score +' stars'
				};
				activity.create(action, function(err, result) {
					if (err) return next(err);
					else return res.jsonp(review);
				});
			}
		});
	});

	req.pipe(busboy);
};