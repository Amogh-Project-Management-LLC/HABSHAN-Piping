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

public partial class TestPkg_Isome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string tpk_id = Request.QueryString["TPK_ID"];
            Master.HeadingMessage = "Test Pack Isome(" +
                  WebTools.GetExpr("TPK_NUMBER", "TPK_MASTER", " WHERE TPK_ID=" + tpk_id) + ")";
        }
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        txtLineNo.Visible = true;
        cboNewIsome.Visible = true;
        btnAddIsome.Visible = true;
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("TPK_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (isomeGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the isometric!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected isometric?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {

            string tpk_item_id = WebTools.GetExpr("TPK_ITEM_ID", "TPK_ISOME", "  WHERE  TPK_ID=" + isomeGridView.SelectedValues["TPK_ID"].ToString()
             + "  AND ISO_ID=" + isomeGridView.SelectedValues["ISO_ID"].ToString());
            string query = "DELETE FROM TPK_ISOME WHERE TPK_ITEM_ID=" + tpk_item_id;
            WebTools.exec_non_qry(query);
            isomeGridView.DataBind();
            Master.ShowMessage("Isometric deleted from Test Package !");
        
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg.aspx");
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Isome.aspx?TPK_ID=" + Request.QueryString["TPK_ID"]);
    }
    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_TPK_ISOMETableAdapter isome = new VIEW_ADAPTER_TPK_ISOMETableAdapter();
        try
        {
            isome.InsertQuery(decimal.Parse(Request.QueryString["TPK_ID"]),
                decimal.Parse(cboNewIsome.SelectedValue.ToString()));

            isomeGridView.DataBind();
            Master.ShowMessage("Isometric added to test package!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            isome.Dispose();
        }
    }
    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (isomeGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the isometric!");
            return;
        }
        //if (IsPostBack)
        //{
            string tpk_item_id = WebTools.GetExpr("TPK_ITEM_ID","TPK_ISOME", " WHERE TPK_ID=" + isomeGridView.SelectedValues["TPK_ID"].ToString() + " AND ISO_ID=" + isomeGridView.SelectedValues["ISO_ID"].ToString());
            Response.Redirect("TestPkg_Isome_Spl.aspx?TPK_ITEM_ID=" + tpk_item_id + "&ISO_ID=" + isomeGridView.SelectedValues["ISO_ID"] + "&TPK_ID=" + isomeGridView.SelectedValues["TPK_ID"]);
            // "&ISO_ID=" + isomeGridView.SelectedValues[1].ToString() + "&TPK_ID=" + Request.QueryString["TPK_ID"]);
        //}
    }
}