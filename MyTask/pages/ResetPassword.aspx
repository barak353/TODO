<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="pages_ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script src="../TaskManScript/register.js"></script>
    <script src="../TaskManScript/script.js"></script>
    <div class="container">
        <div class="wrapper">

            <html>
            <body style="background-image: url(../images/bbk.png)">

                 <form runat="server" action="" method="post" name="Login_Form" class="form-signin" style="background-image : url(images/bk.jpg)" >
                    <!--<hr class="colorgraph">-->
                    <br>
                    <h1 style="color:red" class="form-signin-heading">Enter new Password</h1>
                    <center>
                    <input type="password" id="regPassword" class="form-control" name="password" placeholder="Insert new password" required autofocus="" />
                <input type="password" id="regRePassword" class="form-control" name="repassword" placeholder="Insert new password again" required autofocus="" />

                   <asp:Button ID="Save" runat="server" name="Submit" OnClick="Save_Click" CommandName="ThisBtnClick" Text="Save" class="btn btn-lg btn-primary btn-block" style="background-color:#e62e00" />
                  
                    </center>
                 <asp:Panel runat="server" ID="linknotvalid" Visible="false">
                        <div class="alert alert-dismissible alert-danger">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            Password Reset Link has expired or is invalid
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="passwordreset" Visible="false">
                        <div class="alert alert-dismissible alert-success">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            Password Changed Successfully
                        </div>
                    </asp:Panel>
            </form>

                
            </body>
            </html>



        </div>
    </div>

</asp:Content>
