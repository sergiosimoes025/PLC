
if(process.env.NODE_ENV == 'production') {
  require('newrelic');
  var nodetime = require('nodetime').profile({
    accountKey: process.env.NODETIME_ACCOUNT_KEY 
  });
}


/**
 * Core Module dependencies
 */

var app      = require('express')()
  , morgan   = require('morgan')
  , session  = require('express-session')
  , error    = require('errorhandler')
  , bodyParser 	   = require('body-parser')
  , methodOverride = require('method-override')
  , cookieParser   = require('cookie-parser')
  , servestatic    = require('serve-static')
  , favicon        = require('serve-favicon')
  , compress       = require('compression')
  , csrf           = require('csurf')
  , path           = require('path');


/**
 * 3rd-Party Module dependencies
 */

var mongoose   = require('mongoose')
  , passport   = require('passport')
  , hbs        = require('express-hbs')
  , helmet     = require('helmet')
  , flash      = require('connect-flash')
  , RedisStore = require('connect-redis')(session);


/**
 * Database & Passport configuration
 */

require('./app/config/passport')(passport);

var database = require('./app/config/database');
mongoose.connect(database.mongodb[app.get('env')]);
mongoose.set('debug', false);


/**
 * All environments
 */
 
app.engine('hbs', hbs.express3({ 
    defaultLayout: __dirname + '/views/_layouts/base'
    //partialsDir: __dirname + '/views/_partials',
}));
app.enable('view cache');
app.set('view engine', 'hbs');
require('./app/config/hbs')(hbs);

app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));

app.use(morgan('dev'));
app.use(favicon(__dirname + '/public/images/favicon.ico'));
app.use(compress());
app.use(bodyParser());

app.use(helmet.xframe());
app.use(helmet.iexss());
app.use(helmet.contentTypeOptions());
app.use(helmet.cacheControl());

app.use(methodOverride());
app.use(cookieParser());
app.use(session({
  store  : new RedisStore({
    url  : database.redis[app.get('env')]
  }),
	secret : 'd00e208f-6e3a-440a-bf45-1c58a25428b8',
	cookie : { 
    maxAge   : 7 * 24 * 3600 * 1000,
    httpOnly : true 
  }
}));

app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

app.use(csrf());
app.use(function (req, res, next) {
    res.cookie('X-CSRF-Token', req.csrfToken());
    res.locals.csrftoken = req.csrfToken();
    next();
});

app.use(servestatic(path.join(__dirname, 'public')));


/**
 * App Routes
 */
 
app.get('/about', function(req, res) {
  res.render('about', { title: 'about' });
}); 

app.get('/privacy', function(req, res) {
  res.render('privacy', { title: 'privacy policy' });
});

require('./app/routes/passport')(app, passport);
require('./app/routes/index')(app);
require('./app/routes/user')(app);
require('./app/routes/profile')(app);
require('./app/routes/guide')(app);
require('./app/routes/message')(app);
require('./app/routes/follow')(app);

/**
 * Error handling
 */

if(app.get('env') == 'production') {
  app.use(error({ dumpExceptions: true, showStack: false }));
}
else {
  app.use(error({ dumpExceptions: true, showStack: true }));
}

app.get('*', function(req, res) {
  res.redirect('/');
});


/**
 * Start server
 */

app.listen(app.get('port'));
console.log('Express server listening on port ' + app.get('port'));
