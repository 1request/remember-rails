App = angular.module('RememberApp', ['ngRoute', 'templates'])
App.config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/users',
      templateUrl: "home.html"
      controller: "WelcomeCtrl"
    .when '/groups/:id/audios',
      templateUrl: "audios.html"
      controller: "AudiosCtrl"
    .when '/groups',
      templateUrl: "groups.html"
      controller: "GroupsCtrl"
    .when '/memberships',
      templateUrl: "memberships.html"
      controller: "MembershipsCtrl"
    .otherwise
      redirectTo: '/users'
  $locationProvider.html5Mode(true);

App.controller "WelcomeCtrl", ($scope, $http) ->
  $http.get '/users'
    .success (data) ->
      $scope.users = data

App.controller "GroupsCtrl", ($scope, $http) ->
  $http.get '/groups'
    .success (data) ->
      $scope.groups = data

App.controller "AudiosCtrl", ($scope, $http, $routeParams) ->
  $http.get "/audios?group_id=#{$routeParams.id}"
    .success (data) ->
      $scope.audios = data

App.controller "MembershipsCtrl", ($scope, $http) ->
  $http.get '/memberships'
    .success (data) ->
      $scope.memberships = data
