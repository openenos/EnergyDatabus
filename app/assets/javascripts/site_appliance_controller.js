angular.module('enos.controllers')
	.controller('SiteApplianceController', ['$scope', '$window', '$http', 'GoogleChartService',  
    function ($scope, $window, $http, GoogleChartService){
    	$scope.name = "Site Appliance"

    	 /* Last 24hours Demand 
    $scope.getLastDayDemand = function(){
      var req = {
        method: 'GET',
        url: '/api/get_last_day_usage',
        headers: {
         'Accept': 'application/json'
        },
        params: { site: 'AMI Outfitters - Sears Cottage' }
      }

      $http(req).then(function(result){
        data = result.data.data
        cols = result.data.cols
        //drawPieChart(data)
        console.log("Last Day Usage");
        //drawGaugeChartSolar(data);
        drawAreaChart(cols, data);
        //console.log(data);
      }, 
      function(data){
        console.log(data);
      });

    }
    
    
    function drawAreaChart (cols, data) {
      var linechart = {};

      linechart.type = "AreaChart";
      linechart.cssStyle = "height:200px; width:300px;";
      //linechart.type = "LineChart";
      //linechart.cssStyle = "height:200px; width:300px;";
      console.log("cols: ");
      console.log(cols);

      linechart.data = {"cols": cols, "rows": data
      };

      linechart.options = {
          "title": "Last 24 hours demand",
          "isStacked": "true",
          "fill": 20,
          "displayExactValues": true,
          "vAxis": {
              "title": "Power unit", "gridlines": {"count": 6}
          },
          "hAxis": {
              "title": "Time"
          }
      };

      linechart.formatters = {};
      $scope.linechart = linechart;
    }

     Last 24hours Demand End */

     $scope.site_name = $("#site").text();
    $scope.getLastDayDemand = function(){
    	google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      var req = {
        method: 'GET',
        url: '/api/get_last_day_usage',
        headers: {
         'Accept': 'application/json'
        },
        params: { site: $scope.site_name }
      }

      $http(req).then(function(result){
        data = result.data.data
        console.log("Last Day Usage");
        drawChart(data)
        //console.log(data);
      }, 
      function(data){
        console.log(data);
      });

    	
      function drawChart(data) {
        var data = google.visualization.arrayToDataTable(data);

        var options = {
          title: 'Last 24Hrs Usage',
          hAxis: {title: 'Time',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0, title: 'Value'},
          isStacked: true
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    }
    $scope.getLastDayDemand();
  }]);