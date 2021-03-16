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

public partial class BasicReports_NDE_Status : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "NDE Status";
        }
    }
    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        string conn_as = Session["CONNECT_AS"].ToString();
        if (conn_as != "99")
        {
            for (int i = 0; i <= cboSubcon.Items.Count; i++)
            {
                if (cboSubcon.Items[i].Value.ToString() == conn_as)
                {
                    cboSubcon.SelectedIndex = i;
                    break;
                }
            }
            cboSubcon.Enabled = false;
            rblCat.Enabled = false;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
    protected void btnArea_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "8"; }
        else
        { report_id = "9"; }
        show_report(report_id);
    }

    private void show_report(string report_id)
    {
        Response.Redirect("ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            cboSubcon.SelectedValue.ToString());
    }
    protected void rblCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            cboSubcon.Items.Clear();
            cboSubcon.Items.Add(new ListItem("-Select-", "99"));
        }
    }
    protected void btnPMI_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "6"; }
        else
        { report_id = "7"; }
        show_report(report_id);
    }
    protected void btnPT_MT_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "25"; }
        else
        { report_id = "26"; }
        show_report(report_id);
    }
    protected void btnRT_UT_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "27"; }
        else
        { report_id = "28"; }
        show_report(report_id);
    }
    protected void btnPWHT_Area_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "13"; }
        else
        { report_id = "13.1"; }
        show_report(report_id);
    }
    protected void btnHT_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "30"; }
        else
        { report_id = "31"; }
        show_report(report_id);
    }
    protected void btnFT_Click(object sender, EventArgs e)
    {
        string report_id = "";
        if (rblCat.SelectedValue.ToString() == "1")
        { report_id = "32"; }
        else
        { report_id = "33"; }
        show_report(report_id);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
      if(ddlNDEType.SelectedValue=="99")
        {
            Master.ShowError("Select NDE Type!");
            return;
        }
      if(cboSubcon.SelectedValue=="99")
        {
            Master.ShowError("Select subcon!");
            return;
        }
        int nde_type_id = int.Parse(ddlNDEType.SelectedValue);
        switch(nde_type_id)
        {
            //rt
            case 1:
                if(radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 27 + "&Arg1=" +cboSubcon.SelectedValue.ToString()+ "&Arg2="+ rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 27.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
            //pt/mt
            case 3:
                if(radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 25 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 25.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
            //pwht
            case 7:
                if(radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 13 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 13.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
            //HT
            case 8:
                if (radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 30 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 30.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
            //PMI
            case 9:
                if (radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 6 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 6.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
            //FT
            case 10:
                if (radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 32 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 32.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
            //UT
            case 12:
                if (radReportType.SelectedValue == "1")
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 29 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                else
                    Response.Redirect("ReportViewer.aspx?ReportID=" + 29.1 + "&Arg1=" + cboSubcon.SelectedValue.ToString() + "&Arg2=" + rblCat.SelectedValue.ToString());
                break;
        }
    }
}