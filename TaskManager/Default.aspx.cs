using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SiteMaster;

public partial class _Default : Page
{
    public static String conString = SiteMaster.conString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == "")
        {
            login.Visible = true;
            succMsg.Visible = false;
        }
    }

    protected void Login(object sender, EventArgs e)
    {
        String query;
        String inputusername = Request.Form["Username"];
        String inputpassword = Request.Form["Password"];
        String username = "", fullname = "";
        //open connection to our database
        SqlConnection sqlConnection1 = new SqlConnection(conString);
        sqlConnection1.Open();
        if (sqlConnection1.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;
            //check username validality
            query = "SELECT * " +
                 "FROM User_Table";
            cmd = new SqlCommand(query, sqlConnection1);
            reader = (SqlDataReader)cmd.ExecuteReader();
            Boolean exist = false;
            while (reader.Read())
            {
                if (reader.GetString(1).Trim().Equals(inputusername) && reader.GetString(4).Trim().Equals(inputpassword))
                {
                    exist = true;
                    username = reader.GetString(1).Trim();
                    fullname = reader.GetString(2).Trim();
                }
            }
            //the user exist in the database so we updates his details and directs him to the home page 
            if (exist == true)
            {
                login.Visible = false;
                succMsg.Visible = true;
                fullnameLabel.Text = fullname;
                this.Master.loggedUserName = username;
                Session["username"] = username;
                this.Master.LoginChanges(username);
                Response.Redirect("pages/Notes.aspx");
            }
            else
            {
                login.Visible = true;
                succMsg.Visible = false;
                alertMsg.Visible = true; //display alert massege to the user
            }
        }
        sqlConnection1.Close();

    }
}