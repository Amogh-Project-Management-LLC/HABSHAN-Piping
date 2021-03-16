using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Erection_SiteMIVR_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_SITE_MIV", " WHERE ISSUE_ID=" +
               Request.QueryString["ID"]);
            //string wo = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_LOOSE", " WHERE JC_ID=" + Request.QueryString["ID"]);
            Master.HeadingMessage("Create MIV Revision (" + miv_no + ")");

            //Master.HeadingMessage("ID: " + Request.QueryString["ID"]);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string mivr_no = WebTools.GetExpr("MIVR_NO", "PIP_SITE_MIV_REV", " WHERE ISSUE_ID=" + int.Parse(Request.QueryString["ID"]) + " AND UPPER(MIVR_NO)='" + (txtMIVR.Text.Trim()).ToUpper() + "'");
            if (mivr_no != string.Empty)
            {
                Master.show_error("Already same MIVR Number is used in same SITE MIV issuance, Request New MIVR No. or  MIVR No. with revision");
                return;
            }
            dsErectionBTableAdapters.VIEW_SITE_MIV_REVTableAdapter rev = new dsErectionBTableAdapters.VIEW_SITE_MIV_REVTableAdapter();
            int issue_id = int.Parse(Request.QueryString["id"]);
            string user_id = WebTools.GetExpr("USER_ID", "USERS", "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            rev.InsertQuery(issue_id, int.Parse(txtMIVRev.Text), txtMIVR.Text, System.DateTime.Now, int.Parse(user_id), txtRemarks.Text);
            Master.show_success("SITE MIV Revision Created!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }

    }
}