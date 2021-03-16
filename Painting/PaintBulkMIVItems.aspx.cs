using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Painting_PaintBulkMIVItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Bulk Material Painting (MIV)";
            Master.HeadingMessage += "</br>";
            Master.HeadingMessage += WebTools.GetExpr("ISSUE_NO", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_ID = '" + Request.QueryString["ISSUE_ID"].ToString() + "'");

            HiddenPaintID.Value = WebTools.GetExpr("PAINT_JC_ID", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_ID = '" + Request.QueryString["ISSUE_ID"].ToString() + "'");
            HiddenSCID.Value = WebTools.GetExpr("STORE_ID", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_ID = '" + Request.QueryString["ISSUE_ID"].ToString() + "'");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaintBulkMIV.aspx");
    }

    protected void txtAutoMatCode_EntryAdded(object sender, Telerik.Web.UI.AutoCompleteEntryEventArgs e)
    {

    }

    protected void txtAutoMatCode_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        HiddenMatID.Value = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + txtAutoMatCode.Entries[0].Text + "'");
        txtReqQty.Text = WebTools.GetExpr("BAL_ISSUE", "VIEW_BULK_PAINT_ISSUE_BAL", " WHERE PAINT_ID='" + HiddenPaintID.Value + "' AND MAT_ID = '" + HiddenMatID.Value + "'");

        string item_nam = WebTools.GetExpr("ITEM_NAM", "VIEW_STOCK", " WHERE MAT_ID = '" + HiddenMatID.Value + "'");
        if (item_nam.ToUpper() == "PIPE" || item_nam.ToUpper() == "PIPES")
            txtPipePiece.Enabled = true;
        else
            txtPipePiece.Enabled = false;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {     
        try
        {
            txtReqQty.Text = WebTools.GetExpr("BAL_ISSUE", "VIEW_BULK_PAINT_ISSUE_BAL", " WHERE PAINT_ID='" + HiddenPaintID.Value + "' AND MAT_ID = '" + HiddenMatID.Value + "'");
            string item = WebTools.GetExpr("ITEM_NAM", "VIEW_STOCK", " WHERE MAT_ID= '" + HiddenMatID.Value + "'");
            if (decimal.Parse(txtIssueQty.Text) > decimal.Parse(txtReqQty.Text) && !item.ToUpper().Contains("PIPE"))
            {
                Master.ShowError("Issue qty cannot exceed required qty.");
                return;
            }
            if (string.IsNullOrEmpty(txtIssueQty.Text) || decimal.Parse(txtIssueQty.Text) == 0)
            {
                Master.ShowError("Issue Qty cannot be blank or Zero.");
            }
            //Stock Qty to check.
            if (txtPipePiece.Enabled)
            {
                double min = 0, max = 0;
                bool flag = PipePieceQty(out min, out max);

                if (!flag)
                {
                    Master.ShowError("Pipe piece quantity can be between " + min + " and " + max);
                    return;
                }
            }
            string heat_no, ps;
            heat_no = cboHeatNo.SelectedIndex > 0 ? cboHeatNo.SelectedItem.Text : "";
            ps = cboPaintSystem.SelectedIndex > 0 ? cboPaintSystem.SelectedItem.Text : "";

            dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter issue = new dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter();
            issue.InsertQuery(decimal.Parse(Request.QueryString["ISSUE_ID"]), decimal.Parse(HiddenMatID.Value), decimal.Parse(txtIssueQty.Text),
                heat_no, txtRemarks.Text, ps);
            Master.ShowMessage("Item Added.");
            itemsGrid.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void cboHeatNo_DataBinding(object sender, EventArgs e)
    {
        cboHeatNo.Items.Clear();
        cboHeatNo.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select", ""));
    }

    protected void cboPaintSystem_DataBinding(object sender, EventArgs e)
    {
        cboPaintSystem.Items.Clear();
        cboPaintSystem.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select)", ""));
    }

    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Update")
        {
            try
            {
                GridDataItem row = (GridDataItem)e.Item;
                string mat_code = ((TextBox)row["MAT_CODE1"].Controls[0]).Text;
                string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + mat_code + "'");
                string jc_qty = WebTools.GetExpr("JC_QTY", "VIEW_BULK_PAINT_ISSUE_BAL", " WHERE PAINT_ID='" + HiddenPaintID.Value + "' AND MAT_ID = '" + mat_id + "'");
                string issue_qty = ((TextBox)(row["ISSUE_QTY"].Controls[0])).Text;
                if (decimal.Parse(jc_qty) < decimal.Parse(issue_qty))
                {
                    Master.ShowWarn("Issued qty cannot exceed required qty.");
                    return;
                }

                string heat_no = ((TextBox)(row["HEAT_NO"].Controls[0])).Text;
                string remarks = ((TextBox)(row["REMARKS"].Controls[0])).Text;
                string paint_code = ((TextBox)(row["PAINT_CODE"].Controls[0])).Text;

                dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter miv = new dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter();
                miv.UpdateQuery(decimal.Parse(issue_qty), heat_no, remarks, paint_code, decimal.Parse(row.GetDataKeyValue("ISSUE_ITEM_ID").ToString()));

                Master.ShowSuccess("Item Updated.");
            }
            catch (Exception ex)
            {
                Master.ShowError(ex.Message);
            }
        }
    }

    protected void ddlSubStore_DataBinding(object sender, EventArgs e)
    {
        ddlSubStore.Items.Clear();
        ddlSubStore.Items.Add(new DropDownListItem("(Select)", ""));
    }

    protected Boolean PipePieceQty(out double min, out double max)
    {
        string matcode = txtAutoMatCode.Entries[0].Text;
        string min_qty = WebTools.DMinText("PIPE_LENGTH", "VIEW_PO_VENDOR_DATA", " WHERE MAT_CODE1='" + matcode + "'");
        string max_qty = WebTools.DMaxText("PIPE_LENGTH", "VIEW_PO_VENDOR_DATA", " WHERE MAT_CODE1='" + matcode + "'");

        if (string.IsNullOrEmpty(min_qty) || string.IsNullOrEmpty(max_qty))
        {
            min = 0;
            max = 1000;
            return true;
        }

        //double min, max;
        min = Math.Ceiling(Convert.ToDouble(txtIssueQty.Text) / Convert.ToDouble(max_qty));
        max = Math.Floor(Convert.ToDouble(txtIssueQty.Text) / Convert.ToDouble(min_qty));

        

        if (Convert.ToDouble(txtPipePiece.Text) > max || Convert.ToDouble(txtPipePiece.Text) < min)
        {
            return false;
        }

        return true;        
    }
}