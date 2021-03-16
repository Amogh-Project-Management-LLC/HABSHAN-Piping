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

using dsGeneralATableAdapters;
using System.Text.RegularExpressions;
using VB_Functions;
using System.Data.OracleClient;

public partial class Admin_Page : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (!WebTools.UserInRole("ADMIN"))
            //{
            //    Response.Redirect("~/ErrorPages/NoAccess.htm");
            //    return;
            //}
            Master.HeadingMessage = "Bulk Import";
            //lblMsg1.Text = "<b>Total users logged in: <b>" + Application["userCount"].ToString();
        }
    }


  protected void btnImportJC_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=31&RetUrl=~/Admin/AdminPage.aspx");
    }

    protected void btnImportWeld_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=30&RetUrl=~/Admin/AdminPage.aspx");
    }

    protected void btnImportNDT_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=32&RetUrl=~/Admin/AdminPage.aspx");
    }
}