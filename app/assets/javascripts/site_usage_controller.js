var demoApp = angular.module('demoApp', [
        "angular-dygraphs"
    ]);

    demoApp.controller('DemoCtrl', ['$scope', '$window', '$http', 


    function ($scope, $window, $http) {
       $scope.site_name = $("#site").text();
        $scope.date = $("#current_date").text();
        

        

    }]);