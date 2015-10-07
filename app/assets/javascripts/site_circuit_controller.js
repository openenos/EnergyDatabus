angular.module('enos.controllers')
	.controller('SiteCircuitController', ['$scope', '$window', '$http', '$interval',  
    function ($scope, $window, $http, $interval){
    	$scope.site_name = $("#site").text();
    	$scope.circuit = $("#circuit").text();


    	$.getJSON("/get_all_circuits_by_site?site="+$("#site").text(), function(data){
			  build_sidebar(data.data);  
			});

      function setTimer(){
        dayChartTimer = $interval(updateDayChart, (1000*60));
      }
      
      function updateDayChart(){
        $scope.getDayDemand();
      }
      
    	//Display current month when switched to month tab
    	$(".month").click(function(){
    		$("#display_date_label").text(moment().format("MMMM YYYY"));
    		$("#display_date_label").attr("range", "month");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        $scope.getMonthDemand();
        $interval.cancel(dayChartTimer);

    	});

    	//Display current day when switched to day tab
    	$(".day").click(function(){
    		$("#display_date_label").text(moment().format("DD MMMM YYYY"));
    		$("#display_date_label").attr("range", "day");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        $scope.getDayDemand();
        setTimer();
    	});

    	//Display current week when switched to week tab

    	$(".week").click(function(){
    		text = moment().subtract('days', 6).format("DD MMMM YYYY");
    		text = text + " - "
    		text = text + moment().format("DD MMMM YYYY");
    		$("#display_date_label").text(text);
    		$("#display_date_label").attr("range", "week");
    		$("#display_date_label").attr("value", moment().subtract('days', 6).format("YYYY-MM-DD"));
        $scope.getWeekDemand();
        $interval.cancel(dayChartTimer);
    	});


    	// Goto previous date, week and months action
    	$(".prev_date").click(function(){
    		switch ($("#display_date_label").attr("range")){
    			case "day":
    				value = moment($("#display_date_label").attr("value")).subtract('days', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("DD MMMM YYYY"));
            $scope.getDayDemand();
    				break;
    			case "week": 
    				value = moment($("#display_date_label").attr("value")).subtract('days', 7);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				text = value.format("DD MMMM YYYY") + " - " + value.add('days', 6).format("DD MMMM YYYY");
    				$("#display_date_label").text(text);
            getWeekDemand();
    				break;
    			case "month":
    				value = moment($("#display_date_label").attr("value")).subtract('months', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("MMMM YYYY"));
            $scope.getMonthDemand();
    				break;
    		}	

    	})

			// Goto next date, week and months action
			$(".next_date").click(function(){
    		switch ($("#display_date_label").attr("range")){
    			case "day":
    				value = moment($("#display_date_label").attr("value")).add('days', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("DD MMMM YYYY"));
            $scope.getDayDemand();
    				break;
    			case "week": 
    				value = moment($("#display_date_label").attr("value")).add('days', 7);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				text = value.format("DD MMMM YYYY") + " - " + value.add('days', 6).format("DD MMMM YYYY");
    				$("#display_date_label").text(text);
            $scope.getWeekDemand();
    				break;
    			case "month":
    				value = moment($("#display_date_label").attr("value")).add('months', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("MMMM YYYY"));
            $scope.getMonthDemand();
    				break;
    		}	

    	})


    	function build_sidebar(data){
				$.each(data, function( index, value ) {
				    var active_root = false;
				    var html_code = '';
				    $.each(value, function( k, v ) { 
				      if(v==$("#circuit").text()){
				         html_code = html_code + '<li class="active"><a href="/site_circuit/index?site='+$("#site").text()+'&circuit='+v+'" style="margin-left: 10px;"><i class="fa fa-angle-double-right"></i>'+v+'</a></li>';
				         active_root = true;
				      }else{
				      	 html_code = html_code + '<li><a href="/site_circuit/index?site='+$("#site").text()+'&circuit='+v+'" style="margin-left: 10px;"><i class="fa fa-angle-double-right"></i>'+v+'</a></li>';
				      }
				    });
				var root_code = '';
				if(active_root){
				root_code = '<li class="treeview active"><a href="#"><span>'+index+ '</span><i class="fa pull-right fa-angle-left"></i></a>';
				}else{
				root_code = '<li class="treeview"><a href="#"><span>'+index+ '</span><i class="fa pull-right fa-angle-left"></i></a>';
				}
				root_code = root_code + '<ul class="treeview-menu">';
				root_code = root_code + html_code + '</ul></li>'
				    $(".sidebar-menu").append(root_code);
				});

			  $(".sidebar .treeview").tree();
			}

			getRuntimeInfo = function(){
				var req = {
					method: 'GET',
					url: '/api/get_runtime_info',
					headers: {
					 'Accept': 'application/json'
					},
					params: { site: $scope.site_name, circuit: $scope.circuit }
				}

				$http(req).then(function(result){
					data = result.data.data
					$scope.day_hours = data.day.hours
					$scope.day_minutes = data.day.mins
					$scope.week_hours = data.week.hours
					$scope.week_minutes = data.week.mins
					$scope.total_hours = data.total.hours
					//console.log(data)
				}, 
				function(data){
					console.log(data);
				});


			}

			getRuntimeInfo();


			//Circuit Demand Gauges 

			$scope.getCircuitDemand = function(){
  		var req = {
				method: 'GET',
				url: '/api/get_circuit_demand',
				headers: {
				 'Accept': 'application/json'
				},
				params: { site: $scope.site_name, circuit: $scope.circuit }
			}

			$http(req).then(function(result){
				data = result.data.data
				current_demand = drawGaugeChart(data.current_demand, "Watt");
        total_demand = drawGaugeChart(data.total_demand, "kWh");
        $scope.current_demand = current_demand
        $scope.total_demand = total_demand
			}, 
			function(data){
				console.log(data);
			});

  	}
  	$scope.getCircuitDemand();
  	function drawGaugeChart(data, title){
  		circuitDemand = {};
      circuitDemand.type = "Gauge";

      circuitDemand.options = {
        width: 450,
        height: 180,
        max: 100,
        minorTicks: 5
      };

      circuitDemand.data = [
        ['Label', 'Value'],
        [title, (data)]
      ];

      return circuitDemand


  	}   
    //Circuit Demand Gauges End

    /* Display month circuit demand */
    $scope.getMonthDemand = function(){
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawColumnChart);
      var req = {
        method: 'GET',
        url: '/api/get_month_circuit_demand',
        headers: {
         'Accept': 'application/json'
        },
        params: { site: $scope.site_name, circuit: $scope.circuit, date: $("#display_date_label").attr("value") }
      }

      $http(req).then(function(result){
        data = result.data.data
        drawColumnChart(data);
        console.log(data);
      }, 
      function(data){
        console.log(data);
      });

    }

    function drawColumnChart(data){
      var data = google.visualization.arrayToDataTable(data);
      var view = new google.visualization.DataView(data);
      
      var options = {
        title: "Circuit Demand",
        width: 720,
        height: 330,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };

      var chart = new google.visualization.ColumnChart(document.getElementById("month_demand"));
      chart.draw(view, options);
      
    }

    /* Display month circuit demand end */

    /* Display week circuit demand */
    $scope.getWeekDemand = function(){
      var req = {
        method: 'GET',
        url: '/api/get_week_circuit_demand',
        headers: {
         'Accept': 'application/json'
        },
        params: { site: $scope.site_name, circuit: $scope.circuit, date: $("#display_date_label").attr("value") }
      }

      $http(req).then(function(result){
        data = result.data.data
        drawLineChart(data, 'week_demand', 'Week Demand');
        console.log(data);
      }, 
      function(data){
        console.log(data);
      });

    }

    function drawLineChart(data, div_id, title){
       var data = google.visualization.arrayToDataTable(data);
       var options = {
          title: title,
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById(div_id));
        chart.draw(data, options);
    }

    /* Display week circuit demand end */

    /* Display day circuit demand */
      $scope.getDayDemand = function(){
      var req = {
        method: 'GET',
        url: '/api/get_day_circuit_demand',
        headers: {
         'Accept': 'application/json'
        },
        params: { site: $scope.site_name, circuit: $scope.circuit, date: $("#display_date_label").attr("value") }
      }

      $http(req).then(function(result){
        data = result.data.data
        drawLineChart(data, 'day_demand', 'Day Demand');
        console.log(data);
      }, 
      function(data){
        console.log(data);
      });

    };


    /* Display day circuit demand end*/
}]);