
var activity = require('../controllers/activity');


module.exports = function(app) {
	app.route('/activity/:id')
		.all(loginRequired)
		.get(activity.feed);
};


function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}