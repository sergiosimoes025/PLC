
var async = require('async')

  , Message = require('../models/message');


exports.index = function(req, res, next) {
	Message
	.find({ user: req.user._id }, {'conversation': { $slice: -1 }})
	.populate('contact')
	.exec(function(err, messages) {
		if (err) return next(err);

		res.render('message/index', {
			title: 'messages',
			user: req.user,
			messages: messages
		});	
	});
};

exports.nav = function(req, res) {
	Message
	.find({ user: req.params.id }, {'conversation': { $slice: -1 }})
	.populate('contact')
	.exec(function(err, messages) {
		if (err) return next(err);
		res.jsonp(messages);	
	});
};

exports.conversation = function(req, res) {
	Message
	.findOne({ user: req.user._id, contact: req.params.id })
	.select('contact conversation')
	.populate('contact conversation.author', 'name picture')
	.exec(function(err, conversation) {
		if (err) return next(err);
		res.jsonp(conversation);
	});
};

exports.create = function(req, res, next) {
	async.parallel([
		function(callback) {
			Message.update(
				{ user: req.user._id, contact: req.params.id },
				{ 
					//subject: req.body.subject,
					$push: {
						conversation: {
							author: req.user._id,
							message: req.body.message
						}
					} 
				},
				{ upsert:true },
				callback
			);
		},
		function(callback) {
			Message.update(
				{ user: req.params.id, contact: req.user._id },
				{ 
					//subject: req.body.subject,
					$push: {
						conversation: {
							author: req.user._id,
							message: req.body.message
						}
					} 
				},
				{ upsert:true },
				callback
			);
		}
	], function(err, results) {
		if (err) return next(err);
		if (!results) res.jsonp(500)
		else res.jsonp(200);
	});
};