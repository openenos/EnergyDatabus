/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      create mysql connection
 !**/

"use strict";

var mysql = require('mysql'),
    connection  = require('express-myconnection'),
    config = require("./config"),
    winston = require("./logs"),
    mysqlConnection = mysql.createConnection({
                        host     : config.mysqldb_host,
                        user     : config.mysqldb_user,
                        password : config.mysqldb_password,
                        port : config.mysqldb_port,
                        database : config.mysqldb
                      });
    mysqlConnection.connect(function(err){
      if(!err) {
        winston.log('info', 'MySql Database is connected ... ');
      } else {
        winston.log('error', 'MySql Database is not connected ...'+err);
        mysqlConnection = false;
        throw new Error('Mysql is not connected ... '+err.message);
      }
    });
  
    module.exports = mysqlConnection;
