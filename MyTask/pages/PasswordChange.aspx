<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PasswordChange.aspx.cs" Inherits="pages_PasswordChange" %>

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
                    <h1 style="color:red" class="form-signin-heading">Enter Password and new Password</h1>
                    <center>
                    <input type="password" id="regPassword" class="form-control" name="password" placeholder="Password" required autofocus="" />
                <input type="password" id="regRePassword" class="form-control" name="repassword" placeholder="Password Verification" required autofocus="" />

                   <asp:Button ID="Save" runat="server" name="Submit" OnClick="Save_Click" CommandName="ThisBtnClick" Text="Save" class="btn btn-lg btn-primary btn-block" style="background-color:#6f0f62" />
                  
                    </center>
                 <asp:Panel runat="server" ID="linknotvalid" Visible="false">
                        <div class="alert alert-dismissible alert-danger">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            Password Reset Link has expired or is invalid
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="passwordchanged" Visible="false">
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
