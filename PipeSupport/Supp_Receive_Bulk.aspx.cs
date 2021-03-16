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
using dsSupp_ETableAdapters;

public partial class PipeSupport_Supp_Receive_Bulk : System.Web.UI.Page
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

            Master.HeadingMessage = "Support Receive <br/>" +
            WebTools.GetExpr("RECV_NO", "PIP_SUPP_RECEIVE", "RECV_ID=" + Request.QueryString["RECV_ID"]);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal MAT_ID = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (MAT_ID == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (MAT_ID == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }

        VIEW_SUPP_RECEIVE_BULKTableAdapter items = new VIEW_SUPP_RECEIVE_BULKTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["RECV_ID"]),
                MAT_ID,
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
        Response.Redirect("Supp_Receive.aspx?Filter=" + Request.QueryString["Filter"]);
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

    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
        {
            e.Cancel = true;
            Master.ShowWarn("Access Denied!");
        }
    }
}