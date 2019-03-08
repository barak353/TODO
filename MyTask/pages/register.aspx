<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="pages_register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script src="../TaskManScript/register.js"></script>
    <script src="../TaskManScript/script.js"></script>
    <div class="container">
        <div class="wrapper">
            <html>
                <body style="background-image: url(../images/bbk.png)">
                    <form style="background-image: url(images/bk.png)" runat="server" id="registerForm" method="post" name="Register_Form" class="form-signin">
                <asp:ScriptManager ID="scriptM" runat="server" EnablePageMethods="true" />
                <h3 class="form-signin-heading">Register to MyTask</h3>
                
                <center>
                <input type="text" id="regUsername" class="form-control" name="Username" placeholder="Insert user name" required="" autofocus="" />
                <input type="text" id="regFullName" class="form-control" name="FullName" placeholder="Insert full Name" required="" autofocus="" />
                <input type="email" id="regEmail" class="form-control" name="Email" placeholder="Insert email" required="" autofocus="" />
                <br>
                <input type="password" id="regPassword" class="form-control" name="password" placeholder="Insert password" required autofocus="" />
                <input type="password" id="regRePassword" class="form-control" name="repassword" placeholder="Insert password again" required autofocus="" />
                <asp:Button ID="SubmitBut" runat="server" name="Submit" CommandName="ThisBtnClick" Text="Register" OnClick="CreateUser_Click" class="btn btn-lg btn-primary btn-block" style="background-color:#e62e00" />
                </center>
                <asp:Panel runat="server" ID="alertMsg" Visible="false">
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <strong>User Name is taken </strong>try another one.
                   
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="succMsg" Visible="false">
                    <div class="alert alert-dismissible alert-success">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <strong>Welcome!</strong> Go to the home page and login to your Task Manager.
                   
                    </div>
                </asp:Panel>
            </form>
                </body>
            </html>

            

        </div>
    </div>

</asp:Content>
