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
using dsTestPkg_ATableAdapters;

public partial class TestPkg_Punch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Punch List (" +
                    WebTools.GetExpr("TPK_NUMBER", "TPK_MASTER", " WHERE TPK_ID=" + Request.QueryString["TPK_ID"]) + ")";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg.aspx");
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
        ISO_ID_Field.Value = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + txtIsome.Text + "'");
    }

    private void next_item_no()
    {
        txtItem.Text = General_Functions.NextSerialNo("TPK_PUNCH_LIST", "ITEM_NO", "", 3, " WHERE TPK_ID=" + Request.QueryString["TPK_ID"]);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ISO_ID_Field.Value.ToString().Length == 0)
        {
            Master.ShowWarn("Isometric Not Found!");
            return;
        }

        VIEW_TPK_PUNCHTableAdapter punchs = new VIEW_TPK_PUNCHTableAdapter();
        try
        {
            punchs.InsertQuery(decimal.Parse(Request.QueryString["TPK_ID"]),
                txtItem.Text,
                cboCat.SelectedValue.ToString(),
                decimal.Parse(cboOrgn.SelectedValue.ToString()),
                decimal.Parse(ISO_ID_Field.Value.ToString()),
                cboSheet.SelectedValue.ToString(), 
                txtRemarks.Text.ToUpper().Trim(), string.Empty);

            GridView1.DataBind();
            Master.ShowMessage("Punch created successfully!");

            next_item_no();

            //txtIsome.Text = "";
            txtRemarks.Text = string.Empty;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            punchs.Dispose();
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (GridView1.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select a row!");
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
            //string bom_id = GridView1.SelectedDataKey[1].ToString();
            //GridView1.DeleteRow(GridView1.SelectedIndex);
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
            next_item_no();
        }
        else
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
    }
}