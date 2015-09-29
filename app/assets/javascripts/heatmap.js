//This js file has all the script related to heatmap page of the application for a given Site

angular.module('enos.controllers')
	.controller('HeatmapController', ['$scope', '$window', '$http',  
    function ($scope, $window, $http){
    	$scope.site_name = $("#site").text(); 


    	// start

    	$scope.getWeatherReport = function(){
    		var req = {
					method: 'GET',
					url: '/api/get_heat_map',
					headers: {
					 'Accept': 'application/json'
					},
					params: { site: $scope.site_name }
				}

				$http(req).then(function(result){
					data = result.data.data
					max = result.data.max
					createHeatMap(data, max)
					//console.log(data)
				}, 
				function(data){
					console.log(data);
				});

    	}
    	$scope.getWeatherReport();

    	function createHeatMap(data){
    		// minimal heatmap instance configuration
				var heatmapInstance = h337.create({
				  // only container is required, the rest will be defaults
				  container: document.querySelector('.heatmap')
				});
				var data = { 
				  max: max, 
				  data: data 
				};
				heatmapInstance.setData(data);
    	}

    	// end


}]);