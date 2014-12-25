App = angular.module('RememberApp', ['ngRoute', 'templates'])
App.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "home.html"
      controller: "WelcomeCtrl"

App.controller "WelcomeCtrl", ($scope) ->
  $scope.things = ['Angular', 'Rails 4.1', 'Working', 'Together!!']