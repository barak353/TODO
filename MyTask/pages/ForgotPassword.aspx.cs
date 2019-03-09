using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Text;

public partial class pages_ForgotPassword : System.Web.UI.Page
{
    String conString = ConfigurationManager.ConnectionStrings["sqlapp"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Submit_Click(object sender, EventArgs e)
    {
      
        //Taking values ​​written as input from the user
        String UserName = Request.Form["Username"];
        
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("spPasswordRecovery", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter paramemail = new SqlParameter("@UserName", UserName);
            cmd.Parameters.Add(paramemail);

            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                if (Convert.ToBoolean(rdr["ReturnCode"]))
                {
                    PasswordResetEmail(rdr["Email"].ToString(), UserName, rdr["UniqueId"].ToString());
                    email.Visible = false;
                    emailnotfound.Visible = true;
                }
                else
                {
                    email.Visible = true;
                    emailnotfound.Visible = false;
                }
            }
        }

    }

    private void PasswordResetEmail(string ToEmail, string UserName, string UniqueId)
    {
        MailMessage mailMessage = new MailMessage("taskmanagerautosending@gmail.com", ToEmail);

        StringBuilder sbEmailBody = new StringBuilder();
        sbEmailBody.Append("Dear " + UserName + "<br/<br/>");
        sbEmailBody.Append("Please click on the following link to reset your password");
        sbEmailBody.Append("<br/>");
        sbEmailBody.Append("http://localhost:50229/pages/ResetPassword?uid=" + UniqueId);
        sbEmailBody.Append("<br/><br/>");
        sbEmailBody.Append("<b>Task Management </b>");

        mailMessage.IsBodyHtml = true;

        mailMessage.Body = sbEmailBody.ToString();
        mailMessage.Subject = "Reset Password";
        SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);

        smtpClient.Credentials = new System.Net.NetworkCredential()
        {
            UserName = "taskmanagerautosending@gmail.com",
            Password = "1234ABC!"
        };

        smtpClient.EnableSsl = true;
        smtpClient.Send(mailMessage);
    }
}