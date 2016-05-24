
var activity = require('../controllers/activity')
  , explore  = require('../controllers/explore')
  , search   = require('../controllers/search')
  , feedback = require('../controllers/feedback');


module.exports = function(app) {

	app.route('/')
		.get(activity.index);	

	app.route('/feedback')
		.all(loginRequired)
		.post(feedback.create);

	app.route('/explore')
		.all(loginRequired)
		.get(explore.popular);

	app.route('/search/:query')
		.all(loginRequired)
		.post(search.find);
};

function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}