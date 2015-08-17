/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      User Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo'),
    schema = new mongoose.Schema({
      username: {type: String, unique: true, required: true},
      password: {type: String, required: true},
      apiKey: {type: String, unique: true, required: true},
      tableNamePrefix: {type: String, unique: true, required: true}
    });
      
module.exports = mongoose.model('User', schema);
