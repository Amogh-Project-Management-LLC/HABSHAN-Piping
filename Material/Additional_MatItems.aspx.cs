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
using dsMaterial_IssueATableAdapters;

public partial class Erection_Additional_MatItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Additional Materials <br/>" +
                WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID=" + Request.QueryString["ADD_ISSUE_ID"]);
        }
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Additional_Mat.aspx");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the material to delete!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected spool?");
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            //Master.ShowMessage("Material deleted.");
            //itemsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        
        if (!EntryTable.Visible)
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatSearch.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));

        if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }

        //decimal bal_qty = db_lookup.DSum("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID=" + mat_id + " AND SUB_CON_ID=" + Request.QueryString["SC_ID"]);
        //if (bal_qty < decimal.Parse(txtQty.Text) && Request.QueryString["SC_ID"] != "2")
        //{
        //    Master.ShowWarn("Material not found in stock!, Please check the quantity carefully.");
        //    return;
        //}
        string sc_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + Request.QueryString["ADD_ISSUE_ID"].ToString() + "'");
        string stock_qty = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID= '" + HiddenMatID.Value + "' AND SUB_CON_ID='" + sc_id + "'");

        if (stock_qty == null || decimal.Parse(stock_qty) < decimal.Parse(txtQty.Text))
        {
            Master.ShowError("Issue quantity is more than current available stock qty. Current stock quantity is " + stock_qty + ".");
            return;
        }

        string HeatNo, PaintSys;
        PIP_MAT_ISSUE_ADD_DETAILTableAdapter items = new PIP_MAT_ISSUE_ADD_DETAILTableAdapter();
        try
        {
            HeatNo = txtAutoHeatNo.Entries[0].Text;
            if (txtAutoPaintSys.Entries.Count > 0)
                PaintSys = txtAutoPaintSys.Entries[0].Text;
            else
                PaintSys = string.Empty;

            items.InsertQuery(
                Decimal.Parse(Request.QueryString["ADD_ISSUE_ID"]),
                mat_id,
                decimal.Parse(txtQty.Text),
                HeatNo,
                PaintSys,
                txtRemarks.Text);
            Master.ShowMessage(txtMatSearch.Text + " Saved.");
            itemsGridView.Rebind();
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

    protected void txtMatSearch_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        HiddenMatID.Value = db_lookup.MAT_ID(txtMatSearch.Text, Decimal.Parse(Session["PROJECT_ID"].ToString())).ToString();
    }
}