"use strict";

var mysql = require('mysql'),
    connection  = require('express-myconnection'),
    config = require("./config"),
    winston = require("./logs"),
    mysqlConnection = mysql.createConnection({
                        host     : config.db_host,
                        user     : config.db_user,
                        password : config.db_password,
                        port : config.db_port,
                        database : config.db
                      });
      mysqlConnection.connect(function(err){
        if(!err) {
          winston.log('info', 'Database is connected ... ', __filename);
        } else {
          winston.log('error', 'Database is connected ... ', __filename);
          mysqlConnection = false;
        }
      });
  
    module.exports = mysqlConnection;
