"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS;

function getAllChannelsData(req, res) {
  fetchDataFromWS('/site_appliances/getAllchannelsData.json?site_ref=HGV1', res);
}
module.exports = {
    getAllChannelsData: getAllChannelsData,
};
