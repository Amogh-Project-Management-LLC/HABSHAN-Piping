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
using dsMaterialATableAdapters;

public partial class Erection_ErectionRepRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
            Master.HeadingMessage = "Material Return - Register";
            txtRetNumber.Text = "- Select the from store -";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReturn.aspx");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_RETURNTableAdapter ret = new PIP_MAT_RETURNTableAdapter();
        try
        {
            ret.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtRetNumber.Text,
                txtCreateDate.SelectedDate.Value,
                txtRetby.Text,
                decimal.Parse(cboStore1.SelectedValue.ToString()),
                decimal.Parse(cboStore2.SelectedValue.ToString()),
                txtRemarks.Text);

            Master.ShowMessage(txtRetNumber.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
        }
        finally
        {
            ret.Dispose();
        }
    }

    private void set_ret_no()
    {
        if (cboStore1.SelectedValue.ToString() == "-1")
        {
            txtRetNumber.Text = "";
            return;
        }
        try
        {
            string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" + cboStore1.SelectedValue.ToString());
            string short_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + sc_id);
            string prefix = "MAT-RET-" + short_name + "-";
            txtRetNumber.Text = General_Functions.NextSerialNo("PIP_MAT_RETURN", "RETURN_NO", prefix, 3,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND STORE_ID1 IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID=" + sc_id + ")");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void cboStore1_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_ret_no();
    }
}