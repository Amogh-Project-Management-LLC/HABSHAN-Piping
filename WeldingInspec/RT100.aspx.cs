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

public partial class WeldingInspec_FieldJointsPaint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Penalty 100% RT";
            Master.RadGridList = "";
            Master.AspGridList = TransGridView.ClientID;
            Master.AddModalPopup("~/WeldingInspec/RT100New.aspx", btnNew.ClientID, 400, 750);
        }
    }

    protected void btnViewJoints_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndex < 0) return;
        Response.Redirect("RT100Items.aspx?LIST_ID=" + TransGridView.SelectedValue.ToString());
    }
    protected void TransGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }
    }
    protected void TransGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < TransGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", TransGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == TransGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TransGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            Master.ShowMessage("Access Denied!");
            return;
        }
        if (TransGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            TransGridView.DeleteRow(TransGridView.SelectedIndex);
            Master.ShowMessage("row deleted!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}