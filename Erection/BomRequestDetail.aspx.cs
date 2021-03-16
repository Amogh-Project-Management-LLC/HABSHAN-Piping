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
using dsErectionATableAdapters;

public partial class PipeSupport_BomRequestDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_INSERT"))
            {
                Master.ShowWarn("Access Denied!");
                btnHideEnt.Enabled = false;
            }

            Master.HeadingMessage = "Material Request <br/>" +
            WebTools.GetExpr("BOM_REQ_NO", "PIP_BOM_REQUEST", "REQ_ID=" + Request.QueryString["REQ_ID"]);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_BOM_REQUEST_DETAILTableAdapter items = new VIEW_BOM_REQUEST_DETAILTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["REQ_ID"]),
                decimal.Parse(ddSupp.SelectedValue.ToString()),
                decimal.Parse(txtQty.Text), txtRem.Text);
            itemsGridView.DataBind();
            Master.ShowMessage("Successful!");
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
        Response.Redirect("BomRequest.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (itemsGridView.SelectedIndex < 0)
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
            string bom_id = itemsGridView.SelectedDataKey[1].ToString();
            itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            Master.ShowMessage("Row deleted successfully!");
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
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            ddSupp.Items.Clear();
            ddSupp.Items.Add(new ListItem("(Ident Code)", "-1"));
        }
    }
    protected void ddSupp_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddSupp.SelectedValue.ToString() == "-1")
        {
            txtQty.Text = "0";
        }
        else
        {
            txtQty.Text = WebTools.GetExpr("NET_QTY", "PIP_BOM", "BOM_ID=" + ddSupp.SelectedValue.ToString());
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