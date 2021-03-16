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

public partial class WeldingInspec_JointPaintNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIP_WIC_INSERT"))
            {
                btnSubmit.Enabled = false;
                txtJntPaintNo.Text = "Access Denied!";
            }
            Master.HeadingMessage("New");
        }
    }

    private void redirect_back()
    {
        Response.Redirect("~/WeldingInspec/JointsPaint.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_JOINT_PAINTTableAdapter joint_paint = new PIP_JOINT_PAINTTableAdapter();
        try
        {
            joint_paint.InsertQuery(txtJntPaintNo.Text,
                txtIssueDate.SelectedDate,
                txtIssuedby.Text,
                Decimal.Parse(cboSubcon.SelectedValue), txtRemarks.Text,
                Decimal.Parse(Session["PROJECT_ID"].ToString()));
            joint_paint.Dispose();

            Master.show_success(txtJntPaintNo.Text + " Saved!");
        }
        catch (Exception ex)
        {
            joint_paint.Dispose();
            Master.show_error(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        redirect_back();
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }
    private void set_req_no()
    {
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
            cboSubcon.SelectedValue.ToString());
        try
        {
            txtJntPaintNo.Text = General_Functions.NextSerialNo("PIP_JOINT_PAINT", "JNT_PNT_NO", "JPNT-" + sc_name + "-",
                4, " WHERE PROJECT_ID=" + Session["PROJECT_ID"] +
                " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message + ", " + "Check your request numbers format!");
        }
    }
}