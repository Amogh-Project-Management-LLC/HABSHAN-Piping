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
using dsPaintingMatTableAdapters;

public partial class Painting_PaintBulkItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string issue_no = WebTools.GetExpr("PAINT_REQ_NO", "PIP_PAINTING_MAT",
                "PAINT_ID=" + Request.QueryString["PAINT_ID"]);
            Master.HeadingMessage = "Paint Request <br/>" + issue_no;

        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaintBulk.aspx?Filter=" + Request.QueryString["Filter]"]);
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
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("MM_DELETE"))
        //{
        //    Master.ShowWarn("Access Denied!");
        //    return;
        //}
        //if (itemsGridView.SelectedIndexes.Count < 0)
        //{
        //    Master.ShowMessage("Select the row!");
        //    return;
        //}
        //btnYes.Visible = true;
        //btnNo.Visible = true;
        //Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
           
            Master.ShowMessage("Selected row deleted.");
            itemsGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string MAT_CODE = string.Empty;
        string MAT_ID = string.Empty;

        if (RadAutoCompleteBox1.Entries.Count > 0)
        {
            MAT_CODE = RadAutoCompleteBox1.Entries[0].Text;
        }
        else
        {
            Master.ShowMessage("No Item code entered!");
            return;
        }

        VIEW_PAINTING_MAT_DETAILTableAdapter items = new VIEW_PAINTING_MAT_DETAILTableAdapter();
        try
        {
            MAT_ID = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", "PROJ_ID=" + Session["PROJECT_ID"].ToString() + " AND MAT_CODE1='" + MAT_CODE + "'");

            if (MAT_ID.Length == 0)
            {
                Master.ShowWarn("Material code not found!");
                return;
            }

            //Check if Qty Available?
            //string BAL_QTY = WebTools.GetExpr("BAL_QTY", "VIEW_SG_MTO_VS_PAINT_JC_A", "MAT_ID=" + MAT_ID);

            //if (BAL_QTY.Length == 0)
            //{
            //    Master.ShowWarn("Material not available for paint!");
            //    return;
            //}
            //else
            //{
            //    decimal JC_QTY = Decimal.Parse(txtIssuedQty.Text) * Decimal.Parse(txtPipePcs.Text);
            //    decimal BAL_QTY_DEC = decimal.Parse(BAL_QTY);
            //    if (BAL_QTY_DEC < JC_QTY)
            //    {
            //        Master.ShowWarn("Available qty is less than jobcard qty is not sufficient! Available qty=" + BAL_QTY);
            //        return;
            //    }
            //}

            if (Decimal.Parse(txtAvlQty.Text) < decimal.Parse(txtReqQty.Text))
            {
                Master.ShowError("Paint Qty cannot exceed available qty.");
                return;
            }
            //Decimal? ISSUED_QTY = string.IsNullOrEmpty(txtIssuedQty.Text) ? null : (Decimal?)decimal.Parse(txtIssuedQty.Text);
            //DateTime? CMR_DATE = !txtCMR_Date.SelectedDate.HasValue ? null : (DateTime?) txtCMR_Date.SelectedDate;

            items.InsertQuery(
                Decimal.Parse(Request.QueryString["PAINT_ID"]),
                decimal.Parse(MAT_ID),
                Decimal.Parse(txtReqQty.Text),
                Decimal.Parse(txtPipePcs.Text),
                string.Empty,
                null,
                0,
                "XXX",
                null,
                ddlPaintCode.SelectedValue
                );

            itemsGridView.DataBind();
            Master.ShowMessage(MAT_CODE + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
            //Master.ShowWarn(MAT_CODE);
        }
        finally
        {
            items.Dispose();
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

    protected void RadAutoCompleteBox1_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        //Get Available & Previous Issued Qty
        string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " WHERE MAT_CODE1='" + RadAutoCompleteBox1.Entries[0].Text + "'");
        string sc_id = WebTools.GetExpr("SC_ID", "PIP_PAINTING_MAT", " WHERE PAINT_ID='" + Request.QueryString["PAINT_ID"] + "'");
        txtAvlQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A", " WHERE MAT_ID = " + mat_id + " and SUB_CON_ID = '" + sc_id+"'");
        txtPrevJcQty.Text = WebTools.GetExpr("ISSUED_QTY", "VIEW_PAINT_ISSUED", " WHERE SC_ID = '" + sc_id + "' AND MAT_ID = '" + mat_id + "'");
    }

    protected void ddlPaintCode_DataBinding(object sender, EventArgs e)
    {
        ddlPaintCode.Items.Clear();
        ddlPaintCode.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }
}