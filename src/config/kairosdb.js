/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      create kairosdb connection
 !**/


"use strict";

var kairosdb = require('kairosdb'),
    config = require("./config"),
    winston = require("./logs"),
    kairosdbConnection = false;
    
    try{
      kairosdbConnection = kairosdb.init(config.kairosdb_host, config.kairosdb_port, {});
      winston.log('info', 'kairosdb is connected ... ');
    } catch(err){
       winston.log('error', 'kairosdb is not connected ... '+err.message);
       throw new Error('kairosdb is not connected ... '+err.message);
    }
    
    module.exports = kairosdbConnection;
