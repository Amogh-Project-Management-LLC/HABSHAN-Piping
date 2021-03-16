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
using dsSupp_DTableAdapters;

public partial class PipeSupport_Supp_SWN_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_INSERT"))
            {
                btnSubmit.Enabled = false;
            }
            Master.HeadingMessage = "Support SWN - Register";
            set_jc_no();
        }
    }
    private void go_back()
    {
        Response.Redirect("Supp_SWN.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_SUPP_SWNTableAdapter wo = new VIEW_SUPP_SWNTableAdapter();
        try
        {
            wo.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtJcNumber.Text,
                DateTime.Parse(txtIssueDate.Text),
                decimal.Parse(cboSubcon.SelectedValue),
                txtRem.Text,
                decimal.Parse(cboShop.SelectedValue.ToString()));

            Response.Redirect("Supp_SWN.aspx");

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
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        //set_jc_no();
    }
    private void set_jc_no()
    {
        try
        {
            string projrct_id = Session["PROJECT_ID"].ToString();
            string prefix = "SWN-SUP-";
            string new_jc = WebTools.NextSerialNo("PIP_SUPP_SWN", "SWN_NO", prefix, 4,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());
            txtJcNumber.Text = new_jc;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}