/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      PostalInfo Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'),
    Schema = mongoose.Schema,    
    postalSchema = new Schema({
      postalCode: {type: String, unique: true, required: true},
      city: {type: String, required: true},
      state: {type: String, required: true},
      country: {type: String, required: true},
      timezone: {type: String, required: true},
      weatherRef: {type: String, required: true}
    });

module.exports = function(tablePrefix){ return mongoose.model(tablePrefix+'_PostalInfo', postalSchema); }
