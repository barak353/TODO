using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class pages_Alltaskpage : System.Web.UI.Page
{
    String conString = ConfigurationManager.ConnectionStrings["sqlapp"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Default.aspx");
            }

            GetData();
        }
    }

    protected void AddTask_Click(object sender, EventArgs e)
    {
        Response.Redirect("Addtask.aspx");
    }
    private void GetData()
    {
        using (SqlConnection con=new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Select * from tbltaskdata where username='"+ Session["username"] + "'",con);
            con.Open();
            GridViewTasks.DataSource = cmd.ExecuteReader();
            GridViewTasks.DataBind();
        }
    }

    private void DeleteTask(int id)
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Delete from tbltaskdata where Id='" + id + "'", con);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

     
    protected void GridViewTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName== "Delete")
        {
            DeleteTask(Convert.ToInt32(e.CommandArgument));
            GetData();
        }
        if (e.CommandName=="Edit")
        {
            Session["EditId"] = e.CommandArgument.ToString();
            Response.Redirect("Edittask.aspx");
        }
    }

   
    protected void GridViewTasks_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void GridViewTasks_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedIndex==0)
        {
            GetData();
        }
        else
        {
            GetCategoryData();
        }
    }

    private void GetCategoryData()
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Select * from tbltaskdata where Category='" + DropDownList1.SelectedValue + "' AND username='" + Session["username"] + "' ", con);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridViewTasks.DataSource = dt;
            GridViewTasks.DataBind();
            

        }
    }
    private void GetPriorityData()
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            SqlCommand cmd = new SqlCommand("Select * from tbltaskdata where Priority='" + DropDownList2.SelectedValue + "' AND username='" + Session["username"] + "' ", con);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridViewTasks.DataSource = dt;
            GridViewTasks.DataBind();


        }
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList2.SelectedIndex == 0)
        {
            GetData();
        }
        else
        {
            GetPriorityData();
        }
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }
}