
var uuid   = require('node-uuid')
  , mailer = require('nodemailer')

  , User = require('../models/user');


// clean 'forgot password' controller (async waterfall?)

exports.login = function(req, email, password, next) {
	User.findOne({ email: email }, function(err, user) {
		if (err) return next(err);

		if (!user) 
			return next(null, false, req.flash('login-msg', 'Incorrect e-mail'));

		if (!user.validatePassword(password)) 
			return next(null, false, req.flash('login-msg', 'Incorrect password'));
				
		return next(null, user);	
	});
};

exports.register = function(req, email, password, next) {
	User.findOne({ email: email }, function(err, user) {
		if (err) return next(err);

		if (user)
			return next(null, false, req.flash('register-msg', 'That e-mail is already taken'));
		else {
			var newUser      = new User(req.body);
			newUser.password = newUser.generateHash(password);

			newUser.save(function(err) {
				if (err)
					for(var item in err.errors)
						return next(null, false, req.flash('register-msg', err.errors[item].message));
							
				return next(null, newUser);
			});
		}
	});
};

exports.forgot = function(req, res, next) {
	var email = req.body.email;

	User.findOne({ email: email }, function(err, user) {
		if (err) return next(err);

		if (!user) {
			req.flash('forgot-msg', 'No user with that e-mail address exists');
			return res.redirect('back');
		}

		user.reset = { token: uuid.v4(), expire: Date.now() + 3600000 };
		
		user.save(function(err) {
			if (err) return next(err);
			
			var smtpTransport = mailer.createTransport('SMTP', {
				service: 'Gmail', // should be SENDGRID
				auth: {
					user: process.env.EMAIL_USER || process.env.SENDGRID_USERNAME,
					pass: process.env.EMAIL_PASS || process.env.SENDGRID_PASSWORD
				}
			});

			var mailOptions = {
				to: user.email,
				from: 'admin@pigero.com',
				subject: 'Pigero password reset',
				text: 'Please follow the link to reset your password:\n'+
					  'http://'+ req.headers.host +'/reset/'+ user.reset.token +'\n'
			};

			smtpTransport.sendMail(mailOptions, function(err) {
				if (err) return next(err);

				smtpTransport.close();
				
				req.flash('forgot-msg', 'An e-mail has been sent to '+ email +' with further instructions');
				return res.redirect('back');
			});
		});
	});
};

exports.reset = function(req, res, next) {
	User.findOne({ 
		'reset.token'  : req.params.token, 
		'reset.expire' : { $gt: Date.now() } 
	}, function(err, user) {
		if (err) return next(err);

		if (!user) {
			req.flash('forgot-msg', 'Password reset token is invalid or has expired');
			return res.redirect('/forgot');
		}

		user.reset = { token: undefined, expired: undefined };
		user.password = user.generateHash(req.body.newPassword);

		user.save(function(err) {
			if (err) return next(err);

			req.flash('login-msg', 'Password reset successfully. You can now log in.');
			return res.redirect('/login');
		});
	});
};

exports.changePassword = function(req, res, next) {
	req.user.changePassword(req.body.oldPassword, req.body.newPassword, function(err, user) {
		if (err) return next(err);
		
		req.flash('account-msg', 'Password changed successfully');
		res.redirect('back');
	});
};

exports.delete = function(req, res, next) {
	var user = req.user;	
	user.remove(function(err) {
		if (err) return next(err);
		
		req.logout();
		res.redirect('/');
	});
};