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
using dsTestPkg_BTableAdapters;

public partial class TestPkg_Isome_Spl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Test Pack Isome/ Spools/(" +
                    WebTools.GetExpr("ISO_TITLE1", "PIP_ISOMETRIC", " WHERE ISO_ID=" + Request.QueryString["ISO_ID"]) + ")";
        }
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        cboNewSpool.Visible = true;
        btnAddSpool.Visible = true;
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (spoolsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the spool!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected spool?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            string query = "DELETE FROM TPK_ISOME_SPL WHERE TPK_ITEM_ID=" + spoolsGridView.SelectedValues["TPK_ITEM_ID"].ToString()
                 + " AND SPL_ID=" + spoolsGridView.SelectedValues["SPL_ID"].ToString();
            WebTools.exec_non_qry(query);
            spoolsGridView.DataBind();
            Master.ShowMessage("Spool deleted from TPK Isome!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn("Unable to delete the spool!, " + ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Isome.aspx?TPK_ID=" + Request.QueryString["TPK_ID"]);
    }
    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        TPK_ISOME_SPLTableAdapter spools = new TPK_ISOME_SPLTableAdapter();
        try 
        {
            spools.InsertQuery(decimal.Parse(Request.QueryString["TPK_ITEM_ID"]),
                decimal.Parse(cboNewSpool.SelectedValue.ToString()));
            spoolsGridView.DataBind();
            Master.ShowMessage("Spool added to test package successfully!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            spools.Dispose();
        }
    }
}