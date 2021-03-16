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

public partial class TestPkg_AreaSystemCompletion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "System Completion Status Reports";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Home.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportViewer.aspx?ReportID=" + ReportList.SelectedValue.ToString() +
            "&SYS_NUMBER=" + SystemNoList.SelectedValue.ToString());
    }

    protected void SubconList_DataBound(object sender, EventArgs e)
    {
        if (SystemNoList.Items.Count > 0)
        {
            SystemNoList.SelectedIndex = 0;
        }
    }
    protected void SystemNoList_DataBinding(object sender, EventArgs e)
    {
        SystemNoList.Items.Clear();
        SystemNoList.Items.Add(new ListItem("ALL", "XXX"));
        SystemNoList.Items[0].Selected = true;
    }
}