using System;
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

public partial class MatIssueLoose : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Site Assembly";
            Master.AddModalPopup("~/Erection/SiteAssemblyJCRegister.aspx", btnNewIssue.ClientID, 550, 650);
            Master.RadGridList = LooseIssueGridView.ClientID;
        }
    }
    protected void btnViewMats_Click(object sender, EventArgs e)
    {
        if (LooseIssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the issue number.");
            return;
        }
        Response.Redirect("SiteAssemblyJCMats.aspx?JC_ID=" + LooseIssueGridView.SelectedValue.ToString());
    }
    protected void LooseIssueGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnNewIssue_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MatIssueLooseRegister.aspx");
    }
    protected void LooseIssueGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < LooseIssueGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", LooseIssueGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == LooseIssueGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        LooseIssueGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (LooseIssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the JC!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete selecetd JC!");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            dsErectionTableAdapters.VIEW_SITE_JC_ASSEMBLYTableAdapter site_jc = new dsErectionTableAdapters.VIEW_SITE_JC_ASSEMBLYTableAdapter();
            site_jc.DeleteQuery(decimal.Parse(LooseIssueGridView.SelectedValue.ToString()));
            Master.ShowMessage("Deleted successfully.");
            LooseIssueGridView.Rebind();
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
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (LooseIssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the JC number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() +
            "&JC_ID=" + LooseIssueGridView.SelectedValue.ToString());
    }
    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (LooseIssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the JC.");
            return;
        }
        Response.Redirect("MatIssueLooseSpool.aspx?JC_ID=" + LooseIssueGridView.SelectedValue.ToString());
    }

    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (LooseIssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the JC.");
            return;
        }
        Response.Redirect("SiteAssemblyJCJoints.aspx?JC_ID=" + LooseIssueGridView.SelectedValue.ToString());
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {

        if (LooseIssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the JC.");
            return;
        }
        string jc_type = WebTools.GetExpr("JC_TYPE", "PIP_MAT_ISSUE_LOOSE", " WHERE JC_ID='" + LooseIssueGridView.SelectedValue + "'");

        if (jc_type.ToUpper() == "100% MATERAIL")
        {

        }
        else {
            Master.ShowError("Sorry! This option works only with 100% Available Material JCs.");
        }
    }
}