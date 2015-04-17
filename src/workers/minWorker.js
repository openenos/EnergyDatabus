/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      schedular
 !**/

CronJob = require('cron').CronJob;

new CronJob('* * * * * *', function() {
  console.log('You will see this message every second');
}, null, true, 'America/Los_Angeles');
