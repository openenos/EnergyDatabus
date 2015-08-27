// Here We have defined all Angular JS files

angular.module('enos', ['googlechart', 'enos.controllers', 'ngRoute']);
angular.module('enos.controllers', ['enos.services', 'enos.factories']);
//angular.module('enos', ['enos.controllers', 'googlechart', 'ngRoute']);

angular.module('enos.services', ['ngResource']);
angular.module('enos.factories', []);