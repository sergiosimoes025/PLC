
var user = require('../controllers/user');


module.exports = function(app) {
	app.route('/account')
		.get(loginRequired, function(req, res) {
			res.render('user/account', { title: 'settings', user: req.user, message: req.flash('account-msg'), uploadData: { timestamp: Date.now(), signature: '213213', callback: req.headers.host } });
		});

	app.post('/account/change-password', loginRequired, user.changePassword)
	app.post('/account/delete', loginRequired, user.delete);

	app.route('/forgot')
		.post(user.forgot)
		.get(function(req, res) {
			res.render('user/forgot', { title: 'Forgot Password', message: req.flash('forgot-msg') });
		})

	app.route('/reset/:token')
		.post(user.reset)
		.get(function(req, res) {
			res.render('user/reset', { title: 'Reset Password', token: req.params.token });
		});
};


function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}
