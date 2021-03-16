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
using dsErectionTableAdapters;
using Telerik.Web.UI;

public partial class SpoolMove_MatIssueLooseSpool : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnEntryMode.Enabled = false;
            }
            string issue_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_LOOSE", "JC_ID=" + Request.QueryString["JC_ID"]);
            Master.HeadingMessage = "Field Piping Installation JC / Spool List";
            Master.HeadingMessage += "<br/>" + issue_no;
        }
    }

    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        VIEW_SITE_JC_SPLTableAdapter jc_items = new VIEW_SITE_JC_SPLTableAdapter();
        try
        {
            jc_items.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"]),
                decimal.Parse(cboNewSpool.SelectedValue),
                string.Empty, string.Empty, string.Empty);
            ItemsGridView.DataBind();
            Master.ShowMessage("Spool added.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            jc_items.Dispose();
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (ItemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the spool!");
            return;
        }
        Master.ShowWarn("Proceed delete the spool?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //ItemsGridView.DeleteRow(ItemsGridView.SelectedIndex);
            GridDataItem item = (GridDataItem)ItemsGridView.SelectedItems[0];
            //JC_ID,BOM_ID
            string jc_id = item.GetDataKeyValue("JC_ID").ToString();
            string bom_id = item.GetDataKeyValue("SPL_ID").ToString();

            dsErectionTableAdapters.VIEW_SITE_JC_SPLTableAdapter rec = new VIEW_SITE_JC_SPLTableAdapter();
            rec.DeleteQuery(decimal.Parse(jc_id), decimal.Parse(bom_id));
            Master.ShowMessage("Spool deleted");
            ItemsGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void ItemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < ItemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", ItemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == ItemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ItemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void ItemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
       // txtForemanName.Visible = true;
        txtIsome.Visible = true;
        cboNewSpool.Visible = true;
        btnAddSpool.Visible = true;
    }
    protected void btnJCList_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatIssueLoose.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
    }
}