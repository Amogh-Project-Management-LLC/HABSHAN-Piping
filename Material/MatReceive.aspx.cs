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

public partial class Material_MatReceive : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string filter_ = Session["MRIR_FILTER"].ToString();
            if (filter_ != "") txtSearch.Text = filter_;
            Master.HeadingMessage = "Material Receive Voucher (MRV)";
        }
    }
    protected void btnViewItems_Click(object sender, EventArgs e)
    {
        if (MatReceiveGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the report number first.");
            return;
        }
        Response.Redirect("MatReceiveItems.aspx?MAT_RCV_ID=" + MatReceiveGridView.SelectedValue.ToString());
    }
    protected void btnNewTrans_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("No Access!");
            return;
        }
        Response.Redirect("MatReceiveNew.aspx");
    }
  
    protected void MatReceiveGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
    protected void MatReceiveGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void MatReceiveGridView_DataBound(object sender, EventArgs e)
    {

    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (MatReceiveGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire MRV number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=9&Arg1=" + MatReceiveGridView.SelectedValue.ToString());
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["MRIR_FILTER"] = txtSearch.Text;
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=10&RetUrl=~/Material/MatReceive.aspx");
    }
}