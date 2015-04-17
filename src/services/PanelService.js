 /*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      Panel services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr';
    
    var Panel = function(tablePrefix){
       return require('../models/Panel')(tablePrefix);
    };

    var createPanel = function(tablePrefix, displayName, url, noOfCircuitsSupport, amp, channels, callback){
    var PanelClass = Panel(tablePrefix), newPanel = new PanelClass();
    newPanel.displayName = displayName;
    newPanel.url = url;
    newPanel.noOfCircuitsSupport = noOfCircuitsSupport;
    newPanel.amp = amp;
    newPanel.channels = channels;
    this.getPanelByUrl(tablePrefix, url, function(panel){
      if(!panel){
        newPanel.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'Panel Creation ... '+err);
           } else { 
              callback("Panel Created");
              winston.log('Info', 'Panel Created ... ');
           } 
         });
        } else {
          callback("Panel Exist");
          winston.log('Warn', 'Panel Exist ... ');
        }
      }
    );
  },

deletePanel = function(tablePrefix, panelId, callback){
  Panel(tablePrefix).findByIdAndRemove(panelId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'Panel is not deleted ... '+err);
   } else { 
      winston.log('info', 'Panel deleted ... ');
   } 
 });
},
getPanel = function(tablePrefix, panelId, callback){
  Panel(tablePrefix).findById(panelId,function(err, panel) {
    if (err){
      callback(err);
      winston.log('Error', 'Panel not found ... '+err);
    }
    if (panel) {
      callback(panel);
      winston.log('info', 'Panel found ... '+panel);
    }
  });
},
getPanelByCondition = function(tablePrefix, condition, callback){
  Panel(tablePrefix).find(condition,function(err, panel) {
    if (err){
      callback(err);
      winston.log('Error', 'get panel by condition ... '+err);
    }
    else if (panel) {
      callback(panel);
      winston.log('info', 'get panel by condition ... '+panel);
    }
    else {
      callback(null);
    }
  });
},
getPanelByUrl = function(tablePrefix, url, callback){
  Panel(tablePrefix).findOne({'url':url},function(err, panel) {
    if (err){
      callback(err);
      winston.log('Error', 'get panel by name ... '+err);
    }
    else if (panel) {
      callback(panel);
      winston.log('info', 'get panel by name ... '+panel);
    } else {
      callback(null);
    }
  });
},
getPanelList = function(tablePrefix, callback){
  Panel(tablePrefix).find(function(err, panel) {
    if (err){
      callback(err);
      winston.log('Error', 'Panel list ... '+err);
    }
    if (panel) {
      callback(panel);
      winston.log('info', 'Panel list ... '+panel);
    }
  });
}


getChannelsList = function(panel){
      return panel.map(function(rec) {return rec.channels;});
}

getPannelChannelsObj = function(panel){
      return panel.map(function(rec) {return {"panel": rec.displayName, "channels": rec.channels}; });
}

module.exports = 
{
  createPanel: createPanel,
  getPanel: getPanel,
  getPanelByUrl: getPanelByUrl,
  getPanelByCondition: getPanelByCondition,
  getPanelList: getPanelList,
  getChannelsList: getChannelsList,
  getPannelChannelsObj: getPannelChannelsObj,
  deletePanel: deletePanel
}
