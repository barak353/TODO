using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class pages_Createtask : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["sqlapp"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
        }
    }

    protected void CreateTask(object sender, EventArgs e)
    {
        string Description = Request.Form["description"];
      
        string Category = DropDownListcategorizedtask.SelectedValue;
        string Urgency = DropDownList1.SelectedValue;
        string username = Session["username"].ToString();

        using (SqlConnection con=new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Insert into tbltaskdata(Description,Category,Priority,username, Mark) values('" + Description+"','"+Category+"','"+ Urgency + "','"+username+"','false')",con);
            con.Open();
            cmd.ExecuteNonQuery();
            Response.Redirect("Alltaskpage.aspx");
        }

        
    }
}