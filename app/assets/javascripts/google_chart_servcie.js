angular.module('enos.services')
  .factory('GoogleChartSevice', ['$resource', function ($resource) {
    var defaultHeaders = {'Accept': 'application/json'};

    return $resource('/tickets/:id', {id: '@id'}, {

      
    });

  }]);

