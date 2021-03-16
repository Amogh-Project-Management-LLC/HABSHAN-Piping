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
using dsRT100TableAdapters;

public partial class WeldingInspec_JointsPaintItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Penalty 100% RT";
        }
    }
    protected void btnAddJoint_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        VIEW_RT_100_DETAILTableAdapter items = new VIEW_RT_100_DETAILTableAdapter();
        try
        {
            items.InsertQuery(
                decimal.Parse(Request.QueryString["LIST_ID"]),
                decimal.Parse(cboNewJoint.SelectedValue));
            jointsGridView.DataBind();

            Master.ShowMessage(cboNewJoint.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }

    protected void jointsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("RT100.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            Master.ShowMessage("Access Denied!");
            return;
        }
        if (jointsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a joint!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected joint?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            jointsGridView.DeleteRow(jointsGridView.SelectedIndex);
            Master.ShowMessage("joint deleted successfully!");
            jointsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void jointsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowMessage("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        btnAddJoint.Visible = true;
        txtIsome.Visible = true;
        cboNewJoint.Visible = true;
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.ToUpper().Trim();
    }
}