
var message = require('../controllers/message');


module.exports = function(app) {

	app.route('/messages')
		.all(loginRequired)
		.get(message.index);

	app.route('/messages/:id')
		.all(loginRequired)
		.get(message.nav);

	app.route('/messages/conversation/:id')
		.all(loginRequired)
		.get(message.conversation);

	app.route('/messages/create/:id')
		.all(loginRequired)
		.post(message.create);
};


function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}