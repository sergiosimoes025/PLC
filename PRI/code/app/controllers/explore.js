
var Guide = require('../models/guide');


exports.popular = function(req, res, next) {
	Guide
	.find({})
	.populate('author')
	.sort({ avg: -1 })
	.limit(5)
	.exec(function(err, results) {
		return res.render('explore', { title: 'explore', user: req.user, popular: results });
	});
};
