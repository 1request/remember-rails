App = angular.module('RememberApp', ['ngRoute', 'templates'])
App.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "home.html"
    .when '/users',
      templateUrl: "users.html"
      controller: "UsersCtrl"
    .when '/users/:id',
      templateUrl: "user.html"
      controller: "UserCtrl"
    .when '/users/:id/groups',
      templateUrl: "groups.html"
      controller: "UserGroupsCtrl"
    .when '/groups',
      templateUrl: "groups.html"
      controller: "GroupsCtrl"
    .when '/groups/:id',
      templateUrl: "group.html"
      controller: "GroupCtrl"
    .when '/groups/:id/audios',
      templateUrl: "audios.html"
      controller: "AudiosCtrl"
    .when '/groups/:id/users',
      templateUrl: "users.html"
      controller: "GroupUsersCtrl"
    .when '/memberships',
      templateUrl: "memberships.html"
      controller: "MembershipsCtrl"
    .when '/feedbacks',
      templateUrl: "feedbacks.html"
      controller: "FeedbacksCtrl"
    .otherwise
      redirectTo: '/users'
  $locationProvider.html5Mode(true);
]

App.controller "UsersCtrl", ["$scope", "$http", ($scope, $http) ->
  $http.get '/users'
    .success (data) ->
      $scope.users = data

  $scope.remove = (userId) ->
    $http.delete "/users/#{userId}"
      .success (data) ->
        $scope.users = $scope.users.filter (user) ->
          user.id != userId
]

App.controller "UserCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $http.get "/users/#{$routeParams.id}"
    .success (data) ->
      $scope.user = data
]

App.controller "UserGroupsCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $scope.showMember = true
  $http.get "/users/#{$routeParams.id}/groups.json"
    .success (data) ->
      $scope.groups = data
]

App.controller "GroupsCtrl", ["$scope", "$http", ($scope, $http) ->
  $http.get '/groups'
    .success (data) ->
      $scope.groups = data

  $scope.remove = (groupId) ->
    $http.delete "/groups/#{groupId}"
      .success (data) ->
        $scope.groups = $scope.groups.filter (group) ->
          group.id != groupId
]

App.controller "GroupCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $http.get "/groups/#{$routeParams.id}"
    .success (data) ->
      $scope.group = data
]

App.controller "AudiosCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $http.get "/audios?group_id=#{$routeParams.id}"
    .success (data) ->
      $scope.audios = data
]

App.controller "GroupUsersCtrl", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $scope.showMember = true
  $http.get "/groups/#{$routeParams.id}/users.json"
    .success (data) ->
      $scope.users = data
]

App.controller "MembershipsCtrl", ["$scope", "$http", ($scope, $http) ->
  $http.get '/memberships'
    .success (data) ->
      $scope.memberships = data

  $scope.accept = (groupId, userId) ->
    $http.post "/memberships/accept",
      group_id: groupId
      user_id: userId
    .success (data) =>
      @membership.status = 'accepted'

  $scope.reject = (groupId, userId) ->
    $http.post "/memberships/reject",
      group_id: groupId
      user_id: userId
    .success (data) =>
      @membership.status = 'rejected'
]

App.controller "FeedbacksCtrl", ["$scope", "$http", ($scope, $http) ->
  $http.get '/feedbacks.json'
    .success (data) ->
      $scope.feedbacks = data
]
