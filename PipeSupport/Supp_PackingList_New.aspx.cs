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
using dsSupp_ATableAdapters;

public partial class Supp_JobCard_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_INSERT"))
            {
                btnSubmit.Enabled = false;
            }
            Master.HeadingMessage = "Support Packing List";
            set_jc_no();
        }
    }
    private void go_back()
    {
        Response.Redirect("Supp_PackingList.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_SUPP_PACKINGTableAdapter wo = new VIEW_SUPP_PACKINGTableAdapter();
        try
        {
            wo.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtJcNumber.Text,
                txtCreateDate.SelectedDate,
                txtIssuedBy.Text,
                txtRem.Text,
                txtPalletNo.Text,
                txtShipNo.Text);

            Master.ShowMessage("New packing list no saved.");
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
            string prefix = "SUP-PKL-";
            string new_jc = WebTools.NextSerialNo("PIP_SUPP_PACKING", "PACKING_NO", prefix, 3,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());
            txtJcNumber.Text = new_jc;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}