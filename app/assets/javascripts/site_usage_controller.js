var demoApp = angular.module('demoApp', [
        "angular-dygraphs"
    ]);

    demoApp.controller('DemoCtrl', ['$scope', '$window', '$http', 

    function ($scope, $window, $http) {
      $scope.site_name = $("#site").text();
      $scope.date = $("#current_date").text();


      

    	//Display current day when switched to day tab
    	$(".day").click(function(){
    		$("#display_date_label").text(moment().format("DD MMMM YYYY"));
    		$("#display_date_label").attr("range", "day");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
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
        weekDemand();
    	});

      //Display current month when switched to month tab
      $(".month").click(function(){
        $("#display_date_label").text(moment().format("MMMM YYYY"));
        $("#display_date_label").attr("range", "month");
        $("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        monthDemand();

      });

    	//Display current day when switched to day tab
    	$(".year").click(function(){
    		$("#display_date_label").text(moment().format("YYYY"));
    		$("#display_date_label").attr("range", "year");
    		$("#display_date_label").attr("value", moment().format("YYYY-MM-DD"));
        yearDemand();
    	});


    	// Goto previous date, week and months action
    	$(".prev_date").click(function(){
    		switch ($("#display_date_label").attr("range")){
    			case "day":
    				value = moment($("#display_date_label").attr("value")).subtract('days', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("DD MMMM YYYY"));
            dayDemand();
    				break;
    			case "week": 
    				value = moment($("#display_date_label").attr("value")).subtract('days', 7);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				text = value.format("DD MMMM YYYY") + " - " + value.add('days', 6).format("DD MMMM YYYY");
    				$("#display_date_label").text(text);
            weekDemand();
    				break;
    			case "month":
    				value = moment($("#display_date_label").attr("value")).subtract('months', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("MMMM YYYY"));
            monthDemand();
    				break;
    			case "year":
    				value = moment($("#display_date_label").attr("value")).subtract('years', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("YYYY"));
            yearDemand();
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
            dayDemand();
    				break;
    			case "week": 
    				value = moment($("#display_date_label").attr("value")).add('days', 7);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				text = value.format("DD MMMM YYYY") + " - " + value.add('days', 6).format("DD MMMM YYYY");
    				$("#display_date_label").text(text);
            weekDemand();
    				break;
    			case "month":
    				value = moment($("#display_date_label").attr("value")).add('months', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("MMMM YYYY"));
            monthDemand();
    				break;
    			case "year":
    				value = moment($("#display_date_label").attr("value")).add('years', 1);
    				$("#display_date_label").attr("value", value.format("YYYY-MM-DD"));
    				$("#display_date_label").text(value.format("YYYY"));
            yearDemand();
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
					g = new Dygraph(
					    // containing div
					    document.getElementById("day-chart"),
					    data
					  );
				}, 
				function(data){
					console.log(data);
				});

    	}
    	dayDemand();

    	/* Day Demand Chart End */     

      /* Week Demand Chart */
      weekDemand = function(){
        var req = {
          method: 'GET',
          url: '/api/get_week_usage_data_by_site',
          headers: {
           'Accept': 'application/json'
          },
          params: { site: $scope.site_name, date: $("#display_date_label").attr("value"), load_type: $(".iradio_minimal.checked [name='r2']").val() || "Demand" }
        }

        $http(req).then(function(result){
          data = result.data.data
          g = new Dygraph(
            // containing div
            document.getElementById("week-chart"),
            data
          );
        }, 
        function(data){
          console.log(data);
        });

      }

      /* Week Demand Chart End */        

      /* Month Demand Chart */    
      monthDemand = function(){
        var req = {
          method: 'GET',
          url: '/api/get_month_usage_data_by_site',
          headers: {
           'Accept': 'application/json'
          },
          params: { site: $scope.site_name, date: $("#display_date_label").attr("value"), load_type: $(".iradio_minimal.checked [name='r3']").val() || "Demand" }
        }

        $http(req).then(function(result){
          data = result.data.data;
          drawMonthChart(data);
          console.log(result);
        }, 
        function(data){
          console.log(data);
        });

      }
      function drawMonthChart(data){
        var data = google.visualization.arrayToDataTable(data);
        var view = new google.visualization.DataView(data);
        var options = {
          title: "Site Demand",
          width: 1500,
          height: 420,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
        };

        var chart = new google.visualization.ColumnChart(document.getElementById("month-chart"));
        chart.draw(view, options);

      }

      /* Month Demand Chart End */    

      /* Year Demand Chart */    
      yearDemand = function(){
        var req = {
          method: 'GET',
          url: '/api/get_year_usage_data_by_site',
          headers: {
           'Accept': 'application/json'
          },
          params: { site: $scope.site_name, year: $("#display_date_label").text(), load_type: $(".iradio_minimal.checked [name='r4']").val() || "Demand" }
        }

        $http(req).then(function(result){
          data = result.data.data;
          drawYearChart(data);
          console.log(result);
        }, 
        function(data){
          console.log(data);
        });

      }
      function drawYearChart(data){
        var data = google.visualization.arrayToDataTable(data);
        var view = new google.visualization.DataView(data);
        var options = {
          title: "Site Demand",
          width: 1500,
          height: 420,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
        };

        var chart = new google.visualization.ColumnChart(document.getElementById("year-chart"));
        chart.draw(view, options);

      }

      /* Year Demand Chart End */    

    }]);