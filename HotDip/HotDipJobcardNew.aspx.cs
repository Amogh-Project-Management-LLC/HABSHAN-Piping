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
using dsHotDipTableAdapters;

public partial class HotDip_HotDipJobcardNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Hot Dip";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_HOT_DIP_JOBCARDTableAdapter issue = new VIEW_HOT_DIP_JOBCARDTableAdapter();
        try
        {
            issue.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtIssueNumber.Text,
                txtCreateDate.SelectedDate,
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtRemarks.Text);
            Master.ShowMessage(txtIssueNumber.Text + " Saved!");
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
        Response.Redirect("HotDipJobcard.aspx");
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cboSubcon.SelectedValue.ToString() == "-1") return;
    }
    private void set_jc_no()
    {
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());

        string prefix = "HOT-DIP-" + sc_name + "-";

        txtIssueNumber.Text = General_Functions.NextSerialNo(
            "HOT_DIP_JOBCARD", "JC_NO", prefix,
            4,
            " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
    }
    protected void btnAutoNum_Click(object sender, EventArgs e)
    {
        set_jc_no();
    }
}