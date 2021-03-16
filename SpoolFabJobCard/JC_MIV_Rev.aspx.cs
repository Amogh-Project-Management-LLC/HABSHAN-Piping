using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolFabJobCard_JC_MIV_Rev_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
               Request.QueryString["ISSUE_ID"]);
            string wo = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);
            Master.HeadingMessage = "MIV Revision (" + wo + "/ " + miv_no + ")";

            Master.AddModalPopup("~/SpoolFabJobCard/JC_MIV_Rev_Register.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]+"&WO_ID=" + Request.QueryString["WO_ID"], btnRev.ClientID, 450, 550);
            Master.RadGridList = MIVRevGrid.ClientID;
        }

    }

    protected void btnRev_Click(object sender, EventArgs e)
    {

    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (MIVRevGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV Rev number!");
            return;
        }
        Response.Redirect("JC_MIV_Mats.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"] + "&WO_ID=" + Request.QueryString["WO_ID"] + "&ISSUE_REV_ID=" + MIVRevGrid.SelectedValue.ToString());
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV.aspx");
    }

    protected void ddlReportType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

        if (MIVRevGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV Rev number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=16.1&Arg1="+Request.QueryString["ISSUE_ID"] +"&Arg2=" + MIVRevGrid.SelectedValue.ToString());
     
    }
}