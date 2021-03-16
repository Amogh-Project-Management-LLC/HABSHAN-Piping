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
using dsMaterialBTableAdapters;
public partial class Erection_Additional_MatItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Transfer (" +
                WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID=" + Request.QueryString["TRANSF_ID"]) + ")";
            LoadEntryData();
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
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Mat_Transf.aspx");
    }
    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {

    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access denied!");
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
        if (cboMatList.Items.Count == 0)
            return;
        decimal mat_id = db_lookup.MAT_ID(cboMatList.SelectedItem.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }

        /*
         1. Stock Quantity Check
         2. Transfer qty cannot be more than required qty
         3. Pipe Piece no validation.
         */

        string store_id = WebTools.GetExpr("A_STORE_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_ID='" + Request.QueryString["TRANSF_ID"].ToString() + "'");
        string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID='" + store_id + "'");

        string stock_qty = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID = '" + cboMatList.SelectedValue + "' AND SUB_CON_ID='" + sc_id + "'");
        string cat_id = WebTools.GetExpr("CAT_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_ID = '" + Request.QueryString["TRANSF_ID"] + "'");

        if (string.IsNullOrEmpty(stock_qty) && cat_id != "2")
        {
            Master.ShowError("Issue quantity cannot exceed available stock quantity. Current Stock Quantity is 0.");
            return;
        }

        if ((decimal.Parse(stock_qty) < decimal.Parse(txtQty.Text)) && cat_id != "2")
        {
            Master.ShowError("Issue quantity cannot exceed available stock quantity. Current Stock Quantity is " + stock_qty + ".");
            return;
        }

        if (cat_id != "2")
        {
            if (decimal.Parse(txtReqQty.Text) < decimal.Parse(txtQty.Text))
            {
                Master.ShowError("Issue quantity cannot exceed required quantity.");
                return;
            }
        }

        if (txtPipePiece.Visible)
        {
            if (string.IsNullOrEmpty(txtPipePiece.Text))
                txtPipePiece.Text = "1";
            double min = 0, max = 0;
            bool flag = PipePieceQty(out min, out max);

            //if (!flag)
            //{
            //    Master.ShowError("Pipe piece quantity can be between " + min + " and " + max);
            //    return;
            //}
        }

        //-------------------------------------------------------------------
        PIP_MAT_TRANSF_DETAILTableAdapter items = new PIP_MAT_TRANSF_DETAILTableAdapter();
        try
        {
            items.InsertQuery(
                Decimal.Parse(Request.QueryString["TRANSF_ID"]),
                mat_id, txtAutoHeatNo.SelectedItem.Text,
                Decimal.Parse(txtQty.Text),
                txtBoxNo.Text,
                txtPipePiece.Visible ? decimal.Parse(txtPipePiece.Text) : 1,
                decimal.Parse("0"),
                txtRemarks.Text,
                ddlPaintSystem.SelectedItem.Text
                );

            itemsGridView.DataBind();
            lblFormMessage.Text = cboMatList.SelectedItem.Text + " Added!";
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

    protected void LoadEntryData()
    {
        string cat_id = WebTools.GetExpr("CAT_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);
        string doc_no = WebTools.GetExpr("DOC_REF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);
        string sql = string.Empty;
        string id = string.Empty;
        switch (cat_id)
        {
            case "1":
                id = WebTools.GetExpr("MAT_REQ_ID", "MATERIAL_REQUEST", " WHERE MAT_REQ_NO = '" + doc_no + "'");
                sql = "SELECT MAT_ID, MAT_CODE1 FROM VIEW_MAT_TRANSFER_BAL WHERE MAT_REQ_ID = '" + id + "' AND BAL_TO_TRANS > 0";
                break;
            case "3":
                id = WebTools.GetExpr("ISSUE_ID", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_NO = '" + doc_no + "'");
                sql = "SELECT MAT_ID, MAT_CODE1 FROM VIEW_MAT_TRANSFER_BAL_MIV WHERE ISSUE_ID = '" + id + "' AND BAL_TO_TRANS > 0";
                break;
            default:
                sql = "SELECT MAT_ID, MAT_CODE1 FROM VIEW_STOCK WHERE PROJECT_ID = " + Session["PROJECT_ID"].ToString() + "" +
                    " AND MAT_ID IN (SELECT MAT_ID FROM PIP_BULK_PAINT_ISSUE_DETAIL)";
                break;
        }

        sqlMatSource.SelectCommand = sql;

        cboMatList.DataBind();
    }

    protected void cboMatList_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string cat_id = WebTools.GetExpr("CAT_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);
        string sql = string.Empty;

        sql = "SELECT DISTINCT HEAT_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID = '" + cboMatList.SelectedValue + "'";
        sqlHeatNo.SelectCommand = sql;
        txtAutoHeatNo.DataBind();

        if (cat_id == "3")
        {
            sql = "SELECT DISTINCT PAINT_CODE AS PS FROM PIP_BULK_PAINT_ISSUE_DETAIL WHERE MAT_ID = '" + cboMatList.SelectedValue + "'"; ;
        }
        else
        {
            sql = "SELECT DISTINCT PS FROM PIP_SPOOL WHERE SPL_ID IN (SELECT DISTINCT SPL_ID FROM PIP_BOM WHERE MAT_ID = '" + cboMatList.SelectedValue + "')";
        }

        sqlPaintSystem.SelectCommand = sql;
        ddlPaintSystem.DataBind();

        string item_nam = WebTools.GetExpr("ITEM_NAM", "VIEW_STOCK", " WHERE MAT_ID='" + cboMatList.SelectedValue + "'");

        if (item_nam.ToUpper().Contains("PIPE"))
            txtPipePiece.Visible = true;
        else
        {
            txtPipePiece.Visible = false;
            txtPipePiece.Text = "";
        }

        //Required Qty
        string doc_no = WebTools.GetExpr("DOC_REF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID = " + Request.QueryString["TRANSF_ID"]);
        if (cat_id == "3")
        {
            txtReqQty.Text = WebTools.GetExpr("BAL_TO_TRANS", "VIEW_MAT_TRANSFER_BAL_MIV", " WHERE ISSUE_NO='" + doc_no + "' AND MAT_ID='" + cboMatList.SelectedValue + "'");
        }
        else if (cat_id == "1")
        {
            txtReqQty.Text = WebTools.GetExpr("BAL_TO_TRANS", "VIEW_MAT_TRANSFER_BAL", " WHERE MAT_REQ_NO='" + doc_no + "' AND MAT_ID='" + cboMatList.SelectedValue + "'");
        }

        txtAutoHeatNo.ClearSelection();
        txtAutoHeatNo.Text = "";
    }

    protected Boolean PipePieceQty(out double min, out double max)
    {
        string matcode = cboMatList.SelectedItem.Text;
        string min_qty = WebTools.DMinText("PIPE_LENGTH", "VIEW_PO_VENDOR_DATA", " WHERE MAT_CODE1='" + matcode + "'");
        string max_qty = WebTools.DMaxText("PIPE_LENGTH", "VIEW_PO_VENDOR_DATA", " WHERE MAT_CODE1='" + matcode + "'");

        if (string.IsNullOrEmpty(min_qty))
        {
            min = 1; max = 1;
            return true;
        }
        //double min, max;
        min = Math.Ceiling(Convert.ToDouble(txtQty.Text) / Convert.ToDouble(max_qty));
        max = Math.Floor(Convert.ToDouble(txtQty.Text) / Convert.ToDouble(min_qty));

        if (Convert.ToDouble(txtPipePiece.Text) > max || Convert.ToDouble(txtPipePiece.Text) < min)
        {
            return false;
        }

        return true;
    }

    protected void ddlPaintSystem_DataBinding(object sender, EventArgs e)
    {
        ddlPaintSystem.Items.Clear();
        ddlPaintSystem.Items.Add(new Telerik.Web.UI.DropDownListItem("XXX", ""));
    }
}
