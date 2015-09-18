angular.module('enos.controllers')
	.controller('IndexController', ['$scope', '$window', '$http', 'GoogleChartService',  
    function ($scope, $window, $http, GoogleChartService){

    $scope.siteGroup = "Historic Green Village"
    $scope.change = function() {
      console.log("Change site_group:" + $scope.siteGroup)
      $scope.getPieChart($scope.siteGroup);
      $scope.getGaugeChart($scope.siteGroup);
      $scope.getLineChart($scope.siteGroup);
      $scope.data_tables($scope.siteGroup);
    };

		/* Pie chart code */
    $scope.getPieChart = function (site_group) {
      if(site_group == undefined){
        site_group = 'Historic Green Village'
      }
      GoogleChartService.piechart({site_group: site_group , month: 9}, function(result) {
      var data = result.data;
      drawPieChart(data);
      console.log(data);
    });
    }
		$scope.getPieChart();
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
    /* end */
		
    /*  Guage chart */

    $scope.getGaugeChart = function(site_group){
      if(site_group == undefined){
        site_group = 'Historic Green Village'
      }
      GoogleChartService.gaugechart({site_group: site_group}, function(result) {
        var data = result.data;
        drawGaugeChart(data);
        console.log(data);
    });

    }
    $scope.getGaugeChart();
    function drawGaugeChart(data){
      $scope.chartObject = {};
      $scope.chartObject.type = "Gauge";

      $scope.chartObject.options = {
        width: 450,
        height: 175,
        redFrom: 40,
        redTo: 50,
        max: 50,
        yellowFrom: 25,
        yellowTo: 40,
        minorTicks: 5
      };

      $scope.chartObject.data = [
        ['Label', 'Value'],
        ['Power Usage', (data.demand_power/1000)],
        ['Solar Power', (data.solar_power/1000)],
        ['Utility Power', (data.utility_power/1000)]
      ];
    }
    /* end */

    /* Line Chart */
    $scope.getLineChart = function(site_group){
      if(site_group == undefined){
        site_group = 'Historic Green Village'
      }
      GoogleChartService.line_chart({site_group: site_group}, function(result) {
        var data = result.data;
        $scope.total_demand = result.total_demand
        $scope.total_solar = result.total_solar
        $scope.utility_power = result.utility_power
        drawLineChart(data);
        console.log(data);
    }); 
    }

    $scope.getLineChart();
    
    function drawLineChart (data) {
      var linechart = {};
      linechart.type = "LineChart";
      linechart.cssStyle = "height:200px; width:300px;";
      linechart.type = "LineChart";
      linechart.cssStyle = "height:200px; width:300px;";
      linechart.data = {"cols": [
          {id: "month", label: "Month", type: "string"},
          {id: "demand", label: "Demand", type: "number"},
          {id: "solar", label: "Solar", type: "number"}
      ], "rows": data
      };

      linechart.options = {
          "title": "Last 12 month demand vs solar power",
          "isStacked": "true",
          "fill": 20,
          "displayExactValues": true,
          "vAxis": {
              "title": "Power unit", "gridlines": {"count": 6}
          },
          "hAxis": {
              "title": "Month"
          }
      };

      linechart.formatters = {};
      $scope.linechart = linechart;
    }
    
    /* end */
		
    /* data tables code */
    $scope.data_tables = function(site_group){
      if(site_group == undefined){
        site_group = 'Historic Green Village'
      }
      GoogleChartService.data_tables({site_group: site_group, month: 9}, function(result){
        var data = result.data;
        $scope.sites = data;
         
      });
    }

    $scope.data_tables();
    /* end */
}]);