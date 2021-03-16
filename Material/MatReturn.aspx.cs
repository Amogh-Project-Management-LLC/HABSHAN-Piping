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

public partial class Material_MatReturn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Return";
        }
    }
    protected void returnGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < returnGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", returnGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == returnGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        returnGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnRegist_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MatReturnRegister.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (returnGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row!?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            returnGridView.DeleteRow(returnGridView.SelectedIndex);
            Master.ShowMessage("Selected row deleted successfully.");
            returnGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (returnGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        Response.Redirect("MatReturnItems.aspx?MAT_RET_ID=" + returnGridView.SelectedValue.ToString());
    }

    protected void returnGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnPreview_Click1(object sender, EventArgs e)
    {
        if (returnGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire Retutn Number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=1&Arg1=" + returnGridView.SelectedValue.ToString());
    }
}