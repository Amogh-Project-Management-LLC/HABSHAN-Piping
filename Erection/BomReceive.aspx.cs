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

public partial class PipeSupport_BomReceive : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Receive";
        }
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (if_selected() == true) Response.Redirect("BomReceiveDetail.aspx?RECV_ID=" + rowsGridView.SelectedValue.ToString());
    }
    private bool if_selected()
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowWarn("Select a row!");
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
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
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
            rowsGridView.DeleteRow(rowsGridView.SelectedIndex);
            Master.ShowMessage("Row deleted successfully!");
            rowsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ErectionHome.aspx");
    }
    protected void btnRegist_Click(object sender, EventArgs e)
    {
        Response.Redirect("BomReceiveNew.aspx");
    }

    protected void rowsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
        {
            e.Cancel = true;
            Master.ShowWarn("Access Denied!");
        }
    }
    protected void btnPreview_Click1(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=17&RECV_ID=" + rowsGridView.SelectedValue.ToString());
    }
}