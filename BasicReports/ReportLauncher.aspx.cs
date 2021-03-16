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
using System.IO;
using System.Text;
using dsMainTablesATableAdapters;
using Telerik.Web.UI;

public partial class Isome_IsomeIndex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Report Filter";
        }
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        string asp_url = "ReportViewer_B.aspx?ReportID=" + Request.QueryString["ReportID"] + "&Arg1=" + ddMainMat.SelectedValue.ToString() + "";
        Response.Redirect(asp_url);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
}