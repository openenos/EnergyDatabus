/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      Location services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
    var Location = function(tablePrefix){
       return require('../models/Location')(tablePrefix);
    };

    var createLocation = function(tablePrefix, geoAddr, lat, lng, postalcode, utility, callback){
    var LocationClass = Location(tablePrefix), newLocation = new LocationClass();
    newLocation.geoAddr = geoAddr;
    newLocation.lat = lat;
    newLocation.lng = lng;
    newLocation.postalcode = postalcode;
    newLocation.utility = utility;
    this.getLocationByAddr(tablePrefix, geoAddr, function(location){
      if(!location){
        newLocation.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'Location Creation ... '+err);
           } else { 
              callback("Location Created");
              winston.log('Info', 'Location Created ... ');
           } 
         });
        } else {
          callback("Location Exist");
          winston.log('Warn', 'Location Exist ... ');
        }
      }
    );
  },

deleteLocation = function(tablePrefix, locationId, callback){
  Location(tablePrefix).findByIdAndRemove(locationId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'Location is not deleted ... '+err);
   } else { 
      winston.log('info', 'Location deleted ... ');
   } 
 });
},
getLocation = function(tablePrefix, locationId, callback){
  Location(tablePrefix).findById(locationId,function(err, location) {
    if (err){
      callback(err);
      winston.log('Error', 'Location not found ... '+err);
    }
    if (location) {
      callback(location);
      winston.log('info', 'Location found ... '+location);
    }
  });
},
getLocationByCondition = function(tablePrefix, condition, callback){
  Location(tablePrefix).find(condition,function(err, location) {
    if (err){
      callback(err);
      winston.log('Error', 'getLocationByCondition ...'+err);
    }
    else if (location) {
      callback(location);
      winston.log('info', 'getLocationByCondition ... '+channel);
    }
    else {
      callback(null);
    }
  });
},

getLocationByCondition = function(tablePrefix, condition, callback){
  Location(tablePrefix).find(condition,function(err, location) {
    if (err){
      callback(err);
      winston.log('Error', 'get location by condition ... '+err);
    }
    else if (location) {
      callback(location);
      winston.log('info', 'get location by condition ... '+location);
    }
    else {
      callback(null);
    }
  });
},

getLocationByAddr = function(tablePrefix, geoAddr, callback){
  Location(tablePrefix).findOne({'geoAddr':geoAddr},function(err, location) {
    if (err){
      callback(err);
      winston.log('Error', 'get location by name ... '+err);
    }
    else if (location) {
      callback(location);
      winston.log('info', 'get location by name ... '+location);
    } else {
      callback(null);
    }
  });
},
getLocationList = function(tablePrefix, callback){
  Location(tablePrefix).find(function(err, location) {
    if (err){
      callback(err);
      winston.log('Error', 'Location list ... '+err);
    }
    if (location) {
      callback(location);
      winston.log('info', 'Location list ... '+location);
    }
  });
}


module.exports = 
{
  createLocation: createLocation,
  getLocation: getLocation,
  getLocationByAddr: getLocationByAddr,
  getLocationByCondition: getLocationByCondition,
  getLocationList: getLocationList,
  deleteLocation: deleteLocation
}
