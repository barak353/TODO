<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="pages_ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script src="../TaskManScript/register.js"></script>
    <script src="../TaskManScript/script.js"></script>
    <div class="container">
        <div class="wrapper">
            <html>
                <body style="background-image : url(../images/bbk.png)">


                    <form runat="server" action="" method="post" name="Login_Form" class="form-signin" style="background-image : url(images/bk.jpg)" >
                    <!--<hr class="colorgraph">-->
                    <br>
                    <h1 style="color:red" class="form-signin-heading">Enter username to Reset Password</h1>
                    <center>
                    <input type="text" id="regUsername" class="form-control" name="Username" placeholder="Username" required="" autofocus="" />

                    <asp:Button ID="Submit" runat="server" name="Submit" OnClick="Submit_Click" CommandName="ThisBtnClick" Text="Submit" class="btn btn-lg btn-primary btn-block" style="background-color:#6f0f62" />
                  
                    </center>
                    <asp:Panel runat="server" ID="email" Visible="false">
                    <div class="alert alert-dismissible alert-danger">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                        UserName not found!
                      
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="emailnotfound" Visible="false">
                    <div class="alert alert-dismissible alert-success">
                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                         An email with instructions to reset your password is send to your email
                    </div>
                </asp:Panel>
            </form>

              
               
                </body>
            </html>
           
            

        </div>
    </div>

</asp:Content>
