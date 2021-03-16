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
using dsErectionTableAdapters;

public partial class Erection_ErectionRepRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Site Assembly Job Card");
            txtIssueDate.SelectedDate = System.DateTime.Now;
            txtIssuedBy.Text = Session["USER_NAME"].ToString();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_SITE_JC_ASSEMBLYTableAdapter issue = new VIEW_SITE_JC_ASSEMBLYTableAdapter();
        try
        {
            issue.InsertQuery(txtIssueNumber.Text,
                txtIssueDate.SelectedDate,
                txtIssuedBy.Text,
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                 txtArea.Text,
                txtRemarks.Text,"2");
            Master.show_success("Site Job Card " + txtIssueNumber.Text + " created successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatIssueLoose.aspx");
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cboSubcon.SelectedValue.ToString() == "-1") return;
        set_miv_no();
    }
    private void set_miv_no()
    {
        //string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
        //    cboSubcon.SelectedValue.ToString());
        //string prefix = "FFI-" + txtMaterialType.Text + "-" + txtPCWBS.Text + "-";
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-SITE-FLG-JC-" + WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID='" + cboSubcon.SelectedValue + "'");
        prefix += "-";
        txtIssueNumber.Text = General_Functions.NextSerialNo(
            "PIP_MAT_ISSUE_ASSEMBLY", "ISSUE_NO", prefix,
            4, " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
            " AND SC_ID=" + cboSubcon.SelectedValue.ToString());

    }
    protected void txtAutoNum_Click(object sender, EventArgs e)
    {
        set_miv_no();
    }
}