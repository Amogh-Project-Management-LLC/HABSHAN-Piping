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

public partial class CuttingPlan_PipeRemains : System.Web.UI.Page
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
            string filter_ = Session["REM_FILTER"].ToString();
            if (filter_ != "") txtSearch.Text = filter_;

            Master.HeadingMessage = "Pipe Remains";
        }
    }

    protected void remainGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < remainGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", remainGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == remainGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        remainGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnResgister_Click(object sender, EventArgs e)
    {
        Response.Redirect("PipeRemainsRegister.aspx");
    }
    protected void btnHistory_Click(object sender, EventArgs e)
    {
        if (remainGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selecet the entire remain item!");
            return;
        }
        Response.Redirect("PipeRemainsHistory.aspx?REM_ID=" + remainGridView.SelectedValue.ToString());
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (remainGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire row!");
            return;
        }
        Master.ShowWarn("Proceed delete the selected row?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //remainGridView.DeleteRow(remainGridView.SelectedIndex);
            //Master.ShowMessage("selected row deleted.");
            //remainGridView.SelectedIndex = -1;
            dsCuttingPlanTableAdapters.PIP_PIPE_REMAINTableAdapter remain = new dsCuttingPlanTableAdapters.PIP_PIPE_REMAINTableAdapter();
            remain.DeleteQuery(decimal.Parse(remainGridView.SelectedValue.ToString()));
            remainGridView.Rebind();
            Master.ShowMessage("Selected Item Deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["REM_FILTER"] = txtSearch.Text;
    }
    protected void btnAddIssued_Click(object sender, EventArgs e)
    {
        if (remainGridView.SelectedIndexes.Count < 0)
        {
            Master.ShowMessage("Selecet the entire remain item!");
            return;
        }
        Response.Redirect("PipeRemainsAddIssued.aspx?REM_ID=" + remainGridView.SelectedValue.ToString());
    }
}