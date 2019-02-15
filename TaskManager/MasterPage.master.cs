using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class SiteMaster : MasterPage
{
    public static string conString = "Data Source=(local);Initial Catalog=NoteManager;Integrated Security=True;";
    private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    private string _antiXsrfTokenValue;
    public string loggedUserName="";

    protected void Page_Init(object sender, EventArgs e)
    {
        // The code below helps to protect against XSRF attacks
        var requestCookie = Request.Cookies[AntiXsrfTokenKey];
        Guid requestCookieGuidValue;
        if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
        {
            // Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value;
            Page.ViewStateUserKey = _antiXsrfTokenValue;
        }
        else
        {
            // Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
            Page.ViewStateUserKey = _antiXsrfTokenValue;

            var responseCookie = new HttpCookie(AntiXsrfTokenKey)
            {
                HttpOnly = true,
                Value = _antiXsrfTokenValue
            };
            if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
            {
                responseCookie.Secure = true;
            }
            Response.Cookies.Set(responseCookie);
        }

        Page.PreLoad += master_Page_PreLoad;
    }

    protected void master_Page_PreLoad(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set Anti-XSRF token
            ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
            ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
        }
        else
        {
            // Validate the Anti-XSRF token
            if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
            {
                throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        Context.GetOwinContext().Authentication.SignOut();
    }
    public void  LoginChanges(String loggedusername1)
    {
        loggedUserNameLabel.Text = loggedusername1;
        
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
                //succMsg.Visible = true;
                fullnameLabel.Text = fullname;
                loggedUserName = username;
                Session["username"] = username;
                LoginChanges(username);
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