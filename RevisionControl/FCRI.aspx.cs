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

public partial class RevisionControl_FCRI : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "FCRI";
        }
    }
    protected void scrGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (relGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the request");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the request?");
    }
    protected void btnViewItems_Click(object sender, EventArgs e)
    {
        if (relGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the request");
            return;
        }
        Response.Redirect("FCRI_Items.aspx?FCRI_ID=" + relGridView.SelectedValue.ToString());
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            relGridView.DeleteRow(relGridView.SelectedIndex);
        }
        catch
        {
            Master.ShowWarn("Unable to delete the row!");
        }
    }
    protected void btnNewTrans_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("FCRI_New.aspx");
    }
    protected void scrGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < relGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", relGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == relGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        relGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnSplList_Click(object sender, EventArgs e)
    {
        if (relGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=1&FCRI_ID=" + relGridView.SelectedValue.ToString());
    }
    protected void btnMatImpact_Click(object sender, EventArgs e)
    {
        if (relGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=2&FCRI_ID=" + relGridView.SelectedValue.ToString());
    }
    protected void btnWeldImpact_Click(object sender, EventArgs e)
    {
        if (relGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=3&FCRI_ID=" + relGridView.SelectedValue.ToString());
    }
}