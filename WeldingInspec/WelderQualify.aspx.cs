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

public partial class WeldingInspec_WelderQualification : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtQualifyDate.SelectedDate = System.DateTime.Today;
            Master.HeadingMessage = "Welders Qualification";
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!EntryTable.Visible)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("WelderRegistration.aspx");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_WELDER_QUALIFYTableAdapter qualify = new PIP_WELDER_QUALIFYTableAdapter();
        try
        {
            qualify.InsertQuery(Decimal.Parse(Request.QueryString["WELDER_ID"].ToString()),
                txtWQT.Text, cboWps.SelectedValue.ToString(), txtMatType.Text, txtProcess.Text,
                Decimal.Parse(txtSizeFrom.Text), Decimal.Parse(txtSizeTo.Text),
                Decimal.Parse(txtThkFrom.Text), Decimal.Parse(txtThkTo.Text),
                DateTime.Parse(txtQualifyDate.SelectedDate.Value.ToString("dd-MMM-yyyy")), txtQualifyPos.Text,
                "");
            qualifyGridView.DataBind();
            Master.ShowMessage(txtWQT.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            qualify.Dispose();
        }
    }
}