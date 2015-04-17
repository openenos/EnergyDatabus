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
    mysqlConnection = require("./config/mysql"),
    kairosdbConnection = require("./config/kairosdb"),
    userService = require("./services/UserService"),
    siteService = require("./services/SiteService"),
    panelService = require("./services/PanelService"),
    locationService = require("./services/LocationService"),
    channelService = require("./services/ChannelService"),
    mongoose = require("./config/mongo");
    
    app.use(bodyParser.json());
    app.use(bodyParser.urlencoded({ extended: true }));
    app.use(cookieParser());
    app.use(passport.initialize());
    app.set('port', process.env.PORT || 3000);
    app.use(passport.session());
    app.use(router);
    //app.use('/', routes)
    
    if (app.get('env') != 'development') {
      winston.remove(winston.transports.Console);
    }


    _.each(routes, function (verbs, url) { 
      _.each(verbs, function (def, verb) {
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
        var method = require("./controllers/" + def.controller)[def.method]; 
        if (!method) { 
          throw new Error(def.method + " is undefined");
        }
        actions.push(method);
        app[verb](url, actions);
      });
    });
    
    app.get("/:siteRef", function (req, res) {
     var channels, isProducing, panels;
     siteService.getSiteByCondition("enos", {'siteRef': req.params.siteRef }, function(siteResult){
     panels = siteService.getPannelsList(siteResult)
      _.each(panels, function(panel){
       panelService.getPanelByCondition("enos", {'_id':panel}, function(panelResult){
         _.each(panelResult, function(panel){
             channels = panel.channels;
             channelService.getChannelByCondition("enos", {$and: [{'_id':{ "$in": channels }}, {'isProducing':true}]}, function(channelResult){
               locationService.getLocationByCondition("enos", {'_id':siteResult[0].location}, function(locationResult){
                console.log("************\n"+locationResult+"\n"+siteResult[0]+"\n"+channelResult+"\n"+panel.url+"************");
               });
             });
         });
       }); 
      });
     });
     res.send("ok");
    });
        
    
    app.use(function (req, res) {
      //res.redirect('/'); //for error pages 
    });

    app.listen(app.get('port'), function () {
      winston.info('Express server listening on port ' + app.get('port'));
    });

