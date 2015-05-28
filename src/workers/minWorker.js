/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      schedular
 !**/

var CronJob = require('cron').CronJob,
    siteService = require("../services/SiteService"),
    panelService = require("../services/PanelService"),
    channelService = require("../services/ChannelService"),
    locationService = require("../services/LocationService"),
    parseString = require('xml2js').parseString,
    _ = require('underscore'),
    request = require("request");

//new CronJob('* * * * * *', function() {
 console.log("Working....");
  
   var channels, isProducing, panels;
   siteService.getSiteByCondition("enos", {'siteRef': 'HGV2' }, function(siteResult){
   panels = siteService.getPannelsList(siteResult)
    _.each(panels, function(panel){
     panelService.getPanelByCondition("enos", {'_id':panel}, function(panelResult){
       _.each(panelResult, function(panel){
           //channels = panel.channels;
           //channelService.getChannelByCondition("enos", {$and: [{'_id':{ "$in": channels }}, {'isProducing':true}]}, function(channelResult){
           //});
             locationService.getLocationByCondition("enos", {'_id':siteResult[0].location}, function(locationResult){
                console.log("************\n"+locationResult+"\n"+siteResult[0]+"\n"+panel+"************");
                console.log("************"+panel.url+"************");
                request({
                  headers: {
                    'Content-Type': 'application/json'
                  },
                  uri: "http://"+panel.url,
                  method: 'GET'
                   }, function (err, response, body) {
                    //console.log(body);
                    parseString(body, function (err, result) {
                          json_response = result;
                          //console.log((json_response.emonitor.channels[0]).channel);
                          var channels_data = (json_response.emonitor.channels[0]).channel, paired_channels, paired_list;
                          paired_channels = channels_data.filter(function(i){ return i.paired_with_channel[0]!=0 }) ;
                          paired_channels_data = {};
                          for(index in paired_channels){
                            i = paired_channels[index];
                            var channel_number = i["$"]["Number"], paired_with = i.paired_with_channel[0];
                            if( channel_number < paired_with){ 
                              key = channel_number+"_"+paired_with;
                            } else { 
                              key = paired_with+"_"+channel_number;
                            }
                            avg_power = parseInt(i["avg_power"][0]);
                            if(avg_power < 0 || avg_power >36000) { 
                              avg_power=0; 
                            } 
                            if(paired_channels_data[key]){
                              paired_channels_data[key] += avg_power;
                            } else {
                              paired_channels_data[key] = avg_power;
                            }
                          }
                          unpaired_channels = channels_data.filter(function(i){ return i.paired_with_channel[0]==0 })
                          minResult  = unpaired_channels.map(function(i) { 
                          avg_power = parseInt(i["avg_power"][0]); 
                          if(avg_power<0 || avg_power>100000) { 
                            avg_power=0; 
                          } 
                          return { channel: i["$"]["Number"], avg_power: avg_power };
                          });
                          for(ch in paired_channels_data){
                            minResult.push({channel: ch, avg_power: paired_channels_data[ch]});
                          }
                          console.log((+new Date()));
                          console.dir(minResult);
                          var post_data = [], panel_id=panel._id, timestamp = (+new Date());
                          for(rec in minResult){
                            c_rec = minResult[rec];
                            post_data.push({"name": "minData","datapoints": [[timestamp, c_rec.avg_power]],"tags": {"site_ref": "HGV1","panel": "1","channel": "CH-"+c_rec.channel,"tableprefix": "abcd"}});
                          }
                          console.log(JSON.stringify(post_data));
                    });
                });
             });
       });
     }); 
    });
   });
   
//}, null, true, 'America/Los_Angeles');

/*

POST 
http://localhost:8081/api/v1/datapoints

[
  {
      "name": "minData",
      "datapoints": [[1431966468905, 125]],
      "tags": {
          "site_ref": "HGV1",
          "panel": "1",
          "channel": "CH-12",
          "tableprefix": "abcd"

      }
  }
]
*/
