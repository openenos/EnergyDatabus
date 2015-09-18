angular.module('enos.controllers')
	.controller('SiteSnapshotController', ['$scope', '$window', '$http', 'GoogleChartService',  
    function ($scope, $window, $http, GoogleChartService){
    	$scope.name = "Site Snapshot"
      $scope.site_name = $("#site").text();    	
      /* Weather Report Chart */
    	$scope.getWeatherReport = function(){
    		var req = {
					method: 'GET',
					url: '/api/get_weather_forecast',
					headers: {
					 'Accept': 'application/json'
					},
					params: { site: $scope.site_name }
				}

				$http(req).then(function(result){
					data = result.data.data
					$scope.weather_data = data
					//console.log(data)
				}, 
				function(data){
					console.log(data);
				});

    	}
    	$scope.getWeatherReport();

    	/* Weather Report Chart End */

    	/* Top Circuits Chart */
    	$scope.getTopCircuits = function(){
    		var req = {
					method: 'GET',
					url: '/api/get_top_circuits_by_site',
					headers: {
					 'Accept': 'application/json'
					},
					params: { site: $scope.site_name }
				}

				$http(req).then(function(result){
					data = result.data.data
					drawPieChart(data)
					//console.log(data);
				}, 
				function(data){
					console.log(data);
				});

    	}
    	$scope.getTopCircuits();

    	function drawPieChart (data){
      console.log(data);
      var pie_chart = {};
      pie_chart.type = "PieChart";
      pie_chart.data = data;
      pie_chart.options = {
        displayExactValues: true,
        width: 800,
        height: 300,
        chartArea: {left:10,top:10,bottom:0,height:"100%"}
      };

      pie_chart.formatters = {
        number : [{
          columnNum: 1,
          pattern: "Watt #,##0.00"
        }]
      };
      $scope.pie_chart = pie_chart;
    }

    /* Top Circuits Chart End */

    /* Top Demand Now Chart */

    $scope.topDemand = function() {
    	var req = {
				method: 'GET',
				url: '/api/get_top_demand',
				headers: {
				 'Accept': 'application/json'
				},
				params: { site: $scope.site_name }
			}

			$http(req).then(function(result){
					data = result.data.data;
					$scope.top_demand = data;
				}, 
				function(data){
					console.log(data);
				});
    }
    $scope.topDemand();



    /* Top Demand Now Chart End */

    /* Site Demand Gauges */
		$scope.getSiteDemand = function(){
  		var req = {
				method: 'GET',
				url: '/api/get_site_demand',
				headers: {
				 'Accept': 'application/json'
				},
				params: { site: $scope.site_name }
			}

			$http(req).then(function(result){
				data = result.data.data
				drawGaugeChart(data);
			}, 
			function(data){
				console.log(data);
			});

  	}
  	$scope.getSiteDemand();

  	function drawGaugeChart(data){
  		$scope.siteDemand = {};
      $scope.siteDemand.type = "Gauge";

      $scope.siteDemand.options = {
        width: 450,
        height: 175,
        redFrom: 40,
        redTo: 50,
        max: 150,
        yellowFrom: 25,
        yellowTo: 40,
        minorTicks: 5
      };

      $scope.siteDemand.data = [
        ['Label', 'Value'],
        ['Current Demand', (data.current_demand)],
        ['Top Demand', (data.top_demand)],
        ['Total Demand', (data.total_demand)]
      ];


  	}   

    /* Site Demand Gauges End */
    

    /* Solar Power Gauges End */

    $scope.getSiteSolar = function(){
  		var req = {
				method: 'GET',
				url: '/api/get_solar_power',
				headers: {
				 'Accept': 'application/json'
				},
				params: { site: $scope.site_name }
			}

			$http(req).then(function(result){
				data = result.data.data
				drawGaugeChartSolar(data);
			}, 
			function(data){
				console.log(data);
			});

  	}
  	$scope.getSiteSolar();

  	function drawGaugeChartSolar(data){
  		$scope.solarPower = {};
      $scope.solarPower.type = "Gauge";

      $scope.solarPower.options = {
        width: 450,
        height: 175,
        redFrom: 7,
        redTo: 8,
        max: 10,
        yellowFrom: 6,
        yellowTo: 7,
        minorTicks: 2
      };

      $scope.solarPower.data = [
        ['Label', 'Value'],
        ['Current Solar', (data.current_power)],
        ['Total Solar', (data.total_power)]
      ];


  	}   

    /* Solar Power Gauges End */


    /* Last 24hours Demand */
    $scope.getLastDayDemand = function(){
      var req = {
        method: 'GET',
        url: '/api/get_last_day_demand',
        headers: {
         'Accept': 'application/json'
        },
        params: { site: $scope.site_name }
      }

      $http(req).then(function(result){
        data = result.data.data
        //drawPieChart(data)
        console.log("Last Day Demand");
        //drawGaugeChartSolar(data);
        drawLineChart(data);
        //console.log(data);
      }, 
      function(data){
        console.log(data);
      });

    }
    $scope.getLastDayDemand();
    
    function drawLineChart (data) {
      var linechart = {};
      linechart.type = "LineChart";
      linechart.cssStyle = "height:200px; width:300px;";
      linechart.type = "LineChart";
      linechart.cssStyle = "height:200px; width:300px;";
      linechart.data = {"cols": [
          {id: "time", label: "Time", type: "string"},
          {id: "demand", label: "Demand", type: "number"}
          
      ], "rows": data
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
      $scope.lastdaydemand = linechart;
    }









    /* Last 24hours Demand End */



}]);     	