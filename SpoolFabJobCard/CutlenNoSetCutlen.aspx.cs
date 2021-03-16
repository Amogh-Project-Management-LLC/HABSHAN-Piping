using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class CutlenNoSetCutlen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
                    Request.QueryString["ISSUE_ID"]);

            Master.HeadingMessage = "Not in Cutting-Plan <br/>" + miv_no;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_CutPlan.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }
}
