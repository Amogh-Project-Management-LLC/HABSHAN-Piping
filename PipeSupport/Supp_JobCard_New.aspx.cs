using dsSupp_BTableAdapters;
using System;

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
            Master.HeadingMessage = "Support Job Card - New";
        }
    }

    private void go_back()
    {
        Response.Redirect("Supp_JobCard.aspx?Filter=" + Request.QueryString["Filter"]);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADP_SUPP_JCTableAdapter wo = new VIEW_ADP_SUPP_JCTableAdapter();
        try
        {
            wo.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtJcNumber.Text,
                txtIssueDate.SelectedDate,
                Decimal.Parse(cboSubcon.SelectedValue),
                ddMaterialType.SelectedItem.Text,
                txtTargetCmplt.SelectedDate,
                txtPaintCode.Text,
                txtRem.Text,
                decimal.Parse(cboShop.SelectedValue.ToString())
                );

            Master.ShowMessage(txtJcNumber.Text + " Saved!");
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

            //string prefix = String.Format("PS-{0}-", ddMaterialType.SelectedValue.ToString());
            string prefix = "PS-";

            string new_jc = WebTools.NextSerialNo("PIP_SUPP_JC", "JC_NO", prefix, 4, " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());

            txtJcNumber.Text = new_jc;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void ddMaterialType_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_jc_no();
    }
}