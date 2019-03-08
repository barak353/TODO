var NoteManager = angular.module('TaskManager', ['ngRoute']);
var loggedIN = 0;

// create the controller and inject Angular's $scope
NoteManager.controller('mainController', function ($scope) {
    $scope.message = 'TaskManager main page';
});

// create the register controller
NoteManager.controller('registerController', function ($scope) {
    $scope.message = 'TaskManager register page.';
});

// create the tasks controller
NoteManager.controller('notesController', function ($scope) {
    $scope.message = 'TaskManager Manage Note page.';
});





