/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Channel Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'), 
    ElectLoadType = require('./ElecLoadType'),
    Schema = mongoose.Schema,
    channelSchema = new Schema({
      displayName: {type: String, required: true},
      channelNumber: {type: String, required: true},
      active: {type: Boolean, required: true},
      input: {type: Boolean, required: true},
      isProducing: {type: Boolean, required: true},
      doubleCT: {type: Boolean, required: true},
      doubleBreaker: {type: Boolean},
      breakerNumber: {type: String},
      breakerSize: {type: Number},
      elecLoadType: {type: Schema.ObjectId, ref: 'ElectLoadType'},
      CTSensotType: {type: Number}
    });
  
module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_Channel', channelSchema); }
