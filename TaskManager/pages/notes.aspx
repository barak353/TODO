<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="notes.aspx.cs" Inherits="pages_notes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server" >
    <link rel="stylesheet" href="../css/notes.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'>
    <script src="../TaskManScript/app.js"></script>
   

                  <p class="lead">Manage your tasks</p>


            </div>
    <div class="container" >
        <div class="row">
            <div class="col-md-10 col-md-offset-1">

                <div class="panel panel-default panel-table" ng-app="noteApp" ng-controller="mainController">

                    <div class="panel-heading">
                        <div class="row">
                            <div class="col col-xs-12">
                                <h3 class="panel-title">My Tasks</h3>
                            </div>
                        </div>
                        <div class="container">
                            <div id="searchForm" class="row">
                                <div id="custom-search-input">
                                    <div class="input-group col-md-10 col-xs-8">
                                        <input type="text" class="  search-query form-control" placeholder="Search" ng-model="searchTask" />
                                        <span class="input-group-btn">
                                            <button class="btn btn-danger" type="button">
                                                <span style="color:#e62e00" class=" glyphicon glyphicon-search"></span>
                                            </button>
                                         
                                        </span>
                                    </div>
                                   
                                </div> 
                                <div>
                                     <div class="col-md-2 text-center ">
                                    <button type="button" class="btn btn-sm btn-primary btn-create"  style="background-color:#e62e00"  onclick="newNote()">New Task</button>
                                </div>
                                </div>
                                
                            </div>
                            <div id="newNote" class="row" style="display: none">
                                <div id="custom-search-input">
                                    <div class="input-group col-md-10 col-xs-8">
                                        <input type="text" class=" form-control" placeholder="Task Description" ng-model="newNoteContent" id="newNoteContent"/>
                                        <input type="text" class=" form-control" placeholder="From When?" style="display: inline-block; margin-top: 10px"  ng-model="newNoteSTime" id="newNoteSTime"/>
                                        <input type="text" class=" form-control" placeholder="To When?" ng-model="newNoteETime" style="display: inline-block; margin-top: 10px" id="newNoteETime"/>
                                        <input type="text" class=" form-control" placeholder="Where?" ng-model="newNotePlace" style="display: inline-block; margin-top: 10px" id="newNotePlace"/>
                                    </div>

                                </div>
                                <div class="col-md-2 text-right col-xs-2">
                                    <center>
                                    <button type="button" style="background-color:#e62e00" class="btn btn-sm btn-primary btn-create" ng-click="newNote(newNoteContent,newNoteSTime,newNoteETime,newNotePlace)" onclick="cancelNewNote()" >Add Task</button>
                                    <button style="background-color:#000000" type="button" class="btn btn-sm btn-danger btn-create" ng-click="cancelNewNote()" onclick="cancelNewNote()">Cancel</button> 
                                    </center>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-list" id="notesTable">
                            <colgroup>
                                <col width="10">
                                <col width="2">
                                <col width="350">
                                <col width="10">
                            </colgroup>
                            <thead>
                                <tr>
                                 <th></th>
                                    <th class="">
                                        <a href="#" ng-click="sortType = 'id'; sortReverse = !sortReverse">ID
                                <span ng-show="sortType == 'id' && !sortReverse" class="fa fa-caret"></span>
                                            <span ng-show="sortType == 'id' && sortReverse" class="fa fa-caret-up"></span>
                                        </a></th>
                                    <th>
                                        <a href="#" ng-click="sortType = 'note'; sortReverse = !sortReverse">Task Description
                                <span ng-show="sortType == 'note' && !sortReverse" class="fa fa-caret-down"></span>
                                            <span ng-show="sortType == 'note' && sortReverse" class="fa fa-caret-up"></span>
                                        </a></th>
                                    <th><a class="fa fa-caret"> Edit or Delete</a></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="note in tasks | orderBy:sortType:sortReverse | filter: searchTask | filter:paginate">
                                    <td>
                                        <em class="fa fa-check-circle" style="font-size:48px;color:red" ng-click="check(note.id,note.check,$event)" ng-model="note.check" ng-value="note.check" ng-style="note.check === 1 ? { color:'#e62e00' } : { 'color': 'gray' }" ></em>
                                    </td>
                                    <td class="">
                                        <span>{{$index+1}}</span>
                                    </td>
                                    <td>
                                        <p>
                                            <span><u>{{note.note}}</u></span>
                                            <span style="color: #428bca">. From {{note.startTime}} to {{note.endTime}} at {{note.place}} </span>
                                        </p>  
                                        
                                       <label id="edit" style="display: none"> <h5>Task name: </h5></label>
                                       <input ng-model="note.note" type="text" style="display: none; margin-top: 4px" /> 
                                         <label id="edit" style="display: none"> <h5>Start time: </h5></label>
                                        <input ng-model="note.startTime" type="text" style="display: none; margin-top: 4px" />
                                        <p></p> <label id="edit" style="display: none"> <h5>Finish time: </h5></label>
                                        <input ng-model="note.endTime" type="text" style="display: none; margin-top: 4px" />
                                         <label id="edit" style="display: none"> <h5>Place: </h5></label>
                                        <input ng-model="note.place" type="text" style="display: none; margin-top: 4px" />
                                            
                                    </td>
                                    <td align="center">
                                        <a class="btn btn-default"  onclick="EditMode(this,1)"><em class="fa fa-edit"></em></a>
                                        <a class="btn btn-danger" style="background-color:#e62e00" ng-click="delete(note.id)"><em class="fa fa-trash"></em></a>
                                        <a class="btn btn-default" onclick="EditMode(this,2)" ng-click="save(note.id,note.note,note.startTime,note.endTime,note.place)" style="display: none;" ><em class="fa fa-save"></em></a>
                                    </td>


                                </tr>


                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col col-xs-5">
                                Page {{currentPage}} of {{totalPages}}
                            </div>
                            <div class="col col-xs-7">
                                <ul class="pagination hidden pull-right">
                                    <li><a href="#tasks">1</a></li>
                                    <li><a href="#tasks">2</a></li>
                                    <li><a href="#tasks">3</a></li>
                                    <li><a href="#tasks">4</a></li>
                                    <li><a href="#tasks">5</a></li>
                                </ul>
                                <ul class="pagination pull-right">
                                    <li><a href="#tasks" data-ng-click="currentPage=currentPage-1" ng-show="checkPageBack()">«</a></li>
                                    <li><a href="#tasks" data-ng-click="currentPage=currentPage+1" ng-show="checkPageNext()">»</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        
        function EditMode(el, isEdit) {
            if (isEdit == 1) {
                $(el).hide();
                $(el).next().hide();
                $(el).next().next().show();
                $(el).parent().prev().find("span").hide();
                $(el).parent().prev().find("input").show();
                $(el).parent().prev().find("label").show();
                
            } else if (isEdit == 2) {
                $(el).hide();
                $(el).prev().show();
                $(el).prev().prev().show();
                $(el).parent().next().next().find("span").show();
                $(el).parent().next().next().find("input").hide();
                $(el).parent().next().next().find("label").hide();
                $("#edit").hide();
            }
        }

        function newNote() {
            $("#searchForm").hide();
            $("#newNote").show();
            document.getElementById('newNoteContent').value = "";
            document.getElementById('newNoteSTime').value = "";
            document.getElementById('newNoteETime').value = "";
            document.getElementById('newNotePlace').value = "";

            
        }

        function cancelNewNote() {
            $("#newNote").hide();
            $("#searchForm").show();
        }
    </script>


</asp:Content>

