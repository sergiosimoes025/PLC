	

module.exports = function(app, passport) {
	app.route('/register')
		.get(function(req, res) {
			res.render('user/register', {
				title: 'sign up', 
				message: req.flash('register-msg') 
			});
		})
		.post(passport.authenticate('local-register', {
			successRedirect: '/',
			failureRedirect: '/register',
			failureFlash: true
		}));
		
	app.route('/login')
		.get(function(req, res) {
			res.render('user/login', { 
				title: 'login', 
				message: req.flash('login-msg') 
			});
		})
		.post(passport.authenticate('local-login', {
			successRedirect: '/',
			failureRedirect: '/login',
			failureFlash: true
		}));

	app.route('/logout')
		.get(function(req, res) {
			req.logout();
			req.session.destroy();
			res.redirect('/');
		});
};
