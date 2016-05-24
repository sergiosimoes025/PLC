
var mongoose = require('mongoose'),
	Schema   = mongoose.Schema;


var activitySchema = Schema({
	userId   : { type: Schema.ObjectId, ref: 'User' },
	userFeed : [{
		author   : { type: Schema.ObjectId, ref: 'User' },
		verb     : { type: String },
		object   : { type: Schema.ObjectId, ref: 'Guide' },
		sentence : { type: String },
		created  : { type: Date, default: Date.now }
	}],
	activityStream : [{
		author   : { type: Schema.ObjectId, ref: 'User' },
		verb     : { type: String },
		object   : { type: Schema.ObjectId, ref: 'Guide' },
		sentence : { type: String },
		created  : { type: Date, default: Date.now }
	}]
});


module.exports = mongoose.model('Activity', activitySchema);

// VERSION 1
// *USER* <created a new guide> *GUIDE*
// *USER* <is now following>    *USER*
// *USER* <favorited> 			*USER*  <'s guide> 						*GUIDE*
// *USER* <wrote a review on> 	*USER*  <'s guide> 					    *GUIDE*
// *USER* <rated> 				*USER*  <'s guide> 						*GUIDE*
// *USER* <'s>				    *GUIDE* <guide has been promoted by>	*STAFF*

/* CHANGES HAS TO BE MADE (SEE PAPER)
var activitySchema = Schema({
	userId : { type: Schema.ObjectId, ref: 'User', index: true },
	activityStream : [{
		author  : { type: Schema.ObjectId, ref: 'User', index: true },
		verb    : { type: String, required: true },
		object  : { type: Schema.ObjectId },
		target  : { type: Schema.ObjectId },
		created : { type: Date, default: Date.now, index: true }
	}]
});
*/

// VERSION 2
// *USER* <created> 			  *GUIDE* <as a new journey>
// *USER* <marked> 				  *GUIDE* <as a favorite>
// *USER* <wrote a review> 	      *GUIDE* <with X stars>
// *USER* <rated> 				  *GUIDE* <X stars>
// *USER* <'s journey>		      *GUIDE* <has been promoted by staff picks>

/*
var activitySchema = Schema({
	userId : { type: Schema.ObjectId, ref: 'User', index: true },
	activityStream : [{
		author  : { type: Schema.ObjectId, ref: 'User', index: true },
		verb    : { type: String, required: true },
		object  : { type: Schema.ObjectId, ref: 'Guide' },
		extra   : { type: Schema.ObjectId },
		created : { type: Date, default: Date.now, index: true }
	}]
});
*/
