"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS;

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
    getLiveData: getLiveData,
    getSolarData: getSolarData,
    getCurrentDemand: getCurrentDemand,
    getLastHoursData: getLastHoursData,
    getLastFive: getLastFive,
    getweatherReport: getweatherReport,
};
