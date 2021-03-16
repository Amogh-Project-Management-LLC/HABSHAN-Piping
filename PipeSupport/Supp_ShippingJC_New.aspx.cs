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
using dsSupp_GTableAdapters;

public partial class Supp_ShippingJC_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_INSERT"))
            {
                btnSubmit.Enabled = false;
            }
            Master.HeadingMessage = "Support Shipping Jobcard";
            set_jc_no();
        }
    }
    private void go_back()
    {
        Response.Redirect("Supp_ShippingJC.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_SUPP_SHIP_JCTableAdapter shipping_jc = new VIEW_SUPP_SHIP_JCTableAdapter();
        try
        {
            shipping_jc.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtJcNumber.Text,
                txtCreateDate.SelectedDate,
                txtRem.Text,
                txtPalletNo.Text,
                txtShipNo.Text);

            Master.ShowMessage("New Shipping Jobcard no saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            shipping_jc.Dispose();
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
            string prefix = "SUP-SHP-";
            string new_jc = WebTools.NextSerialNo("PIP_SUPP_SHIP_JC", "SHIP_JC_NO", prefix, 4,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());
            txtJcNumber.Text = new_jc;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}