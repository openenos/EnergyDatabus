/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      Channel services - basic crud operations
 !**/
 
var crypto = require('crypto'),
    winston = require("../config/logs"),
    algorithm = 'aes-256-ctr',
    _ = require('underscore');
    
    var Channel = function(tablePrefix){
       return require('../models/Channel')(tablePrefix);
    };
    
    var createChannel = function(tablePrefix, displayName, channelNumber,active,input,isProducing,doubleCT,doubleBreaker,breakerNumber,breakerSize,elecLoadType,CTSensotType, callback){
    var ChannelClass = Channel(tablePrefix), newChannel = new ChannelClass();
    newChannel.displayName = displayName;
    newChannel.channelNumber = channelNumber;
    newChannel.active = active;
    newChannel.input = input;
    newChannel.isProducing = isProducing;
    newChannel.doubleCT = doubleCT;
    newChannel.doubleBreaker = doubleBreaker;
    newChannel.breakerNumber = breakerNumber;
    newChannel.breakerSize = breakerSize;
    newChannel.elecLoadType = elecLoadType;
    newChannel.CTSensotType = CTSensotType;
    /*this.getChannelByNumber(tablePrefix, channelNumber, function(channel){
      if(!channel){*/
        newChannel.save(function(err) { 
            if(err){ 
              callback(err);
              winston.log('Error', 'Channel Creation ... '+err);
           } else { 
              callback("Channel Created");
              winston.log('Info', 'Channel Created ... ');
           } 
         });
        /*} else {
          callback("Channel Exist");
          winston.log('Warn', 'Channel Exist ... ');
        }
      });*/
  },

deleteChannel = function(tablePrefix, channelId, callback){
  Channel(tablePrefix).findByIdAndRemove(channelId, function(err) { 
    if(err){ 
      callback(err);
      winston.log('Error', 'Channel is not deleted ... '+err);
   } else { 
      winston.log('info', 'Channel deleted ... ');
   } 
 });
},
getChannel = function(tablePrefix, channelId, callback){
  Channel(tablePrefix).findById(channelId,function(err, channel) {
    if (err){
      callback(err);
      winston.log('Error', 'Channel not found ... '+err);
    }
    if (channel) {
      callback(channel);
      winston.log('info', 'Channel found ... '+channel);
    }
  });
},
getChannelByNumber = function(tablePrefix, channelNumber, callback){
  Channel(tablePrefix).findOne({'channelNumber':channelNumber},function(err, channel) {
    if (err){
      callback(err);
      winston.log('Error', 'get channel by name ... '+err);
    }
    else if (channel) {
      callback(channel);
      winston.log('info', 'get channel by name ... '+channel);
    }
    else {
      callback(null);
    }
  });
},
getChannelByCondition = function(tablePrefix, condition, callback){
  Channel(tablePrefix).find(condition,function(err, channel) {
    if (err){
      callback(err);
      winston.log('Error', 'get channel by condition ... '+err);
    }
    else if (channel) {
      callback(channel);
      winston.log('info', 'get channel by condition ... '+channel);
    }
    else {
      callback(null);
    }
  });
},
getChannelList = function(tablePrefix, callback){
  Channel(tablePrefix).find(function(err, channel) {
    if (err){
      callback(err);
      winston.log('Error', 'Channel list ... '+err);
    }
    if (channel) {
      callback(channel);
      winston.log('info', 'Channel list ... '+channel);
    }
  });
}

module.exports = 
{
  createChannel: createChannel,
  getChannel: getChannel,
  getChannelByNumber: getChannelByNumber,
  getChannelList: getChannelList,
  getChannelByCondition: getChannelByCondition,
  deleteChannel: deleteChannel
}
