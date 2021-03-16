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
using dsSpoolMoveTableAdapters;

public partial class SpoolMove_SpoolTransSpools : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string trans_no = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS", " WHERE TRANS_ID=" +
                Request.QueryString["TRANS_ID"]);
            scIdField.Value = WebTools.GetExpr("SC_ID", "PIP_SPOOL_TRANS", " WHERE TRANS_ID=" +
                Request.QueryString["TRANS_ID"]);
            Master.HeadingMessage = "Spools for (" + trans_no + ")";
        }
    }

    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            Telerik.Web.UI.DropDownListItem pageListItem =
                new Telerik.Web.UI.DropDownListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolTrans.aspx?CAT_ID=" + Request.QueryString["CAT_ID"]);
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        Decimal trans_id = decimal.Parse(Request.QueryString["TRANS_ID"]);
        VIEW_ADAPTER_SPL_TRANS_DETAILTableAdapter spools = new VIEW_ADAPTER_SPL_TRANS_DETAILTableAdapter();

        //Check Painting Report
        string paint_cmplt = WebTools.GetExpr("PAINT_CLR", "PIP_SPOOL", " WHERE SPL_ID = '" + cboNewSpool.SelectedValue + "'");
        string paint_required = WebTools.GetExpr("PAINT_REQUIRED", "PIP_SPOOL", " WHERE SPL_ID = '" + cboNewSpool.SelectedValue + "'");

        if (paint_required == "Y")
        {
            if (string.IsNullOrEmpty(paint_cmplt.Trim()) && (Request.QueryString["CAT_ID"] == "8" || Request.QueryString["CAT_ID"] == "16"))
            {
                Master.ShowError("Spool cannot be added. Painting not completed");
                return;
            }
        }
       
        try
        {
            spools.InsertQuery(trans_id, Decimal.Parse(cboNewSpool.SelectedValue),
                decimal.Parse(Request.QueryString["CAT_ID"]));
            itemsGridView.DataBind();
            Master.ShowMessage("Spool added.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            spools.Dispose();
        }
        cboNewSpool.DataBind();
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("SPL_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        txtIsome.Visible = true;
        cboNewSpool.Visible = true;
        btnAddSpool.Visible = true;
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        //txtIsome.Text = txtIsome.Text.Trim().ToUpper();
    }

    protected void itemsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("SPOOL_TRANS_DETAIL_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("SPOOL_TRANS_DETAIL_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
}