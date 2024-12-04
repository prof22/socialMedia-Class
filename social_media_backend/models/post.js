const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
    content:{
        type: String,
        required: true
    },
    images:[{type:String}], //Array of image url sent from the frontend
    createdBy:{
        type:mongoose.Schema.Types.ObjectId,
        ref:"User",
        required:true,
    },
    likes:[
        {
            type:mongoose.Schema.Types.ObjectId,
            ref:"User"
        }
    ],
    createdAt:{
        type:Date,
        default:Date.now
    }
});
module.exports = mongoose.model('Post', postSchema)