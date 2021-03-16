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
using dsGalvJobcardTableAdapters;

public partial class SpoolMove_GalvJobcardItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string jc_no = WebTools.GetExpr("GALV_JC_NO", "PIP_GALV_JC", "JC_ID=" + Request.QueryString["JC_ID"]);
            Master.HeadingMessage = "Spools for (" + jc_no + ")";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("GalvJobcard.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the row to delete!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        txtIsome.Visible = true;
        cboNewSpool.Visible = true;
        btnAddSpool.Visible = true;
    }
    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        VIEW_GALV_JC_SPLTableAdapter spools = new VIEW_GALV_JC_SPLTableAdapter();
        try
        {
            spools.InsertQuery(
                decimal.Parse(Request.QueryString["JC_ID"]),
                decimal.Parse(cboNewSpool.SelectedValue.ToString()),
                String.Empty);
            itemsGridView.DataBind();
            Master.ShowMessage("Spool Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            spools.Dispose();
        }
    }
}