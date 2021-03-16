using dsCuttingPlanTableAdapters;
using dsJcReports_ATableAdapters;
using dsJcReportsTableAdapters;
using Microsoft.Reporting.WebForms;
using System;
using System.Data;

public partial class Material_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;

            string Arg1, Arg2;
            string wo_name = "";
            string issue_no = "", jc_miv_no="";

            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            Arg2 = Request.QueryString["Arg2"];
            Master.HeadingMessage = "Preview Report";

            switch (ReportID)
            {
                case "1":
                case "2":
                case "3":
                case "5":
                case "6":
                case "7":
                case "8":
                case "10":
                case "21":
                    wo_name = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", "WO_ID=" + Arg1);
                    break;

                case "15":
                case "15.1":
                case "16":
                case "17":
                case "17.1":
                case "18":
                case "19":
                case "20":
                    issue_no = WebTools.GetExpr("WO_NAME", "VIEW_JC_MIV", "ISSUE_ID=" + Arg1);
                    jc_miv_no = WebTools.GetExpr("ISSUE_NO", "VIEW_JC_MIV", "ISSUE_ID=" + Arg1);
                    break;

                default:
                    wo_name = "";
                    break;
            }

            switch (ReportID)
            {
                case "1":
                case "1.1":
                case "1.2":
                    string mat_group = "XXX";

                    if (ReportID == "1.1")
                        mat_group = "PIPE";
                    else if (ReportID == "1.2")
                        mat_group = "FITTING";

                    VIEW_JC_MAT_SUMMARYTableAdapter rep_1_1 = new VIEW_JC_MAT_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.DisplayName = wo_name + " Material Summary";
                    //ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMat_Summary.rdlc";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMat_Required_MIVR.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_MAT_SUMMARY",
                        (DataTable)rep_1_1.GetData(decimal.Parse(Arg1), mat_group)));
                    break;

                case "2":
                case "3":
                    VIEW_JC_SPL_FABTableAdapter jc = new VIEW_JC_SPL_FABTableAdapter();
                    ReportPreview.LocalReport.DisplayName = wo_name + " Spool List";
                    if (ReportID == "2")
                    {
                        ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcSpoolList_Fab.rdlc";
                    }
                    else // paint
                    {
                        ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcSpoolList_Paint.rdlc";
                    }

                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_SPL_FAB",
                        (DataTable)jc.GetData(Decimal.Parse(Arg1))));
                    break;

                case "5":
                    VIEW_JC_SPL_MATTableAdapter jc_spl_mat = new VIEW_JC_SPL_MATTableAdapter();
                    ReportPreview.LocalReport.DisplayName = wo_name + " Spool Materials";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMat_Spool.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_SPL_MAT",
                        (DataTable)jc_spl_mat.GetData(Decimal.Parse(Arg1))));
                    break;

                case "5.1":
                    VIEW_JC_SPL_MAT_PIPETableAdapter jc_spl_mat_pipe = new VIEW_JC_SPL_MAT_PIPETableAdapter();
                    ReportPreview.LocalReport.DisplayName = wo_name + " Spool pipe cut list";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMat_Spool_Pipe.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_SPL_MAT_PIPE",
                        (DataTable)jc_spl_mat_pipe.GetData(Decimal.Parse(Arg1))));
                    break;

                case "6":
                    VIEW_WORK_ORD_PLATE_REPTableAdapter rep_6 = new VIEW_WORK_ORD_PLATE_REPTableAdapter();
                    ReportPreview.LocalReport.DisplayName = wo_name + " Plate";
                    ReportPreview.LocalReport.ReportPath = @"SpoolFabJobCard\Reports\JcMat_Plate.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_A_VIEW_WORK_ORD_PLATE_REP",
                        (DataTable)rep_6.GetData(
                        Decimal.Parse(Arg1)
                        )));
                    break;

                // new
                case "7":
                    VIEW_JC_WELD_REPTableAdapter rep_7 = new VIEW_JC_WELD_REPTableAdapter();
                    ReportPreview.LocalReport.DisplayName = wo_name + " Welding";
                    ReportPreview.LocalReport.ReportPath = @"SpoolFabJobCard\Reports\JcWelding.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_7.GetData(
                        decimal.Parse(Arg1)
                        )));
                    break;

                case "15":
                    VIEW_CUTLEN_REP_MAINTableAdapter cutlen_main = new VIEW_CUTLEN_REP_MAINTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " Cutting Plan Report";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\CuttingPlan_Main.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)cutlen_main.GetData(Decimal.Parse(Arg1))));
                    break;

                case "16":
                    VIEW_JC_MIV_ISSUE_SUMMARY_REPTableAdapter jc_miv = new VIEW_JC_MIV_ISSUE_SUMMARY_REPTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " Jobcard MIV Summary";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMIV_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_MIV_ISSUE_SUMMARY_REP",
                        (DataTable)jc_miv.GetData(decimal.Parse(Arg1))));
                    break;

                case "16.1":
                    VIEW_JC_MIV_ISSUE_SUMMARY_REPTableAdapter jc_miv_rev = new VIEW_JC_MIV_ISSUE_SUMMARY_REPTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " Jobcard MIV Summary";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMIV_Summary_Rev.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_MIV_ISSUE_SUMMARY_REP",
                        (DataTable)jc_miv_rev.GetDataByRev(decimal.Parse(Arg1), decimal.Parse(Arg2))));
                    break;

                case "17":
                    VIEW_JC_MIV_SPOOLTableAdapter jc_miv_spool = new VIEW_JC_MIV_SPOOLTableAdapter();
                    
                    ReportPreview.LocalReport.DisplayName = issue_no + jc_miv_no + " Jobcard MIV Spools";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMIV_Spool.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_MIV_SPOOL",
                        (DataTable)jc_miv_spool.GetData(decimal.Parse(Arg1))));
                    break;

                case "18":
                    VIEW_JC_MIV_REQUIREDTableAdapter jc_miv_req = new VIEW_JC_MIV_REQUIREDTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + jc_miv_no + " Jobcard MIV Required Qty";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMIV_Required.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JC_MIV_REQUIRED",
                        (DataTable)jc_miv_req.GetData(decimal.Parse(Arg1))));
                    break;

                case "19":
                    VIEW_CUTLEN_REP_MAIN_BTableAdapter cutlen_rem = new VIEW_CUTLEN_REP_MAIN_BTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " Cutting Plan Use Remains";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\CuttingPlan_UseRemain.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)cutlen_rem.GetData(Decimal.Parse(Arg1))));
                    break;

                case "20":
                    VIEW_CUTLEN_REP_REMAINSTableAdapter cutlen_rems = new VIEW_CUTLEN_REP_REMAINSTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " Cutting Plan Remains";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\CuttingPlan_RemOut.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)cutlen_rems.GetData(Decimal.Parse(Arg1))));
                    break;


                case "21":
                    VIEW_JCMIV_SPL_MAT_PIPETableAdapter jcmiv_spl_mat_pipe = new VIEW_JCMIV_SPL_MAT_PIPETableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " Spool pipe cut list";
                    ReportPreview.LocalReport.ReportPath = "SpoolFabJobCard\\Reports\\JcMIVMat_Spool_Pipe.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_JCMIV_SPL_MAT_PIPE",
                        (DataTable)jcmiv_spl_mat_pipe.GetData(Decimal.Parse(Arg1))));
                    break;

                case "22":
                    VIEW_JCMIV_WELD_REPTableAdapter rep_miv_weld = new VIEW_JCMIV_WELD_REPTableAdapter();
                    ReportPreview.LocalReport.DisplayName = issue_no + " MIV Welding";
                    ReportPreview.LocalReport.ReportPath = @"SpoolFabJobCard\Reports\JcMIVWelding.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_miv_weld.GetData(
                        decimal.Parse(Arg1)
                        )));
                    break;
            }
        }
    }

    protected void ReportPreview_SubreportProcessing(object sender, SubreportProcessingEventArgs e)
    {
        string ReportID = Request.QueryString["ReportID"];
        switch (ReportID)
        {
            case "15":
            case "19":
                VIEW_CUTLEN_REP_DETAIL_BTableAdapter cutlen_detail_b = new VIEW_CUTLEN_REP_DETAIL_BTableAdapter();
                VIEW_CUTLEN_REP_REM_USETableAdapter cutlen_remuse = new VIEW_CUTLEN_REP_REM_USETableAdapter();
                e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsCuttingPlan_VIEW_CUTLEN_REP_DETAIL_B",
                    (DataTable)cutlen_detail_b.GetData(Decimal.Parse(Request.QueryString["Arg1"]))
                    ));
                e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsCuttingPlan_VIEW_CUTLEN_REP_REM_USE",
                    (DataTable)cutlen_remuse.GetData(Decimal.Parse(Request.QueryString["Arg1"]))
                    ));
                break;
        }
    }
}