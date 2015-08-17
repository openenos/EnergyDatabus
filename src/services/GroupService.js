/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      Group services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
    var Group = function(tablePrefix){
       return require('../models/Group')(tablePrefix);
    };

    var createGroup = function(tablePrefix, displayName, sites, callback){
    var GroupClass = Group(tablePrefix), newGroup = new GroupClass();
    newGroup.displayName = displayName;
    newGroup.sites = sites;
    this.getGroupByName(tablePrefix, displayName, function(group){
      if(!group){
        newGroup.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'Group Creation ... '+err);
           } else { 
              callback("Group Created");
              winston.log('Info', 'Group Created ... ');
           } 
         });
        } else {
          callback("Group Exist");
          winston.log('Warn', 'Group Exist ... ');
        }
      }
    );
  },

deleteGroup = function(tablePrefix, groupId, callback){
  Group(tablePrefix).findByIdAndRemove(groupId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'Group is not deleted ... '+err);
   } else { 
      winston.log('info', 'Group deleted ... ');
   } 
 });
},
getGroup = function(tablePrefix, groupId, callback){
  Group(tablePrefix).findById(groupId,function(err, group) {
    if (err){
      callback(err);
      winston.log('Error', 'Group not found ... '+err);
    }
    if (group) {
      callback(group);
      winston.log('info', 'Group found ... '+group);
    }
  });
},
getGroupByCondition = function(tablePrefix, condition, callback){
  Group(tablePrefix).find(condition,function(err, group) {
    if (err){
      callback(err);
      winston.log('Error', 'getGroupByCondition ...'+err);
    }
    else if (group) {
      callback(group);
      winston.log('info', 'getGroupByCondition ... '+group);
    }
    else {
      callback(null);
    }
  });
},
getGroupByName = function(tablePrefix, displayName, callback){
  Group(tablePrefix).findOne({'displayName':displayName},function(err, group) {
    if (err){
      callback(err);
      winston.log('Error', 'get group by name ... '+err);
    }
    else if (group) {
      callback(group);
      winston.log('info', 'get group by name ... '+group);
    }else {
      callback(null);
    }
  });
},
getGroupList = function(tablePrefix, callback){
  Group(tablePrefix).find(function(err, group) {
    if (err){
      callback(err);
      winston.log('Error', 'Group list ... '+err);
    }
    if (group) {
      callback(group);
      winston.log('info', 'Group list ... '+group);
    }
  });
}


module.exports = 
{
  createGroup: createGroup,
  getGroup: getGroup,
  getGroupByName: getGroupByName,
  getGroupByCondition: getGroupByCondition,
  getGroupList: getGroupList,
  deleteGroup: deleteGroup
}
