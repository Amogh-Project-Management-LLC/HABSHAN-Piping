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
        if (!WebTools.UserInRole("MM_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Transfer";
            if (Session["MTN_FILTER"] != null)
                txtSearch.Text = Session["MTN_FILTER"].ToString();
        }
    }
    protected void btnViewMats_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        Response.Redirect("Mat_Transf_Items.aspx?TRANSF_ID=" + IssueGridView.SelectedValue.ToString());
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
        Response.Redirect("Mat_Transf_Regist.aspx");
    }
    protected void IssueGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < IssueGridView.PageCount; i++)
        {
            Telerik.Web.UI.DropDownListItem pageListItem =
                   new Telerik.Web.UI.DropDownListItem(String.Concat("Page ", i + 1, " of ", IssueGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == IssueGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        IssueGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (IssueGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the transfer number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=22&Arg1=" + IssueGridView.SelectedValue.ToString());
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        IssueGridView.DataBind();
        Session["MTN_FILTER"] = txtSearch.Text;
    }
}