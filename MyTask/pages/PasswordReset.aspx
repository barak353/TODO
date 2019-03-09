<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PasswordReset.aspx.cs" Inherits="pages_PasswordReset" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script src="../MyTaskScript/register.js"></script>
    <script src="../MyTaskScript/script.js"></script>
    <div class="container">
        <div class="wrapper">
            <html>
                <body style="background-image : url(../images/bbk.png)">
                    <form runat="server" action="" method="post" name="Login_Form" class="form-signin" style="background-image : url(images/bk.jpg)" >
                    <br>
                    <h3 style="color:red" class="form-signin-heading">To reset your password enter your user name</h3>
                    <center>
                    <input type="text" id="regUsername" class="form-control" name="Username" placeholder="Insert user name" required="" autofocus="" />
                    <asp:Button ID="Submit" runat="server" name="Submit" OnClick="Submit_Click" CommandName="ThisBtnClick" Text="Submit" class="btn btn-lg btn-primary btn-block" style="background-color:#e62e00" />
                    </center>
                    <asp:Panel runat="server" ID="email" Visible="false">
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        The user name is not exist.             
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="emailnotfound" Visible="false">
                    <div class="alert alert-dismissible alert-success">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                         To reset your password click on the link that was sent to your email.
                    </div>
                </asp:Panel>
            </form>
                </body>
            </html>
        </div>
    </div>
</asp:Content>
