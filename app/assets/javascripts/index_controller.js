angular.module('enos.controllers')
	.controller('IndexController', ['$scope', '$window', '$http', 'GoogleChartService',  
        function ($scope, $window, $http, GoogleChartService){
		
		$scope.name = "balaraju"
         
		$scope.selectedGroup = "1";
		$scope.groups = [{id: '1', label: "First"}, {id: '2', label: "second"}, {id:'3', label: "Third"}];
		
		$scope.selectedUsage = "(1,2,3,4,5,6)";
		$scope.usages = [{id: '(1,2,3,4,5,6)', label: "All"},{id: 1, label: "HVAC"}, 
		{id: 2, label: "Lighting"}, {id: 3, label: "Refrigeration"}, 
		{id: 4, label: "Always On"}, {id: 5, label: "Others"}];

		$scope.getPieChart = function(){
		//	var url = "http://192.168.199.108:3000/api/get_last_month_data_by_load_type";
			$http.get("http://localhost:3000/api/get_last_month_data_by_load_type")
			.success(function(response){
				//console.log(response.data);
			
			var data = response.data;
			drawPieChart(data);
			console.log(data);
			}).error(function(){
        alert("error");
    });
		}


		$scope.getPieChart();
		


		$scope.groupSelect = function(){
			$scope.getPieChart();
			$window.alert($scope.selectedGroup);
		};

		$scope.usageSelect = function(){
			$window.alert($scope.selectedUsage);
		};

		//$scope.search();
		
		//Gauge Chart 
		var chart1 = {};
	    chart1.type = "Gauge";
	    //chart1.cssStyle = "height:200px; width:300px;";
	    chart1.data = [ ['Label', 'Value'],
          ['Usage Now', 80],
          ['Solr Power', 55],
          ['Utility', 68]];
	    chart1.options = {
	    	 "width": 1000, 
	    	 "height": 200,
         "redFrom": 90,
         "redTo": 100,
         "yellowFrom":75, 
         "yellowTo": 90,
         "minorTicks": 5
	       
	    };

	    chart1.formatters = {};

	    $scope.gauage = chart1;


	   // Pie Chart 


			//$scope.data = [];
				
							
		
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
        pattern: "$ #,##0.00"
      }]
    };

    $scope.pie_chart = pie_chart;
}

  //  $window.alert($scope.pieChartdetails);
    //Line Chart

     var linechart = {};
    linechart.type = "LineChart";
    linechart.cssStyle = "height:200px; width:300px;";
    linechart.data = {"cols": [
        {id: "month", label: "Month", type: "string"},
        {id: "server-id", label: "Server", type: "number"},
        {id: "cost-id", label: "Shipping", type: "number"}
    ], "rows": [
        {c: [
            {v: "January"},
            {v: 12, f: "Ony 12 items"},
            {v: 4}
        ]},
        {c: [
            {v: "February"},
            {v: 13},
            {v: 2}
        ]},
        {c: [
            {v: "March"},
            {v: 24},
            {v: 6}

        ]}
    ]};

    linechart.options = {
        "title": "Sales per month",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "Sales unit", "gridlines": {"count": 6}
        },
        "hAxis": {
            "title": "Date"
        }
    };

    linechart.formatters = {};

    $scope.linechart = linechart;

    //Table

   $scope.data_tables = function(){
		//	var url = "http://192.168.199.108:3000/api/get_last_month_data_by_load_type";
			$http.get("http://localhost:3000/api/get_last_month_data")
			.success(function(response){
				//console.log(response.data);
			
			var data = response.data;
			$scope.sites = data;
			console.log(data);
			}).error(function(){
        alert("error");
    });
		}


   $scope.data_tables();
    }]);