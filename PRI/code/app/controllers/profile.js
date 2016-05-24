
var _  		   = require('lodash')
  , async      = require('async')
  , cloudinary = require('cloudinary')
  , Busboy     = require('busboy')

  , activity = require('../controllers/activity')
  , follow   = require('../controllers/follow')

  , Follow   = require('../models/follow')
  , User     = require('../models/user');


exports.show = function(req, res, next) {
	var userId        = req.user._id
	  , profileUserId = req.params.id;
	
	async.parallel({
		profileUser: function(callback) { 
			User
			.findOne({ _id: profileUserId })
			.populate('guides favorites') // can also limit number of guides, and the order
			.exec(callback);
		}, 
		isFollowing: function(callback){ 
			follow.isFollowing(userId, profileUserId, callback);
		},
		follows: function(callback) {
			Follow
			.findOne({ user: profileUserId })
			.populate('following following.name')
			.exec(callback);
		},
		activity: function(callback) {
			activity.userfeed(profileUserId, callback);
		}
	}, 	
	function(err, result) {
		var notProfileOwner = !(profileUserId == userId);

		if(result.activity) {
			result.activity.userFeed.reverse();
			result.activity.userFeed = result.activity.userFeed.slice(0,4);
		}

		res.render('user/profile',  
			{ 
				title: result.profileUser.name.full.toLowerCase() + "'s profile", 
				user: req.user, 
				follows: result.follows,
				profile: result.profileUser, 
				recentActivity: result.activity,
				notProfileOwner: notProfileOwner, 
				isFollowing: result.isFollowing, 
				message: req.flash('profile-msg')
			}
		);
	});
};

exports.edit = function(req, res, next) {
	var form = {};
	form.name = {};
	var images_ids = {};
	var total_uploads;

	var busboy = new Busboy({ headers: req.headers });

	busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
	     
	    var stream = cloudinary.uploader.upload_stream(function(result) {
	    	if(result.public_id != undefined)
				images_ids[fieldname] = result.public_id;
		});
	      
	    file.on('data', stream.write).on('end',stream.end);
    });

	busboy.on('field', function(fieldname, val, fieldnameTruncated, valTruncated) {
		if (fieldname == 'total_uploads') total_uploads = parseInt(val);
		else if (fieldname == 'first') form.name.first = val;
		else if (fieldname == 'last') form.name.last = val; 
		else form[fieldname] = val;
   	});

   	req.pipe(busboy);

   	async.until(
   		function() {
   			return (total_uploads != undefined && Object.keys(images_ids).length == total_uploads);
   		}, 
   		function(callback) {
   			setTimeout(callback, 500);
   		},
   		function(err) {
   			_.each(images_ids, function(val, key) {
				form[key] = val;
			});
				
			var user = _.extend(req.user, form);
			user.updated = Date.now();
			
			user.save(function(err) {
				if(err) return next(err);

				return res.jsonp(200);
			});
   		}
   	);
};