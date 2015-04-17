/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      LoadType Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'),
    Schema = mongoose.Schema,
    elecLoadTypeSchema = new Schema({
      displayName: {type: String, unique: true, required: true},
      loadType: {type: String, required: true}
    });

module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_ElecLoadType', elecLoadTypeSchema); }
