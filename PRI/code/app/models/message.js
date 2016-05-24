
var mongoose = require('mongoose'),
	Schema   = mongoose.Schema;


var messageSchema = Schema({
	user 	: { type: Schema.ObjectId, ref: 'User', index: true },
	contact : { type: Schema.ObjectId, ref: 'User', index: true },
	//subject : { type: String, trim: true},
	conversation: [{
		author:  { type: Schema.ObjectId, ref: 'User', index: true },
		message: { type: String, trim: true },
		created: { type: Date, default: Date.now }
	}]
});



module.exports = mongoose.model('Message', messageSchema);