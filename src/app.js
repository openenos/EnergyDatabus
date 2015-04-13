/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      App configuration
 !**/

"use strict";
 
var express = require('express'),
    app = express(),
    /*session = require('express-session'),
    RedisStore = require('connect-redis')(session),*/
    path = require('path'),
    cookieParser = require('cookie-parser'),
    bodyParser = require('body-parser'),
    router = express.Router(),
    passport = require('passport'),
    _ = require('underscore'),
    wunderground = require('wundergroundnode'),
    routes = require('./config/routes'),
    winston = require('./config/logs'),
    config = require("./config/config"),
    mysqlConnection = require("./config/mysql");
    kairosdbConnection = require("./config/kairosdb");

    app.use(bodyParser.json());
    app.use(bodyParser.urlencoded({ extended: true }));
    app.use(cookieParser());
    app.use(passport.initialize());
    app.set('port', process.env.PORT || 3000);
    app.use(passport.session());
    app.use(router);

    /*app.use(session({
      store: new RedisStore({
        host: 'localhost',
        port: 6379,
        db:2
      }),
      secret: 'f|nDp@ssw0rd'
    }));


    app.get("/", function (req, res) {
      req.session.mode = app.get('env');
      res.send('hi'+req.session.mode);
    });*/

    app.get("/", function (req, res) {
       
        
        var data = [
          {
            "name": "testData",
            "timestamp": new Date().getTime(),
            "value": 321,
            "tags": {
              "host": "server"
            }
          }
        ];
       
       
       // write data
        kairosdbConnection.datapoints(data, function (err, result) {
          if (err){
              throw err;
          } else {
            console.log(result);
          }
        });


       // read data
       
       var query = {
        "metrics": [
          {
            "tags": {},
            "name": "testData",
            "aggregators": [
              {
                "name": "sum",
                "align_sampling": true,
                "sampling": {
                  "value": "1",
                  "unit": "milliseconds"
                }
              }
            ]
          }
        ],
        "cache_time": 0,
        "start_absolute": +new Date() - 360000,
        "end_absolute": +new Date()
      }
      
       kairosdbConnection.query(query, function (err, result) {
          if (err){
              throw err;
          } else {
            console.log(JSON.stringify(result));
          }
        });

       
       //mysql

        if(mysqlConnection){
            console.log("true");
        } else {
            console.log("false");
        }
      
      mysqlConnection.query('SELECT * from circuits LIMIT 2', function(err, rows, fields) {
      mysqlConnection.end();
        if (!err){
          //console.log('The solution is: ', rows);
        }
        else {
          winston.log('error', 'Error while performing Query.', __filename);
        }
      });
      //console.log(config.db_host+"---"+config.db_port+"----"+config.db+"----"+config.db_user+"------"+config.db_password);
      res.send(app.get('env'));
      
    });
    
    app.get("/site/:ref/weather", function (req, res) {
      /*var siteRef = req.param('ref').trim(), json_data = {};
      if(siteRef #TODO: check in DB){
        var wundergroundObj = new wunderground(config.wunderground);
        weather_ref = Site.find_by_site_ref(params[:site_ref]).location.postal_code.weather_ref

       
      result = w_api.conditions_for("pws:#{weather_ref.to_s}")
      
      unless result['current_observation'].nil?
      image = result['current_observation']['icon_url']
      status = result['current_observation']['weather']
      temp_f = result['current_observation']['temp_f']
      wind_string = "From the #{result['current_observation']['wind_dir']} at #{result['current_observation']['wind_mph']} MPH "
      relative_humidity = result['current_observation']['relative_humidity']
      
      json_data = {image: image, status: status, temp_f: temp_f, wind_string: wind_string, relative_humidity: relative_humidity}
      
      forecast = JSON.load(open("http://api.wunderground.com/api/#{api_key}/forecast/q/pws:#{weather_ref.to_s}.json"))
      
      forecast_data = []
      (1..3).each do|week_day|
        day_data = { day: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["date"]["weekday"],
        min: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["low"]["fahrenheit"],
        max: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["high"]["fahrenheit"] }
        forecast_data << day_data
      end
      
      json_data['forecast'] = forecast_data
      
      end
      
      
      
      } else {
        json_data = { error: "Site Reference is not valid." }
      }

      res.end(JSON.stringify(json_data ));*/
    });
    
    app.use(function (req, res) {
      //res.redirect('/'); //for error pages 
    });

    app.listen(app.get('port'), function () {
      winston.info('Express server listening on port ' + app.get('port'));
    });

    //loading content from routes.js ex   ->  { '/test': { post: { controller: "HomeController", method: "login", public: true } } }
    // url:/test, verbs: { post: { controller: "HomeController", method: "login", public: true } }
    _.each(require("./config/routes"), function (verbs, url) { 
      _.each(verbs, function (def, verb) {  // verb:post, def: { controller: "HomeController", method: "login", public: true }
        var actions = [ ];
        if (!def.public) {
          actions.push(function (req, res, next) {
            if ("user"!="present") {
              res.status(401).json({error: "Not authenticated"});
            } else {
              next();
            }
          });
        }
        // controller/HomeController is  obj method login is a key it returns a function
        var method = require("./controllers/" + def.controller)[def.method]; 
        if (!method) { // if method not undefined, null...
          throw new Error(def.method + " is undefined");
        }
        actions.push(method);
       
        app[verb](url, actions);
      });
    });

