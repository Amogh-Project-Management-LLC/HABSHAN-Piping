using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Erection_SiteMIVCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Site MIV - Create");
            txtMIVDate.SelectedDate = System.DateTime.Now;
            txtIssueBy.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void ddlJCSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        try
        {
            string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");
            prefix += "-SITE-MIV-";
            prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID='" + ddlJCSubcon.SelectedValue + "'") + "-";
            txtSiteMIVNo.Text = WebTools.NextSerialNo("PIP_SITE_MIV", "ISSUE_NO", prefix, 4, " WHERE JC_SC_ID='" + ddlJCSubcon.SelectedValue + "'");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsErectionBTableAdapters.VIEW_SITE_MIVTableAdapter miv = new dsErectionBTableAdapters.VIEW_SITE_MIVTableAdapter();
            miv.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtMIVDate.SelectedDate, txtIssueBy.Text, decimal.Parse(cboJCNo.SelectedValue),
                decimal.Parse(ddlJCSubcon.SelectedValue), decimal.Parse(ddlMatSubcon.SelectedValue), txtRemarks.Text, txtSiteMIVNo.Text, decimal.Parse(ddlStoreList.SelectedValue), decimal.Parse(ddlJCType.SelectedValue));
            Master.show_success(txtSiteMIVNo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void txtType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (ddlJCType.SelectedValue == "1")
            cboJCNo.DataSource = sqlJCNoSource;
        else if (ddlJCType.SelectedValue == "2")
            cboJCNo.DataSource = sqlFlangeJCSource;
        cboJCNo.DataBind();
    }
}