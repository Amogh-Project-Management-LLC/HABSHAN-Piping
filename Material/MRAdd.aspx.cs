using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MRAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Master.HeadingMessage("New Material Requisition");
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
            dsMaterialDTableAdapters.PIP_MAT_REQUISITIONTableAdapter mr = new dsMaterialDTableAdapters.PIP_MAT_REQUISITIONTableAdapter();
            mr.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtMRNo.Text, txtRevision.Text, txtMRTitle.Text, txtDisCode.Text,
                txtStatus.Text, decimal.Parse(user_id), txtRemarks.Text);
            Master.show_success(txtMRNo.Text + " Added Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}