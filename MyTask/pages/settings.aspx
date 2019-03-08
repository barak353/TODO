<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="settings.aspx.cs" Inherits="pages_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">



    <html>
    <body style="background-image: url(../images/bbk.png)">
        <div class="container">
            <div class="wrapper">
                <form runat="server">
                    <div class="form-signin" ng-app="updateApp" ng-controller="mainController">
                        <h3 style="color: red" class="form-signin-heading">Update Your Account Details</h3>
                        <hr style="color: red" class="line">

                        <asp:TextBox ID="txtusername" runat="server" placeholder="Username" CssClass="form-control"></asp:TextBox>
                        <asp:TextBox ID="txtfullname" runat="server" placeholder="Full Name" CssClass="form-control"></asp:TextBox>
                        <asp:TextBox ID="txtemail" runat="server" placeholder="Email" CssClass="form-control"></asp:TextBox>
                        <br />
                        <asp:TextBox ID="txtpassword" TextMode="Password" placeholder="Password" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:TextBox ID="txtcpassword" TextMode="Password" placeholder="Confirm Password" runat="server" CssClass="form-control"></asp:TextBox>

                        <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" CssClass="btn btn-lg btn-primary btn-block" style="background-color: #e62e00" runat="server" Text="Update" />
                        <br />
                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                    </div>
                </form>

            </div>
        </div>
    </body>
    </html>

</asp:Content>
