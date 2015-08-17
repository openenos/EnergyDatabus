/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      user services - basic crud operations
 !**/
 
var mongoose = require('../config/mongo'),
    User = require('../models/User'),
    crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
//encrypt password    
function encrypt(password){
  var cipher = crypto.createCipher(algorithm,password)
  var crypted = cipher.update(password,'utf8','hex')
  return crypted;
}

var createHash = function(password){
 return encrypt(password);
},
isValidPassword = function(user, password){
  return createHash(password) === user.password;
},
createUser = function(username, password, apikey, tableprefix, callback){
    var newUser = new User();
    newUser.username = username;
    newUser.password = createHash(password);
    newUser.apiKey = apikey;
    newUser.tableNamePrefix = tableprefix;
    this.getUserByName(username, function(user){
      if(!user){
        newUser.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'User creation ... '+err);
           } else { 
              callback("User Created");
              require("../helpers/generateUserSchema")(tableprefix);
              winston.log('Info', 'User created ... ');
           } 
         });
        } else {
          callback("User Exist");
          winston.log('Warn', 'User exist ... ');
        }
      }
    );
  },
deleteUser = function(userid, callback){
  User.findByIdAndRemove(userid, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'User is not deleted ... '+err);
   } else { 
      callback("User Deleted");
      winston.log('info', 'User deleted ... ');
   } 
 });
},
getUser = function(userid, callback){
  User.findById(userid,function(err, user) {
    if (err){
      callback(err);
      winston.log('Error', 'User not found ... '+err);
    }
    if (user) {
      callback(user);
      winston.log('info', 'User found ... '+user);
    }
  });
},
getUserByName = function(username, callback){
  User.findOne({'username':username},function(err, user) {
    if (err){
      callback(err);
      winston.log('Error', 'User not found ... '+err);
    }
    else if (user) {
      callback(user);
      winston.log('info', 'User found ... '+user);
    } else {
      callback(null);
    }
  });
},
getUserList = function(callback){
  User.find(function(err, users) {
    if (err){
      callback(err);
      winston.log('Error', 'User list ... '+err);
    }
    if (users) {
      callback(user);
      winston.log('info', 'User list ... '+user);
    }
  });
},
getUserByCondition = function(tablePrefix, condition, callback){
  User(tablePrefix).find(condition,function(err, user) {
    if (err){
      callback(err);
      winston.log('Error', 'get user by condition ... '+err);
    }
    else if (user) {
      callback(user);
      winston.log('info', 'get user by condition ... '+user);
    }
    else {
      callback(null);
    }
  });
},
checkLogin = function(req, username, password, done){
 var callback = function(err, user){
   if (err)
   { 
    return done(err); 
   }
    if (!user){
      //console.log('User Not Found with username '+username);
      winston.log('Error', 'User Not found.');                         
      return done(null, false, req.flash('message', 'User Not found.'));         
    }
    if (!isValidPassword(user, password)){
      //console.log('Invalid Password');
      winston.log('Error', 'Invalid Password.');
      return done(null, false, req.flash('message', 'Invalid Password'));
    }
    return done(null, user);
 }
 this.getUserByName(username, callback);
};


module.exports = 
{
  createUser: createUser,
  getUser: getUser,
  getUserByName: getUserByName,
  getUserByCondition: getUserByCondition,
  getUsersList: getUserList,
  checkLogin: checkLogin,
  deleteUser: deleteUser
}
