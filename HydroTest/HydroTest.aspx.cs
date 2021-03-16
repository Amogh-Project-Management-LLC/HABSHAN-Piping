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

public partial class HydroTest_HydroTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Hydro Test";
            Master.AddModalPopup("~/HydroTest/HydroTestNew.aspx", btnNew.ClientID, 450, 550);
            Master.RadGridList = TransGridView.ClientID;
        }
    }
    protected void btnNew_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowMessage("No Access!");
           
            return;
        }
        Response.Redirect("HydroTestNew.aspx");
    }
    protected void btnViewJoints_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count== 0) return;
        Response.Redirect("HydroTestItems.aspx?TEST_ID=" + TransGridView.SelectedValue.ToString());
    }
    protected void TransGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void TransGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < TransGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", TransGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == TransGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TransGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select Job Card");
            return;
        }
        Response.Redirect("HydroTest_Spools.aspx?TEST_ID=" + TransGridView.SelectedValue.ToString());
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select Job Card");
            return;
        }
        Response.Redirect("ReportViewer_HydroJC.aspx?ReportID=1&Arg1=" + TransGridView.SelectedValue.ToString());
    }
}