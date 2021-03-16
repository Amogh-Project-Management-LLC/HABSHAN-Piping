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
using dsCoolBendingTableAdapters;

public partial class ColdBending_ColdBendingItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string issue_no = WebTools.GetExpr("JC_NO", "COOL_BENDING_JC", "JC_ID=" + Request.QueryString["JC_ID"]);
            Master.HeadingMessage = "Paint Cold Bending <br/>" + issue_no;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ColdBending.aspx?Filter=" + Request.QueryString["Filter]"]);
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
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_COOL_BENDING_JC_DTTableAdapter items = new VIEW_COOL_BENDING_JC_DTTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"]),
                decimal.Parse(cboBOM.SelectedValue.ToString()),
                decimal.Parse(txtIssuedQty.Text),
                string.Empty);
            itemsGridView.DataBind();
            Master.ShowMessage("Saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }
    protected void cboMM_SELECTedIndexChanged(object sender, EventArgs e)
    {
        if (cboBOM.SelectedValue.ToString() != "-1")
        {
            string net_qty = WebTools.GetExpr("NET_QTY", "PIP_BOM", " WHERE BOM_ID=" +
                cboBOM.SelectedValue.ToString());
            txtIssuedQty.Text = net_qty;
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (EntryTable.Visible == false)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
    protected void ddSheetNo_DataBinding(object sender, EventArgs e)
    {
        ddSheetNo.Items.Clear();
        ddSheetNo.Items.Add(new ListItem("ALL", "ALL"));
    }
}