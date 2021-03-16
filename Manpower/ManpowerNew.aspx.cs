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
using dsManpowerTableAdapters;

public partial class Manpower_ManpowerNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New Manpwer");

            if (!WebTools.UserInRole("MANPOWER_UPDATE"))
            {
                btnSubmit.Enabled = false;
                cboSubcon.Enabled = false;
                txtEmpCode.Enabled = false;
                return;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_MANPOWER_MASTERTableAdapter manpower = new VIEW_MANPOWER_MASTERTableAdapter();
        try
        {
            manpower.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtEmpCode.Text,
                txtEmpName.Text,
                Decimal.Parse(ddCategory.SelectedValue.ToString()),
                Decimal.Parse(cboSubcon.SelectedValue.ToString())
                );

            Master.show_success(txtEmpCode.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            manpower.Dispose();
        }
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void cboSubcon_DataBinding(object sender, EventArgs e)
    {
        cboSubcon.Items.Clear();
        cboSubcon.Items.Add(new ListItem("<Subcon>", "-1"));
    }
}