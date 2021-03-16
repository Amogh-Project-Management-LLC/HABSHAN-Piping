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
using Telerik.Web.UI;

public partial class TestPkg_TestPkg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string filter_ = Session["TPK_FILTER"].ToString();
            if (filter_ != "") txtSearch.Text = filter_;
            Master.HeadingMessage = "Test Package";
            Master.AddModalPopup("~/TestPackage/TestPkg_Register.aspx", btnRegister.ClientID, 550, 650);
            Master.RadGridList = tpGridView.ClientID;
        }
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (if_selected() == true) Response.Redirect("TestPkg_View.aspx?TPK_ID=" + tpGridView.SelectedValue.ToString());
    }
    protected void btnPunchList_Click(object sender, EventArgs e)
    {
        if (if_selected() == true) Response.Redirect("TestPkg_Punch.aspx?TPK_ID=" + tpGridView.SelectedValue.ToString());
    }
    private bool if_selected()
    {
        if (tpGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire test loop number!");
            return false;
        }
        else
        {
            return true;
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["TPK_FILTER"] = txtSearch.Text;
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Register.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (tpGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //tpGridView.DeleteRow(tpGridView.SelectedIndex);
            //Master.ShowMessage("Row deleted successfully!");
            //tpGridView.SelectedIndex = -1;
            string tpk_id = WebTools.GetExpr("TPK_ID", "TPK_MASTER", "  WHERE  TPK_ID=" + tpGridView.SelectedValues["TPK_ID"].ToString());
            string query = "DELETE FROM TPK_MASTER WHERE TPK_ID=" + tpk_id;
            WebTools.exec_non_qry(query);
            tpGridView.DataBind();
            Master.ShowMessage("Test Package Deleted!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnAddItems_Click(object sender, EventArgs e)
    {
        if (if_selected() == true) Response.Redirect("TestPkg_Spools.aspx?TPK_ID=" + tpGridView.SelectedValue.ToString());
    }
    protected void btnPrw_Click(object sender, EventArgs e)
    {
        if (tpGridView.SelectedIndexes.Count < 0)
        {
            Master.ShowMessage("No test package selecetd!");
            return;
        }
        if (cboReports.SelectedValue.ToString() == "-1")
        {
            Master.ShowMessage("Select the report from dropdown list!");
            return;
        }
        string url = string.Format("ReportViewer.aspx?ReportID={0}&Arg1={1}", cboReports.SelectedValue.ToString(), tpGridView.SelectedValue.ToString());
        Response.Redirect(url);
    }
    protected void btnTpkIsome_Click(object sender, EventArgs e)
    {
        if (if_selected() == true) Response.Redirect("TestPkg_Isome.aspx?TPK_ID=" + tpGridView.SelectedValue.ToString());
    }
    protected void RadMenu1_ItemClick(object sender, RadMenuEventArgs e)
    {
      
        switch (e.Item.Value)
        {
            
            case "SYS_DEF":
                Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=38&RetUrl=~/TestPackage/TestPkg.aspx");
                break;
            case "TEST_IMP":
                Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=39&RetUrl=~/TestPackage/TestPkg.aspx");
                break;
            case "TPK_ISOME":
                Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=40&RetUrl=~/TestPackage/TestPkg.aspx");
                break;
            case "TPK_SPL":
                Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=41&RetUrl=~/TestPackage/TestPkg.aspx");
                break;
        }
    }
}