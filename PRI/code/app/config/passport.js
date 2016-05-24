
var LocalStrategy = require('passport-local');

var user = { 
	'controller': require('../controllers/user'),
 	'model': require('../models/user')
};


module.exports = function(passport) {

	passport.use('local-register', new LocalStrategy({
			usernameField: 'email',
			passwordField: 'password',
			passReqToCallback: true
		},
		user.controller.register
	));
	
	passport.use('local-login', new LocalStrategy({
			usernameField: 'email',
			passwordField: 'password',
			passReqToCallback: true
		}, 
		user.controller.login
	));

	passport.serializeUser(function(user, done) {
		done(null, user.id);
	});

	passport.deserializeUser(function(id, done) {
		user.model.findById(id, function(err, user) {
			done(err, user);
		});
	});
}