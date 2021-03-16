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
using dsIsomeReportsATableAdapters;

public partial class BasicReports_SelectSubconArea : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Select Subcon/Area";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Report_List.aspx");
    }
   
    protected void ddlSubCon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string ReportID = Request.QueryString["ReportID"];
        ReportPreview.LocalReport.ReportPath = null;
        ReportPreview.LocalReport.DataSources.Clear(); 
        string selectedSubcon = ddlSubCon.SelectedValue;


        switch (ReportID)
        {
            case "212":

                VIEW_DPR_MILESTONETableAdapter dpr_milestone = new VIEW_DPR_MILESTONETableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                  "dsIsomeReportsA_VIEW_DPR_MILESTONE",
                (DataTable)dpr_milestone.GetData()));

                VIEW_ISOMETRIC_INDEX_DPRTableAdapter iso_index = new VIEW_ISOMETRIC_INDEX_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                  "dsIsomeReportsA_VIEW_ISOMETRIC_INDEX_DPR",
                (DataTable)iso_index.GetData(selectedSubcon)));

                VIEW_SPOOLGEN_TRANS_DPRTableAdapter trans_spl = new VIEW_SPOOLGEN_TRANS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                  "dsIsomeReportsA_VIEW_SPOOLGEN_TRANS_DPR",
                  (DataTable)trans_spl.GetData(selectedSubcon)));

                VIEW_SPOOLGEN_PROGRESS_DPRTableAdapter spl_prog = new VIEW_SPOOLGEN_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                  "dsIsomeReportsA_VIEW_SPOOLGEN_PROGRESS_DPR",
                  (DataTable)spl_prog.GetData(selectedSubcon)));

                VIEW_JOBCARD_PROGRESS_DPRTableAdapter job_prog = new VIEW_JOBCARD_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_JOBCARD_PROGRESS_DPR",
                    (DataTable)job_prog.GetData(selectedSubcon)));

                VIEW_FITUP_PROGRESS_DPRTableAdapter fitup_prog = new VIEW_FITUP_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_FITUP_PROGRESS_DPR",
                    (DataTable)fitup_prog.GetData(selectedSubcon)));

                VIEW_NDE_PROGRESS_DPRTableAdapter nde_prog = new VIEW_NDE_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_NDE_PROGRESS_DPR",
                    (DataTable)nde_prog.GetData(selectedSubcon)));

                VIEW_PAINT_PROGRESS_DPRTableAdapter pnt_req_prog = new VIEW_PAINT_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_PAINT_PROGRESS_DPR",
                    (DataTable)pnt_req_prog.GetData(selectedSubcon)));

                VIEW_PAINT_PROGRESS_DPRTableAdapter pnt_prog = new VIEW_PAINT_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_PAINT_PROGRESS_DPR",
                    (DataTable)pnt_prog.GetData(selectedSubcon)));
                VIEW_TRANSF_PROGRESS_DPRTableAdapter before_irn_prog = new VIEW_TRANSF_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_TRANSF_PROGRESS_DPR",
                    (DataTable)before_irn_prog.GetData(selectedSubcon)));
                VIEW_TRANSF_PROGRESS_DPRTableAdapter after_irn_prog = new VIEW_TRANSF_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_TRANSF_PROGRESS_DPR",
                    (DataTable)after_irn_prog.GetData(selectedSubcon)));
                VIEW_TRANSF_PROGRESS_DPRTableAdapter srn_prog = new VIEW_TRANSF_PROGRESS_DPRTableAdapter();
                ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsIsomeReportsA_VIEW_TRANSF_PROGRESS_DPR",
                    (DataTable)srn_prog.GetData(selectedSubcon)));
                break;
        }
    }
}