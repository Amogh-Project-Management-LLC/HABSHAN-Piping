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
using dsCuttingPlanATableAdapters;

public partial class Material_CuttingPlanAlloc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //WO_IDHiddenField.Value =
            //    WebTools.GetExpr("WO_ID", "PIP_MAT_ISSUE_WO", "ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            string pc_no =
                WebTools.GetExpr("PIECE_NO || '(' || MAT_CODE1 || ')'",
                "VIEW_WORK_ORD_CUTLEN", "PIECE_ID=" + Request.QueryString["PIECE_ID"]);
            Master.HeadingMessage = "Allocation <br/>" + pc_no;
            matIdField.Value = WebTools.GetExpr("MAT_ID", "PIP_WORK_ORD_CUTLEN", "PIECE_ID=" + Request.QueryString["PIECE_ID"]);
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
    protected void btnAddMat_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!EntryDiv.Visible)
        {
            EntryDiv.Visible = true;
            btnSave.Visible = true;
        }
        else
        {
            EntryDiv.Visible = false;
            btnSave.Visible = false;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the material.");
            return;
        }
        Master.ShowWarn("Proceed deletd material?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            Master.ShowMessage("Material deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("CuttingPlanMaster.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_WORK_ORD_CUTLEN_DETAILTableAdapter cp = new VIEW_WORK_ORD_CUTLEN_DETAILTableAdapter();
        try
        {
            cp.InsertQuery(
                decimal.Parse(Request.QueryString["PIECE_ID"]),
                decimal.Parse(cboBOM.SelectedValue.ToString()),
                decimal.Parse(txtBOMQty.Text),
                decimal.Parse(txtCalcQty.Text),
                decimal.Parse(txtCuttingAlw.Text)
                );
            itemsGridView.DataBind();
            Master.ShowMessage(cboBOM.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            cp.Dispose();
        }
    }
    
    protected void cboBOM_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            if (cboBOM.SelectedValue.ToString() == "")
                return;
            txtBOMQty.Text = WebTools.GetExpr("NET_QTY", "VIEW_ADAPTER_BOM", "BOM_ID=" + cboBOM.SelectedValue.ToString());
        }
    }
}
