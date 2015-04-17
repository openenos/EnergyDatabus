/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Group Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'),
    Site = require('./Site'),
    Schema = mongoose.Schema,
    groupSchema = new Schema({
      displayName: {type: String, unique: true, required: true},
      sites: {type: Array, ref:'Site', required: true}
    });

module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_Group', groupSchema); }
