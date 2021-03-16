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
using dsHydroTestTableAdapters;

public partial class HydroTest_HydroTestNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIP_WIC_INSERT"))
            {
                btnSubmit.Enabled = false;
            }

            string user_id = WebTools.GetExpr("USER_ID", "USERS",
                             "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            createdDDL.SelectedValue = user_id;
            Master.HeadingMessage("Hydro Test");
        }
    }
    private void redirect_back()
    {
        Response.Redirect("HydroTest.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_HYDRO_TESTTableAdapter hydro_test = new VIEW_HYDRO_TESTTableAdapter();
        try
        {
            hydro_test.InsertQuery(Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtTestNo.Text,
                txtIssueDate.SelectedDate,
                Decimal.Parse(cboSubcon.SelectedValue),
                txtRemarks.Text,
                txtTestPress.Text, txtTestMed.Text, txtHoldingTime.Text,decimal.Parse(createdDDL.SelectedValue.ToString()));

            Master.show_success(txtTestNo.Text + " Saved.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            hydro_test.Dispose();
        }
    }
  
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }
    private void set_req_no()
    {
        //string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
        //    cboSubcon.SelectedValue.ToString());
        //try
        //{
        //    txtJntPaintNo.Text = General_Functions.NextSerialNo("PIP_HYDRO_TEST", "TEST_NO", "HYDRO-" + sc_name + "-", 4,
        //        " WHERE PROJECT_ID=" + Session["PROJECT_ID"] + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
        //}
        //catch (Exception ex)
        //{
        //    Master.ShowWarn(ex.Message);
        //}

   
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", "SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());
        string short_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID = '" + Session["PROJECT_ID"] + "'");
        string prefix = short_code + "-" + sc_name + "-"+ "HYDRO-ST-";
        txtTestNo.Text = WebTools.NextSerialNo("PIP_HYDRO_TEST", "TEST_NO", prefix, 4, " WHERE  sc_id=" + cboSubcon.SelectedValue.ToString());
    }
}