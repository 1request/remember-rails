App = angular.module('RememberApp', ['ngRoute', 'templates'])
App.config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "home.html"
    .when '/users',
      templateUrl: "users.html"
      controller: "WelcomeCtrl"
    .when '/users/:id/groups',
      templateUrl: "groups.html"
      controller: "UserGroupsCtrl"
    .when '/groups/:id/audios',
      templateUrl: "audios.html"
      controller: "AudiosCtrl"
    .when '/groups',
      templateUrl: "groups.html"
      controller: "GroupsCtrl"
    .when '/memberships',
      templateUrl: "memberships.html"
      controller: "MembershipsCtrl"
    .when '/feedbacks',
      templateUrl: "feedbacks.html"
      controller: "FeedbacksCtrl"
    .otherwise
      redirectTo: '/users'
  $locationProvider.html5Mode(true);

App.controller "WelcomeCtrl", ($scope, $http) ->
  $http.get '/users'
    .success (data) ->
      $scope.users = data

App.controller "UserGroupsCtrl", ($scope, $http, $routeParams) ->
  $scope.showMember = true
  $http.get "/users/#{$routeParams.id}/groups.json"
    .success (data) ->
      $scope.groups = data

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

App.controller "FeedbacksCtrl", ($scope, $http) ->
  $http.get '/feedbacks.json'
    .success (data) ->
      $scope.feedbacks = data
