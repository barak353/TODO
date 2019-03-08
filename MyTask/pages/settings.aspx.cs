using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Drawing;

public partial class pages_settings : System.Web.UI.Page
{
    public String conString = ConfigurationManager.ConnectionStrings["sqlapp"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"]==null)
            {
                Response.Redirect("../Default.aspx");
            }
            EditData();
        }
    }

    private void EditData()
    {
        using (SqlConnection con=new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Select * from User_Table where UserName='"+Session["username"]+"'",con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                txtusername.Text = reader["UserName"].ToString();
                txtfullname.Text = reader["Name"].ToString();
                txtemail.Text = reader["Email"].ToString();
            }
        }
    }

   

   

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Update User_Table set Password='" + txtpassword.Text + "'", con);
            con.Open();
            cmd.ExecuteNonQuery();
            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "Your account setting updates successfully!";
        }
    }
}