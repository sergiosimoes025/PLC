
var _ 		 = require('lodash');
var _s 	     = require('underscore.string');
var moment   = require('moment');
var momentTz = require('moment-timezone');


module.exports = function(hbs) {
	hbs.registerHelper('formatDate', function(date) {
		return moment(date).format('MMMM Do YYYY, [at] h:mm a');
 	});

 	hbs.registerHelper('formatShort', function(date) {
		return moment(date).format('MMMM Do, YYYY');
 	});

 	hbs.registerHelper('upperCase', function(string) {
 		return _s.capitalize(string);
 	});

 	hbs.registerHelper('formatTimezone', function(created) {
		return momentTz(Date.parse(created)).fromNow(); 
 	});

 	hbs.registerHelper('trimString', function(passedString, range) {
 		if( passedString && passedString.length > range)
 			var trimmedString = passedString.substring(0,range) + '..';
 		else
 			var trimmedString = passedString;
	    return new hbs.SafeString(trimmedString);
	});
};
