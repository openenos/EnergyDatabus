angular.module('enos.services')
  .factory('GoogleChartService', ['$resource', function ($resource) {
    var defaultHeaders = {'Accept': 'application/json'};

    return $resource('/sales/:id', {id: '@id'}, {
      'all': {method: 'GET', headers: defaultHeaders, 
        params: {start: 0, limit: 25, order_by: 'sale_date', order: 'desc'}},
      'save': {method: 'PUT', headers: defaultHeaders},
      'create': {method: 'POST', headers: defaultHeaders},
      'refresh': {method: 'GET', url: '/sales/refresh', headers: defaultHeaders},

      'deliver': {method: 'PUT', url: '/sales/:id/deliver', headers: defaultHeaders},
      'confirm': {method: 'PUT', url: '/sales/:id/confirm', headers: defaultHeaders},
      'reject': {method: 'DELETE', url: '/sales/:id/reject', headers: defaultHeaders},

      'delete': {method: 'DELETE', url: '/sales/:id', headers: defaultHeaders}
    });
  }]);
