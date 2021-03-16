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
using Microsoft.Reporting.WebForms;
using dsErectionTableAdapters;
using dsErectionATableAdapters;
using dsErectionBTableAdapters;
using dsErectionRepsATableAdapters;
using dsErectionRepsBTableAdapters;
using dsErectionRepsCTableAdapters;
using dsJcReportsTableAdapters;

public partial class Erection_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;

            string Site_jc_name = "";
            String JC_ID;
            ReportID = Request.QueryString["ReportID"];
            JC_ID = Request.QueryString["JC_ID"];


            switch (ReportID)
            {
                case "2":
                case "3":
                case "12":
                    Site_jc_name = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_LOOSE", "JC_ID=" + JC_ID);
                break;
                default:
                    Site_jc_name = "";
                break;
            }
           
            switch (ReportID)
            {
                case "1":
                    VIEW_SITE_JC_SPL_REPTableAdapter rep_1 = new VIEW_SITE_JC_SPL_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Spool_Cleaning.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsA_VIEW_SITE_JC_SPL_REP",
                        (DataTable)rep_1.GetData(decimal.Parse(JC_ID))
                        ));
                    break;
                case "2":
                    VIEW_SITE_JC_MAT_SUMMARYTableAdapter site_miv_summary = new VIEW_SITE_JC_MAT_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.DisplayName = Site_jc_name +"_Mat_MIVR";
                    //ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Summary.rdlc";
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Mat_Required_MIVR.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_MAT_SUMMARY",
                        (DataTable)site_miv_summary.GetData(decimal.Parse(JC_ID))
                        ));
                    break;
                case "3":
                    VIEW_SITE_JC_REP_CTableAdapter site_miv_iso = new VIEW_SITE_JC_REP_CTableAdapter();
                    ReportPreview.LocalReport.DisplayName = Site_jc_name + "_JC_Isometric";
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Isometric.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsB_VIEW_SITE_JC_REP_C",
                        (DataTable)site_miv_iso.GetData(decimal.Parse(JC_ID)
                        )));
                    break;
                case "4":
                    VIEW_SITE_JCTableAdapter rep_4 = new VIEW_SITE_JCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Punch_List.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErection_VIEW_SITE_JC",
                        (DataTable)rep_4.GetDataByJC_ID(decimal.Parse(JC_ID))
                        ));
                    break;
                case "5":
                    VIEW_SITE_JCTableAdapter rep_5 = new VIEW_SITE_JCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Remaining_Work.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErection_VIEW_SITE_JC",
                        (DataTable)rep_5.GetDataByJC_ID(decimal.Parse(JC_ID))
                        ));
                    break;
                case "6":
                    VIEW_SITE_JC_TRANSTableAdapter site_miv_trans = new VIEW_SITE_JC_TRANSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Transmittal.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsB_VIEW_SITE_JC_TRANS",
                        (DataTable)site_miv_trans.GetData(decimal.Parse(JC_ID))));
                    break;
                case "7":
                    VIEW_SITE_JC_WELD_REPTableAdapter rep_7 = new VIEW_SITE_JC_WELD_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_WeldingReport.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsA_VIEW_SITE_JC_WELD_REP",
                        (DataTable)rep_7.GetData(decimal.Parse(JC_ID))
                        ));
                    break;
                case "10":
                    VIEW_JC_SPL_FABTableAdapter rep_10 = new VIEW_JC_SPL_FABTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_SpoolList.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_SPL_FAB",
                        (DataTable)rep_10.GetData(decimal.Parse(JC_ID))
                        ));
                    break;
                case "11":
                    VIEW_SITE_JC_REP_ETableAdapter site_miv_fabsupp = new VIEW_SITE_JC_REP_ETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_FieldSupport.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsA_VIEW_SITE_JC_REP_E",
                        (DataTable)site_miv_fabsupp.GetData(decimal.Parse(JC_ID))
                        ));
                    break;
                case "12":
                    VIEW_SITE_JC_REP_FTableAdapter rep_12 = new VIEW_SITE_JC_REP_FTableAdapter();
                    ReportPreview.LocalReport.DisplayName = Site_jc_name + "_Field_JC";
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Combined.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsA_VIEW_SITE_JC_REP_F",
                        (DataTable)rep_12.GetData(decimal.Parse(JC_ID)
                        )));
                    break;
                case "13":
                    VIEW_SITE_JC_REP_GTableAdapter rep_13 = new VIEW_SITE_JC_REP_GTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Installation.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsA_VIEW_SITE_JC_REP_G",
                        (DataTable)rep_13.GetData(decimal.Parse(JC_ID)
                        )));
                    break;
                case "14":
                    VIEW_SITE_JC_SHORTAGETableAdapter rep_14 = new VIEW_SITE_JC_SHORTAGETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Shortage.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsC_VIEW_SITE_JC_SHORTAGE",
                        (DataTable)rep_14.GetData(decimal.Parse(JC_ID)
                        )));
                    break;
                case "100":
                    VIEW_SITE_JC_AVAILTableAdapter rep_100 = new VIEW_SITE_JC_AVAILTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Field_JC_Avail.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsC_VIEW_SITE_JC_AVAIL",
                        (DataTable)rep_100.GetData(decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "15":
                    VIEW_SITE_REM_WORK_REPTableAdapter rep_15 = new VIEW_SITE_REM_WORK_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\Remaining_Work_Report.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsC_VIEW_SITE_REM_WORK_REP",
                        (DataTable)rep_15.GetData(
                        decimal.Parse(JC_ID)
                        )));
                    break;

                case "16":
                    VIEW_BOM_REQUEST_REPTableAdapter rep_16 = new VIEW_BOM_REQUEST_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\BomRequest.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionA_VIEW_BOM_REQUEST_REP",
                        (DataTable)rep_16.GetData(
                        decimal.Parse(Request.QueryString["REQ_ID"])
                        )));
                    break;

                case "17":
                    VIEW_BOM_RECV_REPTableAdapter rep_17 = new VIEW_BOM_RECV_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\BomReceive.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionB_VIEW_BOM_RECV_REP",
                        (DataTable)rep_17.GetData(
                        decimal.Parse(Request.QueryString["RECV_ID"])
                        )));
                    break;

                case "18":
                    string site_miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_LOOSE", "JC_ID=" + Request.QueryString["SITE_MIV_ID"].ToString());
                    VIEW_SITE_MIV_ISSUE_DETAILTableAdapter site_miv = new VIEW_SITE_MIV_ISSUE_DETAILTableAdapter();
                    ReportPreview.LocalReport.DisplayName = site_miv_no + " Site MIV Report";
                    ReportPreview.LocalReport.ReportPath = "Erection\\Reports\\SiteMIVReport.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsErectionRepsC_VIEW_SITE_MIV_ISSUE_DETAIL",
                        (DataTable)site_miv.GetData(decimal.Parse(Request.QueryString["SITE_MIV_ID"]))));
                    break;


                     case "20":
                    ReportPreview.ProcessingMode = ProcessingMode.Local;
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\Site_Joints_jobcard.rdlc";
                    string query = "SELECT * from VIEW_SITE_JNTS_JC_RDLC WHERE JC_ID=" + decimal.Parse(Request.QueryString["JC_ID"]);
                    DataTable table1 = General_Functions.GetDataTable(query);
                    ReportDataSource datasource = new ReportDataSource("VIEW_SITE_JNTS_JC_RDLC", table1);
                    ReportPreview.LocalReport.DataSources.Clear();
                    ReportPreview.LocalReport.DataSources.Add(datasource);
                    break;

            }
        }
    }
}