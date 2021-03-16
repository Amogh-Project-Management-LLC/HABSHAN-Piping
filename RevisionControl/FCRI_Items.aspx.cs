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
using dsIsomeControlBTableAdapters;

public partial class RevisionControl_FCRI_Items : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            scIdField.Value = WebTools.GetExpr("SUB_CON_ID", "PIP_FCRI", "FCRI_ID=" + Request.QueryString["FCRI_ID"]);
            string rel_no = WebTools.GetExpr("FCRI_NO", "PIP_FCRI", "FCRI_ID=" + Request.QueryString["FCRI_ID"]);
            Master.HeadingMessage = "Spools <br/>" + rel_no;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("FCRI.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row to delete!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete selected row?");
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
        if (!EntryTable.Visible)
        {
            EntryTable.Visible = true;
            btnAddSpool.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnAddSpool.Visible = false;
        }
    }
    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        decimal spl_id = decimal.Parse(cboNewSpool.SelectedValue.ToString());
        VIEW_FCRI_DETAILTableAdapter rel_spl = new VIEW_FCRI_DETAILTableAdapter();
        try
        {
            rel_spl.InsertQuery(
                decimal.Parse(Request.QueryString["FCRI_ID"]),
                spl_id, txtRevNo.Text, txtSCR.Text, txtFCR.Text, txtStatus.Text,
                txtRemarks.Text);
            itemsGridView.DataBind();
            Master.ShowMessage(cboNewSpool.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            rel_spl.Dispose();
        }
    }
}