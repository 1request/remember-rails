App = angular.module('RememberApp', ['ngRoute', 'templates'])
App.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "home.html"
      controller: "WelcomeCtrl"

App.controller "WelcomeCtrl", ($scope, $http) ->
  $http.get '/users'
    .success (data) ->
      $scope.users = data