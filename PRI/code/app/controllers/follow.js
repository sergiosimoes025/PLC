
var async = require('async')
  , _     = require('lodash')

  , activity = require('../controllers/activity')

  , Follow  = require('../models/follow')
  , Activity = require('../models/activity');
  


exports.create = function(req, res, next) {
	var followerId = req.user._id;
	var followeeId = req.params.id;

	async.parallel([
		function(callback) {
			Follow.update(
				{ user: followerId },
				{ $push: { following: followeeId } },
				{ upsert: true },
				callback
			);
		},
		function(callback) {
			Follow.update(
				{ user: followeeId },
				{ $push: { followers: followerId } },
				{ upsert: true },
				callback
			);
		},
		function(callback) {
			var activities = [];
			Activity.findOne({ userId: req.params.id }, function(err, doc) {
				if (err) return next(err);
				if(doc) {
					_.each(doc.userFeed, function(val, key) {
						val = _.extend(val, { 'author' : req.params.id });
						console.log(val);
						activities.push(val);
					});
					Activity.update(
						{ userId : req.user._id },
						{ $pushAll : { activityStream: activities } },
						{ upsert : true },
						callback
					);
				}
				else {
					callback();
				}
			});
		}
	], function(err, results) {
		if (err) return next(err); // do better error handling and feedback for user
		
		res.json(200);
	});
};

exports.delete = function(req, res, next) {
	var followerId = req.user._id;
	var followeeId = req.params.id;

	async.parallel([
		function(callback) {
			Follow.update(
				{ user: followerId },
				{ $pull: { following: followeeId } },
				callback
			);
		},
		function(callback) {
			Follow.update(
				{ user: followeeId },
				{ $pull: { followers: followerId } },
				callback
			);
		},
		function(callback) {
			Activity.update(
				{ userId: followerId },
				{'$pull': { 'activityStream': { 'author': req.params.id } }}, 
				{ safe:true }, 
				callback
			);
		}
	], function(err, results) {
		if (err) return next(err); // do better error handling and feedback for user
		res.json(200);
	});
};

exports.followers = function(req, res, next) {
	Follow.findOne({ user: req.params.id })
	.populate('followers')
	.exec(function(err, results) {
		if (err) return next(err);
		if (!_.isEmpty(results)) res.json(results.followers);
	});
};

exports.following = function(req, res, next) {
	Follow.findOne({ user: req.params.id })
	.populate('following')
	.exec(function(err, results) {
		if (err) return next(err);
		if (!_.isEmpty(results)) res.json(results.following);
	});
};

exports.isFollowing = function(userId, profileUserId, callback) {
	Follow.find({ user: userId, following: profileUserId }, function(err, result) {
		// Testar _.isEmpty()
		callback(null, typeof result !== 'undefined' && result.length > 0);   // TROCAR NULL POR ERR... TESTAR
	});
};