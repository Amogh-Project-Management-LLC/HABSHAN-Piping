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

public partial class PipeSupport_Supp_Release_Detail : System.Web.UI.Page
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

            Master.HeadingMessage = "Support Release<br/>" +
            WebTools.GetExpr("REL_NO", "PIP_SUPP_REL", "REL_ID=" + Request.QueryString["REL_ID"]);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string RET_VAL = string.Empty;

        if (ddEntryType.SelectedValue.ToString() == "1")
        {
            try
            {
                RET_VAL = WebTools.GetExpr(
                    "FNC_SUPP_REL_SAVE_ISO(" + Request.QueryString["REL_ID"] + ",'" + txtIsome.Text + "')", "DUAL", "");
                itemsGridView.DataBind();
                Master.ShowMessage("Saved!");
                return;
            }
            catch (Exception ex)
            {
                Master.ShowWarn(ex.Message);
            }
        }

        string BOM_QTY = WebTools.GetExpr("NET_QTY", "PIP_BOM", "BOM_ID=" + ddSupp.SelectedValue.ToString());

        VIEW_SUPP_REL_DETAILTableAdapter items = new VIEW_SUPP_REL_DETAILTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["REL_ID"]),
                decimal.Parse(ddSupp.SelectedValue.ToString()),
                txtRem.Text);

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
        Response.Redirect("Supp_Release.aspx");
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
            Master.ShowWarn("Select the row!");
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
            Enable_Controls();
        }
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            ddSupp.Items.Clear();
            ddSupp.Items.Add(new ListItem("(Select Support)", "-1"));
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
    protected void ddEntryType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Enable_Controls();
    }
    private void Enable_Controls()
    {
        if (ddEntryType.SelectedValue.ToString() == "1")
        {
            txtIsome.Enabled = true;
            ddSupp.Enabled = false;
            suppValidator.Enabled = false;
        }
        else if (ddEntryType.SelectedValue.ToString() == "2")
        {
            ddSupp.Enabled = true;
            txtIsome.Enabled = true;
            suppValidator.Enabled = true;
        }
    }
}