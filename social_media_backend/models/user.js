const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");

const userSchema = new mongoose.Schema({
    username:{
        type: String,
        required: true,
        unique:true
    },
    email:{
        type:String,
        required:true,
        unique:true
    },
    password:{
        type: String,
        required:true
    },
    firstname: {
        type:String, 
        default: ''
    },
    lastname: {
        type:String, 
        default: ''
    },
    bio: {
      type:String, 
      default: ''
  },
  profilePicture: {
    type:String, 
    default: ''
},
    followers:[
      {
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
      }  
    ],
    following:[
        {
          type:mongoose.Schema.Types.ObjectId,
          ref:'User'
        }  
      ],
      isOnline:{
        type: Boolean,
        default:false
      },
      lastSeen:{
        type: Date,
        default:Date.now
      },
      socketid:{
        type: String,
        default:null
      },
});

//Hash the password before Saving
userSchema.pre('save', async function(next){
    if(!this.isModified('password')) return next();
    this.password = await bcrypt.hash(this.password, 10);
    next();
});

//Method to match password
userSchema.methods.matchPassword = async function(enteredPassword){
    return await bcrypt.compare(enteredPassword, this.password);
};

// Check if the model already exists before defining it
const User = mongoose.models.User || mongoose.model('User', userSchema);

module.exports = User;