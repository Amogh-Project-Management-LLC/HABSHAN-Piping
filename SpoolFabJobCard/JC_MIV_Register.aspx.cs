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
using dsFabricationJCTableAdapters;

public partial class Material_MatReceiveNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnSubmit.Enabled = false;
                txtMIV.Text = "Access Denied!";
                txtMIV.Enabled = false;
                return;
            }
            string user_id = WebTools.GetExpr("USER_ID", "USERS",
                               "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            createdDDL.SelectedValue = user_id;
            Master.HeadingMessage("MIV - New");
            txtIssueDate.SelectedDate = System.DateTime.Today;
        }


       
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_ISSUE_WOTableAdapter miv = new PIP_MAT_ISSUE_WOTableAdapter();
        try
        {
            decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS",
                                 "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'"));


            miv.InsertQuery(txtMIV.Text, decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtIssueDate.SelectedDate,
                user_id,
                decimal.Parse(JCNumber.SelectedValue.ToString()),
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtRemarks.Text,
                decimal.Parse(rcbStore.SelectedValue.ToString())
                );

            Master.show_success(txtMIV.Text + "Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            miv.Dispose();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV.aspx");
    }

    private void set_req_no()
    {
        if (cboSubcon.SelectedValue.ToString() == "-1")
        {
            txtMIV.Text = "";
            return;
        }
        try
        {
            string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID=" + Session["PROJECT_ID"]);
            string prefix = job_code+ "-" + WebTools.GetExpr(
                "SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + cboSubcon.SelectedValue.ToString()) + "-JCMIV-ST-";
            txtMIV.Text = WebTools.NextSerialNo("PIP_MAT_ISSUE_WO", "ISSUE_NO", prefix, 4,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    //protected void cboWO_DataBinding(object sender, EventArgs e)
    //{
    //    cboWO.Items.Clear();
    //    cboWO.Items.Add(new ListItem("(Select)", "-1"));
    //}

    protected void cboWO_SelectedIndexChanged(object sender, EventArgs e)
    {
        //txtMIV.Text = cboWO.SelectedItem.Text;
        set_req_no();
       
    }

    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        JCNumber.Text = "";
        txtMIV.Text = "";
        rcbStore.Text = "";
        rcbStore.Enabled = true;
    }
}