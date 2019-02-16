<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="calendar.aspx.cs" Inherits="pages_calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server" >
    <link rel="stylesheet" href="../css/notes.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'>
    <script src="../TaskManScript/app.js"></script>
   <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

                  <p class="lead">Manage your tasks</p>
    <!-- Insert here-->


        <form id="form1" runat="server">  
    <div>  
        <p style="text-align: center">  
        <b></b>  
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial Black" Font-Size="Medium"  
            ForeColor="#0066FF">My tasks presented in calendar</asp:Label><br /></b>  
        </p>  
        <asp:Calendar ID="Calendar1" runat="server" BackColor="#FFFFCC" BorderColor="#FFCC66"  
            BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"  
            ForeColor="#663399" ShowGridLines="True" OnDayRender="Calendar1_DayRender" OnSelectionChanged="Calendar1_SelectionChanged"  
            OnVisibleMonthChanged="Calendar1_VisibleMonthChanged">  
            <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />  
            <SelectorStyle BackColor="#FFCC66" />  
            <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />  
            <OtherMonthDayStyle ForeColor="#CC9966" />  
            <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />  
            <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />  
            <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />  
        </asp:Calendar>  
        <br />  
        <b></b>  
        <asp:Label ID="LabelAction" runat="server"></asp:Label><br />  
        </b>  
    </div>  
    </form>




    <!-- Untill here! -->
    
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

