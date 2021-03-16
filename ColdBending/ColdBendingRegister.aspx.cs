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
using dsCoolBendingTableAdapters;

public partial class ColdBending_ColdBendingRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Cold Bending";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_COOL_BENDING_JCTableAdapter issue = new VIEW_COOL_BENDING_JCTableAdapter();
        try
        {
            issue.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtIssueNumber.Text,
                txtCreateDate.SelectedDate,
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtRemarks.Text);
            Master.ShowMessage("Jobcard created successfully.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ColdBending.aspx");
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cboSubcon.SelectedValue.ToString() == "-1") return;
    }
    private void set_paint_no()
    {
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
            cboSubcon.SelectedValue.ToString());
        string prefix = "JC-" + sc_name + "-COLD-";
        txtIssueNumber.Text = General_Functions.NextSerialNo(
            "COOL_BENDING_JC", "JC_NO", prefix,
            4, " WHERE PROJ_ID=" + Session["PROJECT_ID"].ToString() +
            " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
    }
    protected void txtAutoNum_Click(object sender, EventArgs e)
    {
        set_paint_no();
    }
}