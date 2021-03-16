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
using dsWeldingBTableAdapters;

public partial class WeldingInspec_JointsPaintItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string trans_no = WebTools.GetExpr("JNT_PNT_NO", "PIP_JOINT_PAINT", " WHERE JNT_PNT_ID=" +
                Request.QueryString["JNT_PNT_ID"]);
            Master.HeadingMessage = "Joint Painting (" + trans_no + ")";
        }
    }
    protected void btnAddJoint_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        PIP_JOINT_PAINT_DETAILTableAdapter items = new PIP_JOINT_PAINT_DETAILTableAdapter();
        try
        {
            items.InsertQuery(Decimal.Parse(Request.QueryString["JNT_PNT_ID"]), Decimal.Parse(cboNewJoint.SelectedValue));
            items.Dispose();
            Master.ShowMessage("New joint added successfully.");
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
        Response.Redirect("JointsPaint.aspx");
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