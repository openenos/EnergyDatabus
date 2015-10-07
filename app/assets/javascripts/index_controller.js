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
      GoogleChartService.piechart({site_group: site_group , month: moment().format("M")}, function(result) {
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
        power_usage = drawGaugeChart(data.demand_power, "Demand Power", "#2E9AFE");
        solar_power = drawGaugeChart(data.solar_power, "Solar Power", "#04B45F");
        utility_power = drawGaugeChart(data.utility_power, "Utility Power", "#FE2E2E");
        $scope.power_usage = power_usage;
        $scope.solar_power = solar_power;
        $scope.utility_power_gauge = utility_power;
    });

    }
    $scope.getGaugeChart();
    function drawGaugeChart(data, title, color){
      gaugechart = {};
      gaugechart.type = "Gauge";

      gaugechart.options = {
        width: 200,
        height: 180,
        max: 50,
        minorTicks: 5,
        greenFrom: 0,
        greenTo: 50,
        greenColor: color
      };

      gaugechart.data = [
        ['Label', 'Value'],
        ["kW", (data/1000)]
      ];
      return gaugechart
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
      GoogleChartService.data_tables({site_group: site_group, month: moment().format("M")}, function(result){
        var data = result.data;
        $scope.sites = data;
         
      });
    }

    $scope.data_tables();
    /* end */

    /* DateRange picker for usage by site */
    $('.daterange').daterangepicker(
      {
        ranges: {
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract('days', 1), moment()],
          'Last 7 Days': [moment().subtract('days', 6), moment()],
          'Last 30 Days': [moment().subtract('days', 29), moment()],
          'This Month': [moment().startOf('month'), moment().endOf('month')],
          'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
        },
        startDate: moment().subtract('days', 29),
        endDate: moment()
      },
      function(start, end) {
        //window.location = "/home/dashboard?site_group="+$('.form-control').val()+"&from="+start.format('D-M-YYYY')+"&to="+end.format('D-M-YYYY');
        $scope.data_tables($scope.siteGroup);
        console.log("Start: - " + start.format('YYYY-MM-DD h:mm:ss'))
        GoogleChartService.data_tables({site_group: $scope.siteGroup, start_date: start.format('YYYY-MM-DD'), end_date: end.format('YYYY-MM-DD')}, function(result){
          var data = result.data;
          $scope.sites = data;
          //$scope.sites = data;
        });
      }
    );

    /* DateRange picker for usage by site */
}]);