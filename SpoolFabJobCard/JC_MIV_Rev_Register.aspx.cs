using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsFabricationJCTableAdapters;

public partial class SpoolFabJobCard_JC_MIV_Rev_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +Request.QueryString["ISSUE_ID"]);
            Master.HeadingMessage("MIV - Revision "+miv_no);
            string rev_no = WebTools.GetExpr("REV_NO", "PIP_MAT_ISSUE_WO_REV", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            if(rev_no==string.Empty)
            {
                txtMIVRev.Text = "0";
            }
            else
            {
                txtMIVRev.Text =int.Parse(rev_no)+1+"";
            }

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string mivr_no = WebTools.GetExpr("MIVR_NO", "PIP_MAT_ISSUE_WO_REV", " WHERE ISSUE_ID=" + int.Parse(Request.QueryString["ISSUE_ID"])+" AND UPPER(MIVR_NO)='"+(txtMIVR.Text.Trim()).ToUpper()+"'");
            if(mivr_no!=string.Empty)
            {
                Master.show_error("Already Same MIVR No. is used in Same JC MIV Issuance, Request New MIVR No. or  MIVR No. with revision");
                return;
            }
            PIP_MAT_ISSUE_WO_REVTableAdapter wo_rev = new PIP_MAT_ISSUE_WO_REVTableAdapter();
            int issue_id = int.Parse(Request.QueryString["ISSUE_ID"]);
            string user_id = WebTools.GetExpr("USER_ID", "USERS", "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            wo_rev.InsertQuery(issue_id, int.Parse(txtMIVRev.Text), txtMIVR.Text, System.DateTime.Now, int.Parse(user_id), txtRemarks.Text);
            Master.show_success("JC MIV Revision Created!");
        }
        catch(Exception ex)
        {
            Master.show_error(ex.Message);
        }

    }
}