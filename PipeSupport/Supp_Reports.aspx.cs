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

public partial class PipeSupport_Supp_Reports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Support Reports";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }
    private void show_rep(string rep_id)
    {
        Response.Redirect("Supp_ReportViewer.aspx?ReportID=" + rep_id +
            "&Arg1=" + ddArea.SelectedValue.ToString() +
            "&Arg2=" + (txtIso.Text == string.Empty ? "XXX" : txtIso.Text) +
            "&Arg3=" + (txtSupTag.Text == string.Empty ? "XXX" : txtSupTag.Text));
    }

    protected void btnSuppInst_Click(object sender, EventArgs e)
    {
        show_rep("6");
    }
}