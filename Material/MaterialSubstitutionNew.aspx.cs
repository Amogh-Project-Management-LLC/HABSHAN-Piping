using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialSubstitutionNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("CREATE MATERIAL SUBSTITUTION REQUEST");
            txtReqDate.SelectedDate = DateTime.Today;
            txtCreateBy.Text = Session["USER_NAME"].ToString();
            RequestNo();
        }
    }
    
    protected void ddlSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        prefix += "-SUBS-";

        txtReqNo.Text = WebTools.NextSerialNo("PIP_MAT_SUBSTITUTE", "REQ_NO", prefix + "-", 4, " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsMaterialCTableAdapters.VIEW_MAT_SUBSTITUTETableAdapter subs = new dsMaterialCTableAdapters.VIEW_MAT_SUBSTITUTETableAdapter();
            subs.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtReqNo.Text, txtReqDate.SelectedDate, txtCreateBy.Text);
            Master.show_success(txtReqNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void RequestNo()
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        prefix += "-MAT-SUBS-";

        txtReqNo.Text = WebTools.NextSerialNo("PIP_MAT_SUBSTITUTE", "REQ_NO", prefix, 4, " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
    }
}