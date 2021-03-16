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
using dsSupp_BTableAdapters;

public partial class PipeSupport_SuppRequestNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_INSERT"))
            {
                btnSubmit.Enabled = false;
            }
            Master.HeadingMessage = "Support Request";
            set_jc_no();
        }
    }
    private void go_back()
    {
        Response.Redirect("SuppRequest.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_SUPP_REQUESTTableAdapter wo = new VIEW_SUPP_REQUESTTableAdapter();
        try
        {
            wo.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtJcNumber.Text,
                DateTime.Parse(txtIssueDate.Text),
                txtRem.Text);
            Master.ShowMessage("Support Request saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            wo.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        go_back();
    }
    private void set_jc_no()
    {
        try
        {
            string projrct_id = Session["PROJECT_ID"].ToString();
            string prefix = "SUP-REQ-";
            string new_jc = WebTools.NextSerialNo("PIP_SUPP_REQUEST", "REQ_NO", prefix, 4,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());
            txtJcNumber.Text = new_jc;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}