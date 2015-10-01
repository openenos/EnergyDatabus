var demoApp = angular.module('demoApp', [
        "angular-dygraphs"
    ]);

    demoApp.controller('DemoCtrl', ['$scope', '$window', '$http', 


    function ($scope, $window, $http) {
      $scope.site_name = $("#site").text();
      $scope.date = $("#current_date").text();


      //Display current month when switched to month tab
    	$(".month").click(function(){
    		$("#display_date_label").text(moment().format("MMMM YYYY"));
    		$("#display_date_label").attr("range", "month");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        //$scope.getMonthDemand();
        //$interval.cancel(dayChartTimer);

    	});

    	//Display current day when switched to day tab
    	$(".day").click(function(){
    		$("#display_date_label").text(moment().format("DD MMMM YYYY"));
    		$("#display_date_label").attr("range", "day");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        //$scope.getDayDemand();
        //setTimer();
        dayDemand();
    	});

    	//Display current week when switched to week tab
    	$(".week").click(function(){
    		text = moment().subtract('days', 6).format("DD MMMM YYYY");
    		text = text + " - "
    		text = text + moment().format("DD MMMM YYYY");
    		$("#display_date_label").text(text);
    		$("#display_date_label").attr("range", "week");
    		$("#display_date_label").attr("value", moment().subtract('days', 6).format("YYYY-MM-DD"));
        //$scope.getWeekDemand();
        //$interval.cancel(dayChartTimer);
    	});

    	//Display current day when switched to day tab
    	$(".year").click(function(){
    		$("#display_date_label").text(moment().format("YYYY"));
    		$("#display_date_label").attr("range", "year");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        //$scope.getDayDemand();
        //setTimer();
    	});


    	// Goto previous date, week and months action
    	$(".prev_date").click(function(){
    		switch ($("#display_date_label").attr("range")){
    			case "day":
    				value = moment($("#display_date_label").attr("value")).subtract('days', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("DD MMMM YYYY"));
            //$scope.getDayDemand();
            dayDemand();
    				break;
    			case "week": 
    				value = moment($("#display_date_label").attr("value")).subtract('days', 7);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				text = value.format("DD MMMM YYYY") + " - " + value.add('days', 6).format("DD MMMM YYYY");
    				$("#display_date_label").text(text);
            //getWeekDemand();
    				break;
    			case "month":
    				value = moment($("#display_date_label").attr("value")).subtract('months', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("MMMM YYYY"));
            //$scope.getMonthDemand();
    				break;
    			case "year":
    				value = moment($("#display_date_label").attr("value")).subtract('years', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("YYYY"));
    				break;
    		}	

    	})

			// Goto previous date, week and months action
    	$(".next_date").click(function(){
    		switch ($("#display_date_label").attr("range")){
    			case "day":
    				value = moment($("#display_date_label").attr("value")).add('days', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("DD MMMM YYYY"));
            //$scope.getDayDemand();
            dayDemand();
    				break;
    			case "week": 
    				value = moment($("#display_date_label").attr("value")).add('days', 7);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				text = value.format("DD MMMM YYYY") + " - " + value.add('days', 6).format("DD MMMM YYYY");
    				$("#display_date_label").text(text);
            //getWeekDemand();
    				break;
    			case "month":
    				value = moment($("#display_date_label").attr("value")).add('months', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("MMMM YYYY"));
            //$scope.getMonthDemand();
    				break;
    			case "year":
    				value = moment($("#display_date_label").attr("value")).add('years', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("YYYY"));
    				break;
    		}	

    	})


			/* Day Demand Chart */
    	dayDemand = function(){
    		console.log($(".iradio_minimal.checked [name='r1']").val());
    		var req = {
					method: 'GET',
					url: '/api/get_day_usage_data_by_site',
					headers: {
					 'Accept': 'application/json'
					},
					params: { site: $scope.site_name, date: $("#display_date_label").attr("value"), load_type: $(".iradio_minimal.checked [name='r1']").val() || "Demand" }
				}

				$http(req).then(function(result){
					data = result.data.data
					//$scope.weather_data = data
					g = new Dygraph(
					    // containing div
					    document.getElementById("day-chart"),
					    data
					  );
					console.log(result.data.data)
				}, 
				function(data){
					console.log(data);
				});

    	}
    	dayDemand();

    	/* Day Demand Chart End */        

        

    }]);