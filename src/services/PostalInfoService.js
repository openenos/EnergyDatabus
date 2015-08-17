/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      PostalInfo services - basic crud operations
 !**/

var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
    var PostalInfo = function(tablePrefix){
       return require('../models/PostalInfo')(tablePrefix);
    };

    var createPostalInfo = function(tablePrefix, postalCode, city, state, country, timezone, weatherRef, callback){
    var PostalInfoClass = PostalInfo(tablePrefix), newPostalInfo = new PostalInfoClass();
    newPostalInfo.postalCode = postalCode;
    newPostalInfo.city = city;
    newPostalInfo.state = state;
    newPostalInfo.country = country;
    newPostalInfo.timezone = timezone;
    newPostalInfo.weatherRef = weatherRef;
    this.getPostalInfoByCode(tablePrefix, postalCode, function(postalInfo){
      if(!postalInfo){
        //console.log(newPostalInfo);
        newPostalInfo.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'PostalInfo Creation ... '+err);
           } else { 
              callback("PostalInfo Created");
              winston.log('Info', 'PostalInfo Created ... ');
           } 
         });
        } else {
          callback("PostalInfo Exist");
          winston.log('Warn', 'PostalInfo Exist ... ');
        }
      }
    );
  },

deletePostalInfo = function(tablePrefix, postalInfoId, callback){
  PostalInfo(tablePrefix).findByIdAndRemove(postalInfoId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'PostalInfo is not deleted ... '+err);
   } else { 
      winston.log('info', 'PostalInfo deleted ... ');
   } 
 });
},
getPostalInfo = function(tablePrefix, postalInfoId, callback){
  PostalInfo(tablePrefix).findById(postalInfoId,function(err, postalInfo) {
    if (err){
      callback(err);
      winston.log('Error', 'PostalInfo not found ... '+err);
    }
    if (postalInfo) {
      callback(postalInfo);
      winston.log('info', 'PostalInfo found ... '+postalInfo);
    }
  });
},
getPostalInfoByCode = function(tablePrefix, postalCode, callback){
  PostalInfo(tablePrefix).findOne({'postalCode':postalCode},function(err, postalInfo) {
    if (err){
      callback(err);
      winston.log('Error', 'get postalInfo by name ... '+err);
    }
    else if (postalInfo) {
      callback(postalInfo);
      winston.log('info', 'get postalInfo by name ... '+postalInfo);
    } else {
      callback(null);
    }
  });
},
getPostalInfoByCondition = function(tablePrefix, condition, callback){
  PostalInfo(tablePrefix).find(condition,function(err, postalInfo) {
    if (err){
      callback(err);
      winston.log('Error', 'get postalInfo by condition ... '+err);
    }
    else if (postalInfo) {
      callback(postalInfo);
      winston.log('info', 'get postalInfo by condition ... '+postalInfo);
    }
    else {
      callback(null);
    }
  });
},
getPostalInfoList = function(tablePrefix, callback){
  PostalInfo(tablePrefix).find(function(err, postalInfo) {
    if (err){
      callback(err);
      winston.log('Error', 'PostalInfo list ... '+err);
    }
    if (postalInfo) {
      callback(postalInfo);
      winston.log('info', 'PostalInfo list ... '+postalInfo);
    }
  });
}


module.exports = 
{
  createPostalInfo: createPostalInfo,
  getPostalInfo: getPostalInfo,
  getPostalInfoByCode: getPostalInfoByCode,
  getPostalInfoByCondition: getPostalInfoByCondition,
  getPostalInfoList: getPostalInfoList,
  deletePostalInfo: deletePostalInfo
}
