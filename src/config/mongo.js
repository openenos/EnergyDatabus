/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      create mongodb connection
 !**/

"use strict";

var mongodbConnection = require('mongoose'),
    config = require("./config"),
    winston = require("./logs");

    try{
      mongodbConnection = mongodbConnection.connect('mongodb://'+config.mongodb_host+'/'+config.mongodb);
      winston.log('info', 'mongodb is connected ... ');
    }catch(err){
      winston.log('error', 'mongodb is not connected ... '+err.message);
      throw new Error('kairosdb is not connected ... '+err.message);
    }

    module.exports = mongodbConnection;
