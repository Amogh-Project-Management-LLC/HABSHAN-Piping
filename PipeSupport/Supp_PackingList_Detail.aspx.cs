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
using dsSupp_ATableAdapters;

public partial class Supp_PackingList_Detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_DELETE"))
            {
                Master.ShowWarn("Access Denied!");
                btnHideEnt.Enabled = false;
            }

            Master.HeadingMessage = "Packing List <br/>" +
            WebTools.GetExpr("PACKING_NO", "PIP_SUPP_PACKING", "PACKING_ID=" + Request.QueryString["PACKING_ID"]);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string MAT_CODE = string.Empty;
        if (RadAutoCompleteBox1.Entries.Count > 0)
        {
            MAT_CODE = RadAutoCompleteBox1.Entries[0].Text;
        }
        else
        {
            Master.ShowError("No Item code entered!");
            return;
        }

        string MAT_ID = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", "PROJ_ID=" + Session["PROJECT_ID"].ToString() + " AND MAT_CODE1='" + MAT_CODE + "'");

        VIEW_SUPP_PACKING_DTTableAdapter items = new VIEW_SUPP_PACKING_DTTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["PACKING_ID"]),
                decimal.Parse(MAT_ID),
                decimal.Parse(txtQty.Text), txtRem.Text,
                txtBoxNo.Text,
                txtArea.Text,
                txtPaintCode.Text);

            itemsGridView.DataBind();

            Master.ShowMessage(MAT_CODE + " Saved!");
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
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Supp_PackingList.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //string bom_id = itemsGridView.SelectedDataKey[1].ToString();
            //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            //Master.ShowMessage("Row deleted successfully!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnHideEnt_Click(object sender, EventArgs e)
    {
        if (EntryTable.Visible == true)
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
        else
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
    }
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
        {
            e.Cancel = true;
            Master.ShowWarn("Access Denied!");
        }
    }
}