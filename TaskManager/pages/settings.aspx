<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="settings.aspx.cs" Inherits="pages_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script>
        angular.module('updateApp', [])

            .controller('mainController', function ($scope, $http) {
                //Initializing variables
                $scope.username = '';
                $scope.fullname = '';
                $scope.email = ''
                $scope.password = '';
                $scope.repassword = '';

                //Function that checks the integrity of an input in the email field
                $scope.validateEmail = function(email) {
                    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                    return re.test(String(email).toLowerCase());
                }

                //Function that takes information from the database
                $scope.getInfo = function () {
                    $http.get("actions?tp=getAccountInfo")
                        .then(
                        function (d) {
                            $scope.username = (d.data)[0].username;
                            $scope.fullname = (d.data)[0].fullname;
                            $scope.email = (d.data)[0].email;
                        }
                        );
                }
                $scope.getInfo();

                //The function handles the case the user wants to update its details
                $scope.updateInfo = function () {
                    if ($scope.password != $scope.repassword) {
                        alert("Password don't match");
                        return false;
                    }
                    if (!$scope.validateEmail($scope.email)) {
                        alert("Please insert valid email");
                        return false;
                    }
                    var dataObj = {
                        fullname: $scope.fullname,
                        email: $scope.email,
                        password: $scope.password
                    };
                    $http.post("actions?tp=updateAccountInfo", dataObj)
                        .then(
                        function (d) {
                            $scope.username = (d.data)[0].username;
                            $scope.fullname = (d.data)[0].fullname;
                            $scope.email = (d.data)[0].email;
                            $scope.password = '';
                            $scope.repassword = '';
                        });
                    alert("Your account setting updates successfully!");

                };

            });
    </script>


    <div class = "container">
	<div class="wrapper">
		<div class="form-signin" ng-app="updateApp" ng-controller="mainController">       
		    <h3 style="color:red" class="form-signin-heading">Update Your Account Details</h3>
			  <hr style="color:red" class="line">
			  
			   <input runat="Server" ng-model="username" type="text" class="form-control" id="username" placeholder="Username" required="" autofocus="" disabled />
			   <input runat="Server" ng-model="fullname" type="text" class="form-control" id="fullname" placeholder="Full Name" required="" autofocus="" />
			   <input runat="Server" ng-model="email" type="text" class="form-control" id="email" placeholder="Email" required="" autofocus="" />
			   <br>
			   <input ng-model="password" type="password" class="form-control" name="password" placeholder="New Password" autofocus="" />
			   <input ng-model="repassword" type="password" class="form-control" name="repassword" placeholder="New Password Verification" autofocus="" />
			 
			  <button class="btn btn-lg btn-primary btn-block" style="background-color:#e62e00" name="Submit" ng-click="updateInfo()" value="Update" type="Submit">Update</button>  			
		</div>			
	</div>
</div>
</asp:Content>
