
var Feedback = require('../models/feedback');

exports.create = function(req, res, next) {
	var feedback = new Feedback(req.body);
	feedback.user = req.user._id;

	feedback.save(function(err) {
		if (err) {
			return next(err);
		}

		return res.jsonp(200);
	});
};