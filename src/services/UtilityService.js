/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      Utility services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
    var Utility = function(tablePrefix){
       return require('../models/Utility')(tablePrefix);
    };
    
    createUtility = function(tablePrefix, displayName, utilityType, baseRate, demand, tier1Rate, tier2Rate, tier3Rate, tier4Rate, callback){
    var UtilityClass = Utility(tablePrefix), newUtility = new UtilityClass();
    newUtility.displayName = displayName;
    newUtility.utilityType = utilityType;
    newUtility.baseRate = baseRate;
    newUtility.demand = demand;
    newUtility.tier1Rate = tier1Rate;
    newUtility.tier2Rate = tier2Rate;
    newUtility.tier3Rate = tier3Rate;
    newUtility.tier4Rate = tier4Rate;
    this.getUtilityByType(tablePrefix, utilityType, function(utility){
      if(!utility){
        newUtility.save(function(err) { 
          if(err){ 
              callback(err);
              winston.log('Error', 'Utility Creation ... '+err);
           } else { 
              callback("Utility Created");
              winston.log('Info', 'Utility Created ... ');
           } 
         });
        } else {
          callback("Utility Exist");
          winston.log('Warn', 'Utility Exist ... ');
        }
      }
    );
  },

deleteUtility = function(tablePrefix, utilityId, callback){
  Utility(tablePrefix).findByIdAndRemove(utilityId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'Utility is not deleted ... '+err);
   } else { 
      winston.log('info', 'Utility deleted ... ');
   } 
 });
},
getUtility = function(tablePrefix, utilityId, callback){
  Utility(tablePrefix).findById(utilityId,function(err, utility) {
    if (err){
      callback(err);
      winston.log('Error', 'Utility not found ... '+err);
    } 
    if (utility) {
      callback(utility);
      winston.log('info', 'Utility found ... '+utility);
    } 
  });
},
getUserByCondition = function(tablePrefix, condition, callback){
  Utility(tablePrefix).find(condition,function(err, utility) {
    if (err){
      callback(err);
      winston.log('Error', 'get utility by condition ... '+err);
    }
    else if (utility) {
      callback(utility);
      winston.log('info', 'get utility by condition ... '+utility);
    }
    else {
      callback(null);
    }
  });
},
getUtilityByType = function(tablePrefix, utilityType, callback){
  Utility(tablePrefix).findOne({'utilityType': utilityType},function(err, utility) {
    if (err){
      callback(err);
      winston.log('Error', 'get utility by name ... '+err);
    }
    else if (utility) {
      callback(utility);
      winston.log('info', 'get utility by name ... '+utility);
    } else {
      callback(null);
    }
  });
},
getUtilityList = function(tablePrefix, callback){
  Utility(tablePrefix).find(function(err, utility) {
    if (err){
      callback(err);
      winston.log('Error', 'Utility list ... '+err);
    }
    if (utility) {
      callback(utility);
      winston.log('info', 'Utility list ... '+utility);
    }
  });
}


module.exports = 
{
  createUtility: createUtility,
  getUtility: getUtility,
  getUtilityByType: getUtilityByType,
  getUserByCondition: getUserByCondition,
  getUtilityList: getUtilityList,
  deleteUtility: deleteUtility
}
