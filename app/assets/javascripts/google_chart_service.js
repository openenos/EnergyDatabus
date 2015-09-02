angular.module('enos.services')
  .factory('GoogleChartService', ['$resource', function ($resource) {
    var defaultHeaders = {'Accept': 'application/json'};

    return $resource('/web_services/:id', {id: '@id'}, {
      'piechart': {method: 'GET', url: 'api/get_last_month_data_by_load_type', headers: defaultHeaders},
      'data_tables': {method: 'GET', url: 'api/get_last_month_data_by_site', headers: defaultHeaders}, 
      'line_chart': {method: 'GET', url: 'api/get_last_year_data', headers: defaultHeaders }
    });
  }]);
