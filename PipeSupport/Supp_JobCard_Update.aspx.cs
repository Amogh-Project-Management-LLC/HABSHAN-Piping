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

public partial class Supp_JobCard_Update : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_DELETE"))
            {
                Master.ShowWarn("Access Denied!");
                btnUpdate.Enabled = false;
            }
            Master.HeadingMessage = "Support Job Crad Update";
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string result2;

        result2 = WebTools.GetExpr(
            "FNC_INSERT_SUPP_BOM_JC(" + Request.QueryString["JC_ID"] + ")", "DUAL", "");

        Response.Redirect("Supp_JobCard.aspx");
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Supp_JobCard.aspx?Filter=" + Request.QueryString["Filter"]);
    }
}