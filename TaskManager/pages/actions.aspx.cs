using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SiteMaster;

public partial class pages_getTasks : System.Web.UI.Page
{
    public String conString = SiteMaster.conString;
    // When the page loads, extract all the relevant information to the user who is logged in from the database to view it.
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["tp"] == null)
        {
            Response.Redirect("Notes.aspx");
        }
        switch (Request["tp"])
        {
            case "getAccountInfo":
                getAccountInfo();
                break;
            case "updateAccountInfo":
                string json3;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    json3 = reader.ReadToEnd();
                }
                updateAccountInfo(json3);
                break;
            case "getTasks":
                getTasks();
                break;
            case "deleteTask":
                if (Request["id"] == null)          
                    Response.Redirect("Notes.aspx");
                deleteTask(Request["id"]);
                break;
            case "updateTask":
                string json;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    json = reader.ReadToEnd();
                }
                updateTask(json);
                break;
            case "newNote":
                string json2;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    json2 = reader.ReadToEnd();
                }
                newNote(json2);
                break;
            case "TaskStatus":
                string TaskStatusData;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    TaskStatusData = reader.ReadToEnd();
                }
                TaskStatus(TaskStatusData);
                break;
        }

    }

    //The purpose of the function is to read from the database all the account information of the currently connected user
    void getAccountInfo()
    {
        String query;
        //Create a connection to the database
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;
            //Extract all user's account information
            query = "SELECT userName,fullName,email FROM User_Table WHERE userName = '" + Session["username"] + "'";
            cmd = new SqlCommand(query, sqlConnection);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var username = "";
            var fullname = "";
            var email = "";
            while (reader.Read())
            {
                username = reader.GetValue(0).ToString().Trim();
                fullname = reader.GetValue(1).ToString().Trim();
                email = reader.GetValue(2).ToString().Trim();
            }
            if (username == "")
                Response.Redirect("Notes.aspx");

            var jsonResult = new StringBuilder();
            jsonResult.Append("[\n");
            jsonResult.Append("{ username: '" + username + "', fullname: '" + fullname + "', email: '" + email + "' }");
            jsonResult.Append("\n]");
            Response.Write(JsonConvert.DeserializeObject(jsonResult.ToString()));

        }
        sqlConnection.Close();
    }
    //The purpose of the function is to update the user's account information by update query of all details
    void updateAccountInfo(string json)
    {
        if (json == null)
            Response.Redirect("Notes.aspx");
        var info = JObject.Parse(json);
        string fullname = info["fullname"].ToString().Trim();
        string email = info["email"].ToString().Trim();
        string password = info["password"].ToString().Trim();

        String query;
        //Create a connection to the database
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;

            if(password=="")
                query = "UPDATE User_Table SET fullName='" + fullname + "', email='" + email + "' WHERE userName = '" + Session["username"] + "'";
            else
                query = "UPDATE User_Table SET fullName='" + fullname + "', email='"+ email +"', password='"+ password +"' WHERE userName = '" + Session["username"]+"'";
            cmd = new SqlCommand(query, sqlConnection);
            cmd.ExecuteNonQuery();
            getAccountInfo();
        }
        sqlConnection.Close();
    }

    //The purpose of the function is to read all the tasks listed under the current user
    void getTasks()
    {
        String query;
        //Create a connection to the database
        SqlConnection sqlConnection2 = new SqlConnection(conString);
        sqlConnection2.Open();
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open && sqlConnection2.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;

            query = "SELECT id FROM User_Table WHERE userName = '" + Session["username"] + "'";
            cmd = new SqlCommand(query, sqlConnection);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var user_id = "";
            while (reader.Read())
                user_id = reader.GetValue(0).ToString();
            if (user_id == "")
                Response.Redirect("Notes.aspx");

            //get tasks from DB for this user
            query = "SELECT * FROM Notes_Table where user_id = '" + user_id + "'";
            cmd = new SqlCommand(query, sqlConnection2);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var jsonResult = new StringBuilder();
            if (!reader.HasRows)
                jsonResult.Append("[]");
            else
            {
                jsonResult.Append("[\n");
                while (reader.Read())
                {
                    jsonResult.Append("{ id: " + reader.GetValue(0).ToString() + ", note: '" + reader.GetValue(1).ToString() + "', check: "+reader.GetValue(3).ToString()+ ", startTime: '" + reader.GetValue(4).ToString() + "', endTime: '" + reader.GetValue(5).ToString() + "', place: '" + reader.GetValue(6).ToString() + "'},");
                }
                jsonResult.Append("\n]");
            }
            Response.Write(JsonConvert.DeserializeObject(jsonResult.ToString()));
        }
        sqlConnection.Close();
    }
    //The purpose of the function is to update the details of a task that has been defined and its details changed
    void updateTask(string json)
    {
        if (json == null)
            Response.Redirect("Notes.aspx");
        var info = JObject.Parse(json);
        string id = info["id"].ToString();
        string content = info["content"].ToString();
        string when = info["startTime"].ToString();
        string untilWhen = info["endTime"].ToString();
        string where = info["place"].ToString();
        String query;
        //Create a connection to the database
        SqlConnection sqlConnection2 = new SqlConnection(conString);
        sqlConnection2.Open();
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open && sqlConnection2.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;
            query = "SELECT user_id FROM Notes_Table where id = " + id;
            cmd = new SqlCommand(query, sqlConnection);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var user_id = "";
            while (reader.Read())
                user_id = reader.GetValue(0).ToString();
           
            if (user_id == "")
                Response.Redirect("Notes.aspx");
          
            //Update task's details for this user
            query = "UPDATE Notes_Table SET content='"+ content + "', startTime='" + when + "', endTime='" + untilWhen + "', place='" + where + "' WHERE id = " + id;
            cmd = new SqlCommand(query, sqlConnection2);
            cmd.ExecuteNonQuery();
            getTasks();
        }
        sqlConnection.Close();
        sqlConnection2.Close();
    }

    //The purpose of the function is to delete the specified task information
    void deleteTask(string id)
    {
        String query;
        //Create a connection to the database
        SqlConnection sqlConnection2 = new SqlConnection(conString);
        sqlConnection2.Open();
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open && sqlConnection2.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;
            query = "SELECT user_id FROM Notes_Table where id = " + id;
            cmd = new SqlCommand(query, sqlConnection);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var user_id = "";
            while (reader.Read())
                user_id = reader.GetValue(0).ToString();
           
            if (user_id == "")
                Response.Redirect("Notes.aspx");

            //Delete query
            query = "DELETE FROM Notes_Table where id = " + id;
            cmd = new SqlCommand(query, sqlConnection2);
            reader = (SqlDataReader)cmd.ExecuteReader();
            getTasks();
        }
        sqlConnection.Close();
        sqlConnection2.Close();
    }

    //The purpose of the function is to add a new task by intert query
    void newNote(string json)
    {
        if (json == null)
            Response.Redirect("Notes.aspx");
        var info = JObject.Parse(json);
        string content = info["content"].ToString();
        string when = info["startTime"].ToString();
        string untilWhen = info["endTime"].ToString();
        string where = info["place"].ToString();      
        String query;
        //Create a connection to the database
        SqlConnection sqlConnection2 = new SqlConnection(conString);
        sqlConnection2.Open();
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open && sqlConnection2.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;

            query = "SELECT id FROM User_Table where userName = '" + Session["username"]+"'";
            cmd = new SqlCommand(query, sqlConnection);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var user_id = "";
            while (reader.Read())
                user_id = reader.GetValue(0).ToString();

            //intert query
            query = "INSERT INTO Notes_Table VALUES('" + content + "', '" + user_id + "', '0', '" + when + "', '" + untilWhen + "', '" + where + "')";
            cmd = new SqlCommand(query, sqlConnection2);
            cmd.ExecuteNonQuery();
            getTasks();
        }
        sqlConnection.Close();
        sqlConnection2.Close();
    }
    //The purpose of the function is to check the task status - whether completed or not
    void TaskStatus(string json)
    {
        if (json == null)
        {
            Response.Redirect("Notes.aspx");
        }
        var info = JObject.Parse(json);
        string id = info["id"].ToString();
        string checker = info["check"].ToString();
        String query;
        //Create a connection to the database
        SqlConnection sqlConnection2 = new SqlConnection(conString);
        sqlConnection2.Open();
        SqlConnection sqlConnection = new SqlConnection(conString);
        sqlConnection.Open();
        if (sqlConnection.State == System.Data.ConnectionState.Open && sqlConnection2.State == System.Data.ConnectionState.Open)
        {
            SqlCommand cmd;
            SqlDataReader reader;
            query = "SELECT user_id FROM Notes_Table where id = " + id;
            cmd = new SqlCommand(query, sqlConnection);
            reader = (SqlDataReader)cmd.ExecuteReader();
            var user_id = "";
            while (reader.Read())
                user_id = reader.GetValue(0).ToString();
            if (user_id == "")
                Response.Redirect("Notes.aspx");
            //Update task's status for this user
            query = "UPDATE Notes_Table SET [check] = " + checker+ " WHERE id = " + id;
            cmd = new SqlCommand(query, sqlConnection2);
            cmd.ExecuteNonQuery();
            getTasks();
        }
        sqlConnection.Close();
        sqlConnection2.Close();
    }
}