/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      Channel Model
 !**/
 
"use strict";

var mongoose = require('../config/mongo');

module.exports = function(tablePrefix){
  mongoose.model(tablePrefix+'_Group', require('../models/Group'));
  mongoose.model(tablePrefix+'_Site', require('../models/Site'));
  mongoose.model(tablePrefix+'_Panel', require('../models/Panel'));
  mongoose.model(tablePrefix+'_Channel', require('../models/Channel'));
  mongoose.model(tablePrefix+'_Location', require('../models/Location'));
  mongoose.model(tablePrefix+'_Utility', require('../models/Utility'));
  mongoose.model(tablePrefix+'_PostalInfo', require('../models/PostalInfo'));
  mongoose.model(tablePrefix+'_ElecLoadType', require('../models/ElecLoadType'));
};
