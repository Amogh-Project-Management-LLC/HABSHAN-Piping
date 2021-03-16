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
using dsTestPkg_BTableAdapters;

public partial class TestPkg_TransList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string trans_no = WebTools.GetExpr("TRANS_NO", "TPK_TRANS", " WHERE TPK_TRANS_ID=" +
                Request.QueryString["TPK_TRANS_ID"]);
            Master.HeadingMessage = "List for (" + trans_no + ")";
        }
    }
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("TPK_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Trans.aspx?TYPE_ID=" + Request.QueryString["TYPE_ID"]);
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_DELETE"))
        {
            Master.ShowWarn("No Access!");
            return;
        }
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire spool!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected spool?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            //Master.ShowMessage("Spool deleted successed!");
            //itemsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        txtFilter.Visible = true;
        cboNewTpk.Visible = true;
        btnAddTpk.Visible = true;
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtFilter.Text = txtFilter.Text.Trim().ToUpper();
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_TransList.aspx?TYPE_ID=" + Request.QueryString["TYPE_ID"] +
            "&TPK_TRANS_ID=" + Request.QueryString["TPK_TRANS_ID"]);
    }
    protected void btnAddTpk_Click(object sender, EventArgs e)
    {
        TPK_TRANS_LISTTableAdapter list = new TPK_TRANS_LISTTableAdapter();
        try
        {
            list.InsertQuery(decimal.Parse(Request.QueryString["TPK_TRANS_ID"]),
                decimal.Parse(cboNewTpk.SelectedValue.ToString()),
                decimal.Parse(Request.QueryString["TYPE_ID"]));
            itemsGridView.DataBind();
            Master.ShowMessage("Test package added to list!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            list.Dispose();
        }
    }
}