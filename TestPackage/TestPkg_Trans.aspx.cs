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

public partial class TestPkg_Trans : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = WebTools.GetExpr("TRANS_TYPE", "TPK_TRANS_TYPE", " WHERE TYPE_ID=" +
                Request.QueryString["TYPE_ID"]);
            Master.AddModalPopup("~/TestPackage/TestPkg_TransRegister.aspx?TYPE_ID=" + Request.QueryString["TYPE_ID"], btnNewTrans.ClientID, 550, 650);
            Master.RadGridList = TransGridView.ClientID;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {   
        Response.Redirect("TestPkg_TransSelect.aspx");
    }
    protected void TransGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("TPK_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnViewSpools_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the transmittal.");
            return;
        }
        Response.Redirect("TestPkg_TransList.aspx?TYPE_ID=" + Request.QueryString["TYPE_ID"] +
            "&TPK_TRANS_ID=" + TransGridView.SelectedValue.ToString());
    }

    protected void btnNewTrans_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("TestPkg_TransRegister.aspx?TYPE_ID=" + Request.QueryString["TYPE_ID"]);
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
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the transmittal!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the transmittal?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //TransGridView.DeleteRow(TransGridView.SelectedIndex);
            //Master.ShowMessage("Transmittal deleted.");
            //TransGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        string url = string.Format("ReportViewer.aspx?ReportID={0}&Arg1={1}", 10,
                TransGridView.SelectedValue.ToString());
        Response.Redirect(url);
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
    }
}