/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Location Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'), 
    PostalCode = require('./PostalInfo'), 
    Utility = require('./Utility'),
    Schema = mongoose.Schema,
    locationSchema = new Schema({
      geoAddr: {type: String, unique: true, required: true},
      lat: {type: String, required: true},
      lng: {type: String, required: true},
      postalcode: {type: Schema.ObjectId, ref: 'PostalCode', required: true},
      utility: {type: Schema.ObjectId, ref: 'Utility', required: true}
    });

module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_Location', locationSchema); }
