/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      LoadType services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
    var LoadType = function(tablePrefix){
       return require('../models/ElecLoadType')(tablePrefix);
    };
    
    var createLoadType = function(tablePrefix, displayName, loadType, callback){
    var LoadTypeClass = LoadType(tablePrefix), newLoadType = new LoadTypeClass();
    newLoadType.displayName = displayName;
    newLoadType.loadType = loadType;
    this.getElecLoadByType(tablePrefix, loadType, function(loadTypeArg){
      if(!loadTypeArg){
        newLoadType.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'LoadType Creation ... '+err);
           } else { 
              callback("LoadType Created");
              winston.log('Info', 'LoadType Created ... ');
           } 
         });
        } else {
          callback("LoadType Exist");
          winston.log('Warn', 'LoadType Exist ... ');
        }
      }
    );
  },

deleteLoadType = function(tablePrefix, loadTypeId, callback){
  LoadType(tablePrefix).findByIdAndRemove(loadTypeId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'LoadType is not deleted ... '+err);
   } else { 
      winston.log('info', 'LoadType deleted ... ');
   } 
 });
},
getLoadType = function(tablePrefix, loadTypeId, callback){
  LoadType(tablePrefix).findById(loadTypeId,function(err, loadType) {
    if (err){
      callback(err);
      winston.log('Error', 'LoadType not found ... '+err);
    }
    if (loadType) {
      callback(loadType);
      winston.log('info', 'LoadType found ... '+loadType);
    }
  });
},
getElecLoadByCondition = function(tablePrefix, condition, callback){
  LoadType(tablePrefix).find(condition,function(err, loadType) {
    if (err){
      callback(err);
      winston.log('Error', 'getElecLoadByCondition ...'+err);
    }
    else if (loadType) {
      callback(loadType);
      winston.log('info', 'getElecLoadByCondition ... '+loadType);
    }
    else {
      callback(null);
    }
  });
},
getElecLoadByType = function(tablePrefix, loadType, callback){
  LoadType(tablePrefix).findOne({'loadType':loadType},function(err, loadType) {
    if (err){
      callback(err);
      winston.log('Error', 'get loadType by name ... '+err);
    }
    else if (loadType) {
      callback(loadType);
      winston.log('info', 'get loadType by name ... '+loadType);
    } else {
      callback(null);
    }
  });
},
getLoadTypeList = function(tablePrefix, callback){
  LoadType(tablePrefix).find(function(err, loadType) {
    if (err){
      callback(err);
      winston.log('Error', 'LoadType list ... '+err);
    }
    if (loadType) {
      callback(loadType);
      winston.log('info', 'LoadType list ... '+loadType);
    }
  });
}


module.exports = 
{
  createLoadType: createLoadType,
  getLoadType: getLoadType,
  getElecLoadByType: getElecLoadByType,
  getElecLoadByCondition: getElecLoadByCondition,
  getLoadTypeList: getLoadTypeList,
  deleteLoadType: deleteLoadType
}
