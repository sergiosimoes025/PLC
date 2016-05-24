
var mongoose = require('mongoose'),
	Schema   = mongoose.Schema;

var feedbackSchema = Schema({
	user: { type: Schema.ObjectId, ref: 'User' },
	subject: { type: String, required: true },
	text: { type: String, required: true },
	created: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Feedback', feedbackSchema);