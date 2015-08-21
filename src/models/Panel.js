/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Panel Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'),
    Location= require('./Location'), 
    Channel = require('./Channel'),
    Schema = mongoose.Schema,
    panelSchema = new Schema({
      displayName: {type: String},
      url: {type: String, unique:true, required: true},
      noOfCircuitsSupport: {type: Number, required: true},    
      amp: {type: Number},              
      channels: {type: Array, ref: 'Channel', required: true}
    });

module.exports =  function(tablePrefix){ return mongoose.model(tablePrefix+'_Panel', panelSchema); }

