/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Site Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'), 
    Panel = require('./Panel'),
    Schema = mongoose.Schema,
    siteSchema = new Schema({
      displayName: {type: String, unique: true, required: true},
      siteRef:{ type: String, unique: true, required: true},
      yearBuilt:{ type: Number },
      operatingHours:{ type: Number },
      panels:{ type: Array, ref: 'Panel', required: true},
      areaGrossSquareFoot: {type:Number, required: true},
      areaCondSquareFoot: {type:Number, required: true},
      location: {type: Schema.ObjectId, ref: 'Location', required: true}
    });

module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_Site', siteSchema); }
