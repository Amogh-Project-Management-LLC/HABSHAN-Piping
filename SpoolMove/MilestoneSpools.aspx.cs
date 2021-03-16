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

public partial class SpoolMove_MilestoneSpools : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string status_code = WebTools.GetExpr("STATUS_CODE || '/ ' || STATUS", "PIP_SPOOL_MILESTONE", " WHERE STATUS_ID=" +
            Request.QueryString["STATUS_ID"]);
        Master.HeadingMessage = "Spool list for (" + status_code + ")";
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Milestone.aspx");
    }
    protected void spoolGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string spool_desc = WebTools.GetExpr("FNC_GET_JC_REM(" + spoolGridView.SelectedValue.ToString() +
                ")", "DUAL", "");
            Master.ShowMessage(spool_desc);
        }
        catch
        {
            //TO-DO: Write code here.
            //No handling for this error required!
        }
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        db_export.ExportDataSetToExcel(spoolDataSource, "SpoolMilestone.xls");
    }
}
