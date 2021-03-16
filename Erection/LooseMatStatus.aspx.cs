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

public partial class LooseMatStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Support/ Loose Materials Erection";
            txtDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
            string isome = Request.QueryString["Isome"];
            string Filter = Request.QueryString["Filter"];
            if (isome != "")
            {
                txtIsome.Text = isome;
            }
            if (Filter != "")
            {
                txtCommodity.Text = Filter;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ErectionHome.aspx");
    }

    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
    }
    protected void txtSupp_TextChanged(object sender, EventArgs e)
    {
        txtCommodity.Text = txtCommodity.Text.Trim().ToUpper();
    }
    protected void btnErected_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowWarn("Select a row!");
            return;
        }

        Response.Redirect("Erected.aspx?BOM_ID=" + rowsGridView.SelectedValue.ToString() +
            "&Isome=" + txtIsome.Text + "&Filter=" + txtCommodity.Text);
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (ErectionEntryTable.Visible == false)
        {
            ErectionEntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            ErectionEntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowWarn("Select a row!");
            return;
        }

        PIP_BOM_ERECTableAdapter erec = new PIP_BOM_ERECTableAdapter();
        try
        {
            erec.InsertQuery(decimal.Parse(rowsGridView.SelectedValue.ToString()),
                DateTime.Parse(txtDate.Text),
                txtRepNo.Text,
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                decimal.Parse(txtQty.Text),
                txtRem.Text);
            Master.ShowMessage("Erection report saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            erec.Dispose();
        }
    }
}