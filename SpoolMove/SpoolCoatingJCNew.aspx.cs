using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolCoatingJCNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New Spool Coating Job Card");
            txtIssueDate.SelectedDate = System.DateTime.Today;
            txtTargetDate.SelectedDate = System.DateTime.Today.AddDays(7);
        }
    }

    protected void ddlCoatingVendor_DataBinding(object sender, EventArgs e)
    {
        ddlCoatingVendor.Items.Clear();
        ddlCoatingVendor.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlCoatingType_DataBinding(object sender, EventArgs e)
    {
        ddlCoatingType.Items.Clear();
        ddlCoatingType.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlCoatingVendor_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (ddlFromSubcon.SelectedIndex > 0 && ddlCoatingVendor.SelectedIndex > 0)
            SerialNo();
        else
            txtJCNo.Text = "";
    }

    protected void SerialNo()
    {
        string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        string short_code = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID='" + ddlCoatingVendor.SelectedValue + "'");
        string prefix = job_code + "-" + short_code + "-COAT-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID='" + ddlFromSubcon.SelectedValue + "'");
        prefix += "-";
        txtJCNo.Text = WebTools.NextSerialNo("PIP_COATING_JC", "COAT_JC_NO", prefix, 4, " WHERE SC_ID = '" + ddlCoatingVendor.SelectedValue + "' AND FROM_SC = '" + ddlFromSubcon.SelectedValue + "'");

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsGalvJobcardTableAdapters.VIEW_ADAPTER_COATING_JCTableAdapter jc = new dsGalvJobcardTableAdapters.VIEW_ADAPTER_COATING_JCTableAdapter();
        try
        {
            jc.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtJCNo.Text, txtIssueDate.SelectedDate, decimal.Parse(ddlCoatingVendor.SelectedValue),
                 decimal.Parse(ddlCoatingType.SelectedValue), txtRemarks.Text, Session["USER_NAME"].ToString(), decimal.Parse(ddlFromSubcon.SelectedValue),
                 txtTargetDate.SelectedDate, ddlCoatingCat.SelectedValue);
            Master.show_success(txtJCNo.Text + " Job Card Created.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            jc.Dispose();
        }
    }

    protected void ddlFromSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlFromSubcon.Items.Clear();
        ddlFromSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlFromSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (ddlFromSubcon.SelectedIndex > 0 && ddlCoatingVendor.SelectedIndex > 0)
            SerialNo();
        else
            txtJCNo.Text = "";
    }
}