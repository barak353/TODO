using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using static SiteMaster;

public partial class pages_register : System.Web.UI.Page
{
    public String conString = SiteMaster.conString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != "")
        {
            Response.Redirect("Notes.aspx");
        }

    }
    //The purpose of the function is to create a new user in the system in case it does not already exist
    protected void CreateUser_Click(object sender, EventArgs e)
    {
        String query;
        //Taking values ​​written as input from the user
        String UserName = Request.Form["Username"];
        String Name= Request.Form["FullName"]; ;
        String Email = Request.Form["Email"];
        String Password= Request.Form["password"]; ;
        String RePassword= Request.Form["repassword"]; ;
        if(Password==RePassword)
        {
            //Create a connection to the database
            SqlConnection sqlConnection1 = new SqlConnection(conString);
            sqlConnection1.Open();
            if(sqlConnection1.State==System.Data.ConnectionState.Open)
            {
                SqlCommand cmd;
                SqlDataReader reader;

                //Check whether the user name already exist
                query = "SELECT * " +
                     "FROM User_Table";
                cmd = new SqlCommand(query, sqlConnection1);
                reader = (SqlDataReader)cmd.ExecuteReader();
                Boolean exist = false;
                while(reader.Read())
                    if (reader.GetString(1).Trim().Equals(UserName))
                        exist = true;
                //If we do not find such a username in the DB we create a new username
                if (exist == false)
                {
                    SqlConnection sqlConnection2 = new SqlConnection(conString);
                    sqlConnection2.Open();
                    if (sqlConnection2.State == System.Data.ConnectionState.Open)
                    {
                        query = "INSERT INTO User_Table " +
                        "VALUES('" + UserName + "','" + Name + "','" + Email + "','" + Password + "')";
                        cmd = new SqlCommand(query, sqlConnection2);
                        cmd.ExecuteNonQuery();
                        succMsg.Visible = true;
                        alertMsg.Visible = false;
                    }
                    sqlConnection2.Close();
                }
                else
                {
                    succMsg.Visible = false;
                    alertMsg.Visible = true;
                }
            }
            sqlConnection1.Close();
        }
    }


 }