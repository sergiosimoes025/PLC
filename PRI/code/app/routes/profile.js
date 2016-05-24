
var profile = require('../controllers/profile');


module.exports = function(app) {
	app.route('/profile/:id')
		.all(loginRequired)
		.get(profile.show);

	app.post('/account/edit-profile', loginRequired, profile.edit);
};


function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}