using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Erection_SiteMIVR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_SITE_MIV", " WHERE ISSUE_ID=" +
               Request.QueryString["id"]);
            string wo = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_LOOSE", " WHERE JC_ID=" + Request.QueryString["ID"]);
            Master.HeadingMessage = "MIV Revision <br/>(" + wo + "/ " + miv_no + ")";

            Master.AddModalPopup("~/Erection/SiteMIVR_New.aspx?ID=" + Request.QueryString["id"], NewRev.ClientID, 450, 550);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnItem_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select row to continue.");
            return;
        }
        Response.Redirect("SiteMIV_Detail.aspx?id=" + Request.QueryString["id"] + "&rev_id="+itemsGrid.SelectedValue);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SiteMIV.aspx");
    }
}