/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Utility Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'), 
    Schema = mongoose.Schema,
    utilitySchema = new Schema({
      displayName: {type: String, required: true},
      utilityType: {type: String, unique: true, required: true},
      baseRate: {type: Number, required: true},
      demand: {type: Boolean},
      tier1Rate: {type: Number},
      tier2Rate: {type: Number},
      tier3Rate: {type: Number},
      tier4Rate: {type: Number}
    });

module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_Utility', utilitySchema); }
