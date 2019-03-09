<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Alltaskpage.aspx.cs" Inherits="pages_Alltaskpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <link rel="stylesheet" href="../css/notes.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'>
    <script src="../MyTaskScript/app.js"></script>


    <p class="lead">Manage your tasks</p>
    <style>
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        table {
            border: 1px solid #ccc;
            border-collapse: collapse;
        }

            table th {
                background-color: #F7F7F7;
                color: #333;
                font-weight: bold;

            }

            table th, table td {
                padding: 5px;
                border: 1px solid #ccc;
                width:200px;
            }
    </style>
    <html>
        <body>
             <form runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-11 col-md-offset-1">

                    <div class="panel panel-default panel-table">

                        <div class="panel-heading">
                            <div class="row">
                                <div class="col col-xs-12">
                                    <h3 class="panel-title">All Tasks</h3>
                                </div>
                            </div>
                            <div class="container">
                                <div class="col-md-4 col-md-offset-1" style="margin-top:20px">
                                <asp:DropDownList ID="DropDownList2" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Urgency" Value="Select Priority"></asp:ListItem>
                                    <asp:ListItem Text="Maximum" Value="Maximum"></asp:ListItem>
                                    <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                                    <asp:ListItem Text="Minimum" Value="Minimum"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                                <div class="col-md-4 col-md-offset-1" style="margin-top:20px">
                                <asp:DropDownList ID="DropDownList1" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Category" Value="Select Category"></asp:ListItem>
                                    <asp:ListItem Text="Private" Value="Private"></asp:ListItem>
                                    <asp:ListItem Text="School" Value="School"></asp:ListItem>
                                    <asp:ListItem Text="Work" Value="Work"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                               <div class="col-md-1 " style="margin-top:25px">
                                  
                                        <asp:Button ID="CreateTask" class="btn btn-sm btn-primary btn-create" OnClick="CreateTask_Click" Style="background-color: #e62e00" runat="server" Text="New Task" />

                               </div>
                                    
                               
                               
                                
                            </div>
                            

                        </div>
                        <div class="row" style="margin-top:20px">
                            <div class="col-md-10 col-md-offset-1">
                                <div class="panel-body">
                            <asp:GridView ID="GridViewTasks" OnRowEditing="GridViewTasks_RowEditing" OnRowDeleting="GridViewTasks_RowDeleting" runat="server" AutoGenerateColumns="False" OnRowCommand="GridViewTasks_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="Mark">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='false' AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Id" HeaderText="ID" />
                                    <asp:BoundField DataField="Description" HeaderText="Task Description" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" />
                                    <asp:BoundField DataField="Priority" HeaderText="Urgency" />
                                    <asp:TemplateField HeaderText="Edit or Delete">
                                        <ItemTemplate>
                                            <asp:Button ID="Edit" CssClass="btn btn-danger" CommandName="Edit" CommandArgument='<%#Eval("id")%>' runat="server" Text="Edit" />
                                            <asp:Button ID="Del" CssClass="btn btn-danger" CommandName="Delete" CommandArgument='<%#Eval("id")%>' runat="server" Text="Delete" />
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                        </div>
                            </div>
                        </div>
                        

                    </div>

                </div>
            </div>
        </div>
    </form>
        </body>
    </html>
   





</asp:Content>
