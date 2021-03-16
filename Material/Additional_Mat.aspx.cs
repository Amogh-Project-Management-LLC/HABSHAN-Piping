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

public partial class Erection_MatIssueLoose : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["ADD_MIV_FILTER"].ToString() != "")
            {
                txtSearch.Text = Session["ADD_MIV_FILTER"].ToString();
            }
            Master.HeadingMessage = "Additional Materials Issue";
            Master.AddModalPopup("~/Material/Additional_MatRegist.aspx", btnNewIssue.ClientID, 450, 500);
            Master.RadGridList = IssueGridView.ClientID;
        }
    }

    protected void btnViewMats_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the issue number.");
            return;
        }
        Response.Redirect("Additional_MatItems.aspx?ADD_ISSUE_ID=" + IssueGridView.SelectedValue.ToString());
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
        Response.Redirect("Additional_MatRegist.aspx");
    }

    protected void IssueGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < IssueGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", IssueGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == IssueGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        IssueGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            dsMaterial_IssueATableAdapters.PIP_MAT_ISUE_ADDTableAdapter issue = new dsMaterial_IssueATableAdapters.PIP_MAT_ISUE_ADDTableAdapter();
            issue.DeleteQuery(decimal.Parse(IssueGridView.SelectedValue.ToString()));
            Master.ShowMessage("Item Deleted.");
            IssueGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the Issue number!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected issue number?");
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() + "&Arg1=" + IssueGridView.SelectedValue.ToString());
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["ADD_MIV_FILTER"] = txtSearch.Text;
    }

    protected void btnPipeRemain_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the issue number.");
            return;
        }
        Response.Redirect("Additional_Mat_Remain.aspx?ADD_ISSUE_ID=" + IssueGridView.SelectedValue.ToString());
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the issue number.");
            return;
        }
        Response.Redirect("Additional_Mat_BOM.aspx?ADD_ISSUE_ID=" + IssueGridView.SelectedValue.ToString());
    }
}