
var follow = require('../controllers/follow');


module.exports = function(app) {
	app.route('/follow/:id')
		.all(loginRequired)
		.post(follow.create);

	app.route('/unfollow/:id')
		.all(loginRequired)
		.post(follow.delete);

	app.route('/followers/:id')
		.all(loginRequired)
		.get(follow.followers);

	app.route('/following/:id')
		.all(loginRequired)
		.get(follow.following);
};


function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}