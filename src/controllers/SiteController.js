"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS, siteService = require("../services/SiteService");

function create(req, res) {
  siteService.createSite(req.body.tablePrefix, req.body.siteRef, req.body.displayName, req.body.yearBuilt, req.body.operatingHours, req.body.areaGrossSquareFoot, req.body.areaCondSquareFoot, req.body.location, req.body.panels, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

function getLiveData(req, res) {
  fetchDataFromWS('/site_snapshots/liveDataBySite.json?site_ref=HGV1', res);
}

function getSolarData(req, res) {
  fetchDataFromWS('/site_snapshots/solarDataBySite.json?site_ref=HGV1', res);
}

function getCurrentDemand(req, res) {
  fetchDataFromWS('/site_snapshots/currentDemandBySite.json?site_ref=HGV1', res);
}

function getLastHoursData(req, res) {
  fetchDataFromWS('/site_snapshots/lastHoursDataBySite.json?site_ref=HGV1', res);
}

function getLastFive(req, res) {
  fetchDataFromWS('/site_snapshots/last5Circuits30DaysData.json?site_ref=HGV1', res);
}

function getweatherReport(req, res) {
  fetchDataFromWS('/site_snapshots/weatherReport.json?site_ref=HGV1', res);
}

module.exports = {
    create: create,
    getLiveData: getLiveData,
    getSolarData: getSolarData,
    getCurrentDemand: getCurrentDemand,
    getLastHoursData: getLastHoursData,
    getLastFive: getLastFive,
    getweatherReport: getweatherReport,
};
