using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;


public partial class Home_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        decimal report_code = WebTools.DMax("REPORT_CODE", "CUSTOM_REPORT_INDEX", " WHERE 1=1");
        txtReportCode.Text = (report_code + 1).ToString();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string query = "INSERT INTO CUSTOM_REPORT_INDEX(REPORT_CODE,REPORT_NAME,REPORT_GROUP,CREATED_BY,EXPT_ID) VALUES('" + txtReportCode.Text + "','" + txtReportName.Text + "','" + txtReportGroup.Text + "','" + Session["USER_NAME"] + "',"+int.Parse(rcbReportsrc.SelectedValue)+")";
            WebTools.ExeSql(query);
            Master.ShowSuccess("Report Created, Proceed to Configure");
            Response.Redirect("CustomReport.aspx?report_code=" + txtReportCode.Text);
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnConfigure_Click(object sender, EventArgs e)
    {
       
    }
}