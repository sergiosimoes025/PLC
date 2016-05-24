
var _   	 = require('lodash')
  , async    = require('async')

  , Activity = require('../models/activity')
  , Follow   = require('../models/follow')
  , User     = require('../models/user');


exports.index = function(req, res, next) {
	if(!_.isUndefined(req.user)) {
		async.parallel({
			user: function(callback) {
				User
				.findOne({ _id: req.user._id })
				.lean()
				.populate('guides favorites')
				.exec(function(err, doc) {
					if(err) return next(err);
			    	User.populate(doc, {path:'favorites.author', model:'User'}, callback);
			    });
			},
			follow: function(callback) {
				Follow
				.findOne({ user: req.user._id })
				.populate('following')
				.exec(callback);
			}
		}, 
		function(err, result) {
			if (err) return next(err);

			if (_.isNull(result.follow) || _.isEmpty(result.follow.following)) {
				res.render('activity', { title: 'home', user: result.user, message: req.flash('index-msg') });
			} 
			else {
				feed(req.user._id, function(err, activities) {
					if (err) return next(err);			

					res.render('activity', { 
						title: 'activity', 
						user: result.user, 
						activities: activities,
						message: req.flash('index-msg')
					});
				});
			}
		});
	}
	else {
		res.render('landing', { title: 'welcome' });
	}
};

exports.create = function(action, next) {
	async.parallel([
		function(callback) {
			Follow
			.findOne({ user: action.author })
			.exec(function(err, user) {
				if (err) throw err;
				if(user && !_.isEmpty(user.followers)) {
					user.followers.forEach(function(followerId) {
						Activity.update(
							{ userId : followerId },
							{ $push  : { activityStream: action } },
							{ upsert: true },
							function(err, numAffected) {
								if (err) throw err;
							}
						);
					});
				}
				callback();
			});
		},
		function(callback) {
			Activity.update(
				{ userId : action.author },
				{ $push  : { userFeed: action } },
				{ upsert : true },
				callback
			);
		}
	], next);
};

function feed(id, callback) {
	Activity
	.findOne({ userId: id })
	.populate('activityStream.author activityStream.object')
	.exec(function(err, results) {
		if (results) results.activityStream.reverse();
		callback(err, results);
	});
};

exports.userfeed = function(id, callback) {
	Activity
	.findOne({ userId : id })
	.populate('userFeed.object')
	.limit(5)
	.exec(callback);
};