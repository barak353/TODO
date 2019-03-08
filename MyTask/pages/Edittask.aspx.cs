using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class pages_Edittask : System.Web.UI.Page
{
    String conString = ConfigurationManager.ConnectionStrings["sqlapp"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] == null && Session["EditId"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
            GetUpdateData();
        }
    }

    private void GetUpdateData()
    {

        String Id = Session["EditId"].ToString();
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Select * from tbltaskdata where id='" + Id + "'", con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                TextBox5.Text = reader["username"].ToString();
                TextBox1.Text = reader["Description"].ToString();
                
                DropDownListcategorizedtask.SelectedValue = reader["Category"].ToString();
                DropDownList1.SelectedValue = reader["Priority"].ToString();
            }
        }
    }
    protected void Updatetask(object sender, EventArgs e)
    {
        using (SqlConnection con=new SqlConnection(conString))
        {
            string query = "UPDATE tbltaskdata SET Description=@Description, Category=@Category, Priority=@Priority  WHERE username=@username";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Description", TextBox1.Text);
           
            cmd.Parameters.AddWithValue("@username", TextBox5.Text);
            cmd.Parameters.AddWithValue("@Category", DropDownListcategorizedtask.SelectedValue);
            cmd.Parameters.AddWithValue("@Priority", DropDownList1.SelectedValue);
            con.Open();
            cmd.ExecuteNonQuery();
            Response.Redirect("Alltaskpage.aspx");
        }
    }
}