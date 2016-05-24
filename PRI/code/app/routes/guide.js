
var guide = require('../controllers/guide');


module.exports = function(app) {
	app.route('/guide/create')
		.all(loginRequired)
		.post(guide.create)
		.get(guide.create);

	app.route('/guide/:id')
		.all(loginRequired)
		.get(guide.show);

	app.route('/guide/:id/edit')
		.all(loginRequired)
		.post(guide.edit)
		.get(guide.edit);

	app.route('/guide/:id/delete')
		.all(loginRequired)
		.get(guide.delete);

	app.route('/guide/:id/vote/:score')
		.all(loginRequired)
		.post(guide.vote);

	app.route('/guide/:id/favorite')
		.all(loginRequired)
		.post(guide.favorite);

	app.route('/guide/:id/review')
		.all(loginRequired)
		.post(guide.review);
};


function loginRequired(req, res, next) {
	if (req.isAuthenticated())
		return next();

	res.redirect('/login');
}