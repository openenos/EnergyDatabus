"use strict";

var locationService = require("../services/LocationService");

function create(req, res) {
  locationService.createLocation(req.body.tablePrefix, req.body.geoAddr, req.body.lat, req.body.lng, req.body.postalcode, req.body.utility, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

module.exports = {
    create: create
};
