/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      Site services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';

    var Site = function(tablePrefix){
       return require('../models/Site')(tablePrefix);
    };
    
    var createSite = function(tablePrefix, siteRef, displayName, yearBuilt, operatingHours, areaGrossSquareFoot, areaCondSquareFoot, location, panels, callback){
    var SiteClass = Site(tablePrefix), newSite = new SiteClass();
    newSite.displayName = displayName;
    newSite.siteRef = siteRef;
    newSite.yearBuilt = yearBuilt;
    newSite.operatingHours = operatingHours;
    newSite.areaGrossSquareFoot = areaGrossSquareFoot;
    newSite.areaCondSquareFoot = areaCondSquareFoot;
    newSite.location = location;
    newSite.panels = panels;
    this.getSiteByRef(tablePrefix, siteRef, function(site){
      if(!site){
        newSite.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'Site Creation ... '+err);
           } else { 
              callback("Site Created");
              winston.log('Info', 'Site Created ... ');
           } 
         });
        } else {
          callback("Site Exist");
          winston.log('Warn', 'Site Exist ... ');
        }
      }
    );
  },

deleteSite = function(tablePrefix, siteId, callback){
  Site(tablePrefix).findByIdAndRemove(siteId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'Site is not deleted ... '+err);
   } else { 
      winston.log('info', 'Site deleted ... ');
   } 
 });
},
getSite = function(tablePrefix, siteId, callback){
  Site(tablePrefix).findById(siteId,function(err, site) {
    if (err){
      callback(err);
      winston.log('Error', 'Site not found ... '+err);
    }
    if (site) {
      callback(site);
      winston.log('info', 'Site found ... '+site);
    }
  });
},
getSiteByCondition = function(tablePrefix, condition, callback){
  Site(tablePrefix).find(condition,function(err, site) {
    if (err){
      callback(err);
      winston.log('Error', 'get site by condition ... '+err);
    }
    else if (site) {
      callback(site);
      winston.log('info', 'get site by condition ... '+site);
    }
    else {
      callback(null);
    }
  });
},
getSiteByRef = function(tablePrefix, siteRef, callback){
  Site(tablePrefix).findOne({'siteRef':siteRef},function(err, site) {
    if (err){
      callback(err);
      winston.log('Error', 'get site by name ... '+err);
    }
    else if (site) {
      callback(site);
      winston.log('info', 'get site by name ... '+site);
    } else {
      callback(null);
    }
  });
},
getSiteList = function(tablePrefix, callback){
  Site(tablePrefix).find(function(err, site) {
    if (err){
      callback(err);
      winston.log('Error', 'Site list ... '+err);
    }
    if (site) {
      callback(site);
      winston.log('info', 'Site list ... '+site);
    }
  });
}

getPannelsList = function(site){
      return site.map(function(rec) {return rec.panels;});
}

getSitePannelsObj = function(site){
      return site.map(function(rec) {return {"site": rec.displayName, "panels": rec.panels}; });
}


module.exports = 
{
  createSite: createSite,
  getSite: getSite,
  getSiteByRef: getSiteByRef,
  getSiteByCondition: getSiteByCondition,
  getSiteList: getSiteList,
  getPannelsList: getPannelsList,
  getSitePannelsObj: getSitePannelsObj,
  deleteSite: deleteSite
}
