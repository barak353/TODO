angular.module('noteApp', [])

    .controller('mainController', function ($scope, $http) {
        //Initialize search parameters
        $scope.sortType = 'id';
        $scope.sortReverse = false;  
        $scope.searchTask = '';    

        // create the list of Tasks
        $scope.tasks = [];

        // This function is responsible for page numbering
        $scope.paginate = function (value) {
            var begin, end, index;
            begin = ($scope.currentPage - 1) * $scope.numPerPage;
            end = begin + $scope.numPerPage;
            index = $scope.tasks.indexOf(value);
            if ($scope.searchTask != "")
                return (begin <= index);
            else
                return (begin <= index && index < end);
        };

        //The two following functions are responsible for browsing back and forth on the defined task pages
        $scope.checkPageBack = function () {
            if ($scope.currentPage == 1) return false;
            else return true;
        };

        $scope.checkPageNext = function () {
            if ($scope.currentPage == $scope.totalPages) return false;
            else return true;
        };

        //The function is responsible for the event that a user marks a task as "completed" or deletes its mark
        $scope.check = function (noteId, noteCheck, event) {
            var newState;
            if (noteCheck == "1") {
                newState = "0";
                //client side change
                event.currentTarget.style.color = "black";
            }
            else {
                newState = "1";
                event.currentTarget.style.color = '#90EE90';
            }
            //client side change
            var dataObj = {
                id: noteId,
                check: newState
            };
            $http.post("actions?tp=TaskStatus", dataObj)
            $scope.getTasks();
        };

        $scope.safeApply = function (fn) {
            var phase = this.$root.$$phase;
            if (phase == '$apply' || phase == '$digest') {
                if (fn && (typeof (fn) === 'function')) {
                    fn();
                }
            } else {
                this.$apply(fn);
            }
        };

        $scope.getTasks = function () {
            $http.get("actions?tp=getTasks")
                .then(
                function (d) {
                    $scope.tasks = d.data;
                    //checkers
                    var checkersData = {
                        checkers:[]
                    };
                    for (i = 0; i < $scope.tasks.length;i++) {

                        var task = $scope.tasks[i];

                        // check whether the task completed
                        checkersData.checkers.push({
                            "index": task.id,
                            "check": task.check
                        });
                    }
                    localStorage.setItem("checkers", JSON.stringify(checkersData));

                    // Create a backup for $scope.tasks
                    $scope.notesBac = angular.copy($scope.tasks);
                    $scope.currentPage = 1;
                    $scope.totalItems = $scope.tasks.length;
                    $scope.numPerPage = 5;
                    $scope.totalPages = Math.ceil($scope.tasks.length / $scope.numPerPage);
                    $scope.safeApply();
                }
                );
        }
        $scope.getTasks();

        // The purpose of the function is to insert a new task under the current user
        $scope.newNote = function (content, sTime, eTime, place) {
            var dataObj = {
                content: content,
                startTime: sTime,
                endTime: eTime,
                place: place
            };
            $http.post("actions?tp=newNote", dataObj)
                .then(
                function (d) {
                    $scope.tasks = d.data;
                });
            $scope.getTasks();

        };

        $scope.cancelNewNote = function () {
        };

        //The purpose of the function is to save the changes made in the task
        $scope.save = function (noteId, noteContent,sTime,eTime,place) {
            var dataObj = {
                id: noteId,
                content: noteContent,
                startTime: sTime,
                endTime: eTime,
                place: place
            };
            $http.post("actions?tp=updateTask", dataObj)
                .then(
                function (d) {
                    $scope.tasks = d.data;
                });
        };
        //The purpose of the function is to delete a selected task
        $scope.delete = function (noteId) {
            var isConfirmed = confirm("Are you sure to delete this Task?");
            if (isConfirmed) {
                $scope.tasks = $scope.tasks.filter(function (item) {
                    return item.id !== noteId;
                });
                $http.get("actions?tp=deleteTask&id=" + noteId)
                    .then(
                    function (d) {
                        $scope.tasks = d.data;
                    });
                $scope.getTasks();
            }
            else {
                return false;
            }
        };
    });
