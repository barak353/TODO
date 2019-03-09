using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class pages_ResetPassword : System.Web.UI.Page
{
    String conString = ConfigurationManager.ConnectionStrings["sqlapp"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!IsPasswordLinkValid())
            {
                linknotvalid.Visible = true;
                passwordreset.Visible = false;
                Save.Enabled = false;
            }
           
        }
    }

    private bool ExecuteStoreProcedure(string SName, List<SqlParameter> sqlParameters)
    {
       
        using (SqlConnection con=new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand(SName, con);
            cmd.CommandType = CommandType.StoredProcedure;

            foreach (SqlParameter parameter in sqlParameters)
            {
                cmd.Parameters.Add(parameter);
            }

            con.Open();
            return Convert.ToBoolean(cmd.ExecuteScalar());
        }
    }

    private bool UserPasswordReset()
    {
        String Password = Request.Form["password"]; ;
        String RePassword = Request.Form["repassword"];

        List<SqlParameter> paramList = new List<SqlParameter>()
        {
            new SqlParameter()
            {
                ParameterName="@GUID",
                Value=Request.QueryString["uid"]
            },
            new SqlParameter()
            {
                ParameterName="@Password",
                Value=Password
            }
        };

        return ExecuteStoreProcedure("sp_passwordreset", paramList);
    }

    private bool IsPasswordLinkValid()
    {
        List<SqlParameter> paramList = new List<SqlParameter>()
        {
            new SqlParameter()
            {
                ParameterName="@GUID",
                Value=Request.QueryString["uid"]
            }
        };

        return ExecuteStoreProcedure("sp_IsPasswordLinkValid", paramList);
    }

    protected void Save_Click(object sender, EventArgs e)
    {
        if (UserPasswordReset())
        {
            linknotvalid.Visible = false;
            passwordreset.Visible = true;
        }
        else
        {
            linknotvalid.Visible = true;
            passwordreset.Visible = false;
        }
    }
}