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
using dsTestPkg_ATableAdapters;

public partial class TestPkg_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Test Package - Register");
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_TPK_MASTERTableAdapter master = new VIEW_ADAPTER_TPK_MASTERTableAdapter();
        try
        {
            master.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtTP_No.Text,
                decimal.Parse(cboSysNo.SelectedValue.ToString()),
                txtTestPress.Text, txtMedium.Text,
                txtService.Text, txtRemarks.Text);
            Master.show_success("Test package created successfully!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}