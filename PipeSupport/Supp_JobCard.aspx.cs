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

public partial class Supp_JobCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Support Job Card";
            if (Request.QueryString["Filter"] != null && Request.QueryString["Filter"] != string.Empty)
            {
                txtSearch.Text = Request.QueryString["Filter"];
            }
        }
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (if_selected() == true) Response.Redirect("Supp_JobCard_Detail.aspx?JC_ID=" + rowsGridView.SelectedValue.ToString() +
            "&Filter=" + txtSearch.Text);
    }
    private bool if_selected()
    {
        if (rowsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire row!");
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
        if (rowsGridView.SelectedIndexes.Count == 0)
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
            //rowsGridView.DeleteRow(rowsGridView.SelectedIndex);
            //Master.ShowMessage("Row deleted successfully!");
            //rowsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/Supp_Home.aspx");
    }

    protected void btnRegist_Click(object sender, EventArgs e)
    {
        Response.Redirect("Supp_JobCard_New.aspx?Filter=" + txtSearch.Text);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        string url = "Supp_ReportViewer.aspx?ReportID=" + cboReports.SelectedValue.ToString() + "&Arg1=" + rowsGridView.SelectedValue.ToString();
        
        Response.Redirect(url);
    }

    protected void btnUpdateJc_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("Supp_JobCard_Update.aspx?JC_ID=" + rowsGridView.SelectedValue.ToString() +
            "&Filter=" + txtSearch.Text);
    }

    protected void rowsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
        {
            e.Cancel = true;
            Master.ShowWarn("Access Denied!");
        }
    }

    protected void btnSelectSupports_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("Supp_JobCard_Select.aspx?JC_ID=" + rowsGridView.SelectedValue.ToString() +
            "&Filter=" + txtSearch.Text);
    }

}