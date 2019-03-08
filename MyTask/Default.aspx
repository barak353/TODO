<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
    <!--<%@ MasterType VirtualPath="~/MasterPage.master" %>-->
    <script src="TaskManScript/script.js"></script>
    <link rel="stylesheet" href="css/home.css">
    <asp:Panel runat="server" ID="login" Visible="true" >
        <div class="container">
            <div class="wrapper">
                 <html>
   
                <body style="background-image : url(images/bbk.png)">

                <form runat="server" action="" method="post" name="Login_Form" class="form-signin" style="background-image : url(images/bk.jpg)" >
                    <!--<hr class="colorgraph">-->
                    <br>
                    <h1 style="color:red" class="form-signin-heading">Welcome to myTask</h1>
                    <center>
                    <input type="text" class="form-control" name="Username" placeholder="User Name" required="" autofocus="" />
                    <input type="password" class="form-control" name="Password" placeholder="Password" required="" />

                    <asp:Button runat="server" class="btn btn-lg btn-primary btn-block" style="background-color:#e62e00" name="Submit" value="Login" type="Submit" Text="Login" OnClick="Login" />
                 
                        If you have not already account. <a href="pages/register.aspx">Register here!</a>
                        <br />
                           If you forgot password.  <a href="pages/ForgotPassword">Click Here</a>
                        
                    </center>
                    <asp:Panel runat="server" ID="alertMsg" Visible="false">
                        <div class="alert alert-dismissible alert-danger">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <strong>User name or password are incorrect </strong>
                            <br />
                            please again.
                        </div>
                    </asp:Panel>

                </form>
         </body>
    </html>
    
            </div>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="succMsg" Visible="false">
        <div class="alert alert-dismissible alert-success">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Welcome Back</strong>
            <asp:Label runat="server" ID="fullnameLabel"></asp:Label>
            <br />
            click <a href="/pages/notes.aspx" class="alert-link">here</a> to see your tasks.
        </div>
    </asp:Panel>
</asp:Content>
