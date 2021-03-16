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

public partial class WeldingInspec_JointPaintNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIP_WIC_INSERT"))
            {
                btnSubmit.Enabled = false;
                Master.ShowAccessDenied();
            }
            Master.HeadingMessage("New");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_RT_100TableAdapter joint_paint = new VIEW_RT_100TableAdapter();
        try
        {
            joint_paint.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(cboNewJoint.SelectedValue.ToString()),
                decimal.Parse(ddWelderNos.SelectedValue.ToString()),
                txtRemarks.Text,
                decimal.Parse(cboRejJoint.SelectedValue.ToString())
                );

            Master.show_success("Saved!");
        }
        catch (Exception ex)
        {
            joint_paint.Dispose();
            Master.show_error(ex.Message);
        }
        finally
        {
            joint_paint.Dispose();
        }
    }


    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {

    }

    protected void ddWelderNos_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddWelderNos_DataBinding(object sender, EventArgs e)
    {
        ddWelderNos.Items.Clear();
        ddWelderNos.Items.Add(new ListItem("", "-1"));
    }

    protected void cboNewJoint_DataBinding(object sender, EventArgs e)
    {
        cboNewJoint.Items.Clear();
        cboNewJoint.Items.Add(new ListItem("", "-1"));
    }

    protected void cboRejJoint_DataBinding(object sender, EventArgs e)
    {
        cboRejJoint.Items.Clear();
        cboRejJoint.Items.Add(new ListItem("", "-1"));
    }
}