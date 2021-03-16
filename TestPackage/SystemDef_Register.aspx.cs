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

public partial class SystemDef_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("System - Register");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        TPK_SYSTEM_DEFINITIONTableAdapter sys = new TPK_SYSTEM_DEFINITIONTableAdapter();
        try
        {
            sys.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtSys.Text,
                txtSubSys.Text,
                txtDesc.Text,
                txtSubSysDesc.Text,
                txtRem.Text);
            Master.show_success("New system created successfully!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            sys.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SystemDef.aspx");
    }
}