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

public partial class TestPkg_PunchStatusReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Test Package Status";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Home.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        string CLEAR_FLAG = "X";
        switch (ReportList.SelectedValue.ToString())
        {
            case "18":
                CLEAR_FLAG = "Y";
                break;
            case "19":
                CLEAR_FLAG = "N";
                break;
            default:
                CLEAR_FLAG = "X";
                break;
        }

        Response.Redirect("ReportViewer.aspx?ReportID=" + ReportList.SelectedValue.ToString() +
            "&SYS_NUMBER=" + SystemNoList.SelectedValue.ToString() +
            "&ORIGIN_ID=" + OriginatorList.SelectedValue.ToString() +
            "&CLEAR_FLAG=" + CLEAR_FLAG
            );
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
    protected void OriginatorList_DataBinding(object sender, EventArgs e)
    {
        OriginatorList.Items.Clear();
        OriginatorList.Items.Add(new ListItem("ANY", "-1"));
        OriginatorList.Items[0].Selected = true;
    }
    protected void OriginatorList_DataBound(object sender, EventArgs e)
    {
        //if (OriginatorList.Items.Count > 0)
        //{
        //    OriginatorList.SelectedIndex = 0;
        //}
    }
}