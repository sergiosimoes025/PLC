
var mongoose = require('mongoose'),
	Schema   = mongoose.Schema;


// change lat and long for location = { address, lat, lon }

var guideSchema = Schema({
	author      : { type: Schema.ObjectId, ref: 'User' },
	title		: { type: String, index: 'text', trim: true },
	description	: { type: String, trim: true },
	category	: { type: String },
	slug		: { type: String, index: 'text' },
	avg 		: { type: Number, default: 0.0 },
	places : [
		{ 
			picture     : { type: String },
			lng 		: { type: Number },
			lat 		: { type: Number },
			description : { type: String, trim: true },
			title	    : { type: String, trim: true }
		}
	],
	votes : [	
		{
			voter : { type: Schema.ObjectId, ref: 'User'},
			score : { type: Number, default: 0 }
		}
	],
	reviews : [
		{
			reviewer : { type: Schema.ObjectId, ref: 'User'},
			headline : { type: String, trim: true },
			text 	 : { type: String, trim: true },
			score 	 : { type: Number, default: 0 },
			created  : { type: Date, default: Date.now },
			updated  : { type: Date, default: Date.now }
		}
	],
	favorites : [{ type: Schema.ObjectId, ref: 'User' }],
	created   : { type: Date, required: true, default: Date.now },
	updated	  : { type: Date, required: true, default: Date.now }
});


guideSchema
.virtual('votecount')
.get(function() {
	return this.votes.length;
});

guideSchema
.virtual('favoritecount')
.get(function() {
	return this.favorites.length;
});

guideSchema
.virtual('absolute')
.get(function() {
	return this.title;
});


module.exports = mongoose.model('Guide', guideSchema);