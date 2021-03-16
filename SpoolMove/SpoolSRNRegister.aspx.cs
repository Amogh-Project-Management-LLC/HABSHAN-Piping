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
using dsSpoolMoveTableAdapters;

public partial class SpoolMove_SpoolSRNRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string cat_id = Request.QueryString["CAT_ID"];
            string prefix = WebTools.GetExpr("SER_PREFIX", "PIP_SPOOL_TRANS_CAT", " WHERE CAT_ID=" + cat_id);
            string trans = WebTools.GetExpr("TRANS_CAT", "PIP_SPOOL_TRANS_CAT", " WHERE CAT_ID=" + cat_id);
            Master.HeadingMessage ( trans);
            txtTransNo.Text = "-Select the subcon-";
            txtUserName.Text = Session["USER_NAME"].ToString();
            txtTransDate.SelectedDate = System.DateTime.Today;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_SPL_TRANSTableAdapter spl_trans = new VIEW_ADAPTER_SPL_TRANSTableAdapter();
        try
        {
            spl_trans.InsertSRN(txtTransNo.Text,
                txtTransDate.SelectedDate,
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(Request.QueryString["CAT_ID"]),
                Decimal.Parse(cboSubcon.SelectedValue),
                txtShipNo.Text,
                txtRemarks.Text,
                txtArea.Text,
                txtDelLocation.Text,
                txtUserName.Text,
                etaDatePicker.SelectedDate);

            Master.show_success(txtTransNo.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            spl_trans.Dispose();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolSRN.aspx?CAT_ID=" + Request.QueryString["CAT_ID"]);
    }
    private void set_req_no()
    {
        try
        {
            string cat_id = Request.QueryString["CAT_ID"];

            string prefix = WebTools.GetExpr("SER_PREFIX", "PIP_SPOOL_TRANS_CAT", "CAT_ID=" + cat_id);

            string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR",
                "SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());

            string new_trans = General_Functions.NextSerialNo("PIP_SPOOL_TRANS", "SER_NO", prefix + sc_name + "-", 4,
                    " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                    " AND CAT_ID=" + cat_id + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
            txtTransNo.Text = new_trans;
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }
    protected void ddDelLoc_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtDelLocation.Text = ddDelLoc.SelectedItem.Text;
    }
}