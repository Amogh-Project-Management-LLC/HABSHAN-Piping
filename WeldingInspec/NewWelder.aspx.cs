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

using dsWeldersTableAdapters;

public partial class WeldingInspec_NewWelder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New Welder");
            txtJoinDate.SelectedDate = DateTime.Now;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_WELDERSTableAdapter adapter = new PIP_WELDERSTableAdapter();
        try
        {
            adapter.InsertWelder(txtCode.Text, txtName.Text, Decimal.Parse(cboSubcon.SelectedValue),
                txtJoinDate.SelectedDate,
                decimal.Parse(Session["PROJECT_ID"].ToString()));

            Master.show_success(txtName.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            adapter.Dispose();
        }
    }
}