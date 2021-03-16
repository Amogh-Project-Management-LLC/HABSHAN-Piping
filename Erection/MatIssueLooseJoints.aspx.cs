using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsErectionTableAdapters;

public partial class Erection_MatIssueLooseJoints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string issue_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_LOOSE", "JC_ID=" + Request.QueryString["JC_ID"]);
            Master.HeadingMessage = "SITE JOB CARD - JOINT LIST";
            Master.HeadingMessage += "<br/>" + issue_no;
        }
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            VIEW_MAT_ISSUE_LOOSE_JOINTTableAdapter joint = new VIEW_MAT_ISSUE_LOOSE_JOINTTableAdapter();
            foreach (RadComboBoxItem item in ddlJointList.Items)
            {
                if (item.Checked)
                {
                    joint.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"].ToString()), decimal.Parse(item.Value), null);
                }
            }
            itemsGridView.Rebind();
            Master.ShowMessage("Item Added.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatIssueLoose.aspx");
    }
}