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

public partial class SupportErectionRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Support Status";
            string isome = Request.QueryString["Isome"];
            string filter = Request.QueryString["Filter"];
            if (isome != "")
            {
                txtIsome.Text = isome;
            }
            if (filter != "")
            {
                txtSupp.Text = filter;
            }
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/Supp_Home.aspx");
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
    }
    protected void txtSupp_TextChanged(object sender, EventArgs e)
    {
        txtSupp.Text = txtSupp.Text.Trim().ToUpper();
    }
    protected void btnSaveErec_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the support!");
            return;
        }
        //if (txtErecDate.Text == string.Empty || txtErecReportNo.Text == string.Empty)
        if (txtErecDate.Text == string.Empty)
        {
            Master.ShowWarn("Enter Erection date!");
            return;
        }
        try
        {
            WebTools.ExeSql("UPDATE PIP_BOM SET EREC_DATE='" +
                txtErecDate.Text + "' WHERE BOM_ID=" + rowsGridView.SelectedValue.ToString());

            rowsGridView.DataBind();

            Master.ShowMessage("Erection Date Updated!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}