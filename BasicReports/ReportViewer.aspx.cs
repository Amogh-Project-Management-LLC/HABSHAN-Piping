using dsDCS_ReportsTableAdapters;
using dsIsomeReportsATableAdapters;
using dsJcReports_ATableAdapters;
using dsJcReportsTableAdapters;
using dsNDE_ReportsATableAdapters;
using dsNDE_ReportsBTableAdapters;
using dsNDE_ReportsCTableAdapters;
using dsNDE_ReportsDTableAdapters;
using dsSpoolReportsATableAdapters;
using dsSpoolReportsCTableAdapters;
using dsWelderPerformanceTableAdapters;
using dsWeldingReportsATableAdapters;
using dsWeldingReportsBTableAdapters;
using dsWeldingReportsCTableAdapters;
using dsWeldingReportsDTableAdapters;
using Microsoft.Reporting.WebForms;
using dsIsomeReportsATableAdapters;
using System;
using System.Data;
using System.Data.SqlClient;

public partial class Default2 : System.Web.UI.Page
{
    public int post_bks;
    private object dsIsome_ATableAdapters;

    protected void Page_Load(object sender, EventArgs e)
    {
        //DCS Reports 100-199
        //Spool Reports 200-299
        //PO Shipping Reports 300-399
        //Weekly Reports 400-499
        if (!IsPostBack)
        {
            //Using query string expressions.
            //ReportID, Arg1, Arg2, Arg3, ...
            string ReportID;
            String Arg1, Arg2, Arg3, Arg4;
            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            Arg2 = Request.QueryString["Arg2"];
            Arg3 = Request.QueryString["Arg3"];
            Arg4 = Request.QueryString["Arg4"];
            post_bks = 0;

            switch (ReportID)
            {
                case "1.1": //Fitup Report - Joint wise shop
                    VIEW_FITUP_REPORT_STableAdapter fitup_report_s = new VIEW_FITUP_REPORT_STableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyFitup_Joint_Shop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_FITUP_REPORT_S",
                        (DataTable)fitup_report_s.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "1.1.1": //Fitup Report - Joint wise field
                    VIEW_FITUP_REPORT_FTableAdapter fitup_report_f = new VIEW_FITUP_REPORT_FTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyFitup_Joint_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_FITUP_REPORT_F",
                        (DataTable)fitup_report_f.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "1.2": //Welding Report - Joint wise shop
                case "1.2.2":
                    if (ReportID == "1.2")
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyWelding_Joint_Shop.rdlc"; // Std
                    else
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyWelding_Joint_ShopJGC.rdlc"; // JGC

                    VIEW_WELDING_REPORT_STableAdapter welding_report_s = new VIEW_WELDING_REPORT_STableAdapter();
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_WELDING_REPORT_S",
                        (DataTable)welding_report_s.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "1.2.1": //Welding Report - Joint wise field
                    VIEW_WELDING_REPORT_FTableAdapter welding_report_f = new VIEW_WELDING_REPORT_FTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\DailyWelding_Joint_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsC_VIEW_WELDING_REPORT_F",
                        (DataTable)welding_report_f.GetData(
                        DateTime.Parse(Arg1),
                        DateTime.Parse(Arg2),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3),
                        Request.QueryString["MAT_TYPE"])));
                    break;

                case "2": //Fitup and Welding Summary - Material wise
                    VIEW_WELDING_REPORT_MAT_TYPETableAdapter welding_report_sf = new VIEW_WELDING_REPORT_MAT_TYPETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_MatWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_MAT_TYPE",
                        (DataTable)welding_report_sf.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "2.1": //Fitup and Welding Summary - Material wise
                    VIEW_WELDING_REPORT_FIELD_MATTableAdapter rep_02P1 = new VIEW_WELDING_REPORT_FIELD_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProgField_MatWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsB_VIEW_WELDING_REPORT_FIELD_MAT",
                        (DataTable)rep_02P1.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "3": //Fitup and Welding Summary - Area wise
                    VIEW_WELDING_REPORT_AREATableAdapter welding_report_sf_area = new VIEW_WELDING_REPORT_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_AreaWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_AREA",
                        (DataTable)welding_report_sf_area.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "3.1": //Fitup and Welding Summary Field - Area wise
                    VIEW_WELDING_REPORT_FIELD_AREATableAdapter rep_03P1 = new VIEW_WELDING_REPORT_FIELD_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProgField_AreaWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsB_VIEW_WELDING_REPORT_FIELD_AREA",
                        (DataTable)rep_03P1.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "4": //Fitup and Welding Summary - Size wise
                    VIEW_WELDING_REPORT_JNT_SIZETableAdapter welding_report_sf_size = new VIEW_WELDING_REPORT_JNT_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_SizeWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_JNT_SIZE",
                        (DataTable)welding_report_sf_size.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "4.1": //Fitup and Welding Summary Field - Size wise
                    VIEW_WELDING_REPORT_FIELD_SIZETableAdapter rep_04P1 = new VIEW_WELDING_REPORT_FIELD_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProgField_SizeWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsB_VIEW_WELDING_REPORT_FIELD_SIZE",
                        (DataTable)rep_04P1.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "4.2": //Fitup and Welding Summary Field - Fab Shop Wise
                    VIEW_WELDING_REPORT_FAB_SHOPTableAdapter rep_04P2 = new VIEW_WELDING_REPORT_FAB_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupWeldingProg_ShopWise.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsA_VIEW_WELDING_REPORT_FAB_SHOP",
                        (DataTable)rep_04P2.GetData(Arg1, Arg2,
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg3))));
                    break;

                case "5": //Welder Performance Report
                    VIEW_WELDER_PERF_REPORTTableAdapter welder_perf = new VIEW_WELDER_PERF_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\welder_performance.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;
                case "5.3": //Welder Performance Report NEW 
                    ReportPreview.ProcessingMode = ProcessingMode.Local;
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\welder_performanceNew.rdlc";
                    string query = "SELECT * from VIEW_WELDER_PERFORM_REP";
                    DataTable table1 = General_Functions.GetDataTable(query);
                    ReportDataSource datasource = new ReportDataSource("VIEW_WELDER_PERFORM_REP", table1);
                    ReportPreview.LocalReport.DataSources.Clear();
                    ReportPreview.LocalReport.DataSources.Add(datasource);
                    break;

                case "5.1": //Welder Performance Report - Monthly - Welderwise
                    VIEW_WELDER_PERF_REPORT_ATableAdapter rep_5_1 = new VIEW_WELDER_PERF_REPORT_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\welder_performance_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_5_1.GetData(
                        Arg1, Arg2,
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3)
                        )));
                    break;

                
                case "5.2": //Welder Performance Report length wise
                    VIEW_WELDER_PERF_LENGTHTableAdapter welder_perf_len = new VIEW_WELDER_PERF_LENGTHTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformanceLength.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_len.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;
                //PMI
                case "6": //PMI Summary Material wise - shop
                    VIEW_LINE_CLASS_WISE_PMITableAdapter pmi_status_mat = new VIEW_LINE_CLASS_WISE_PMITableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PMI_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_PMI",
                        (DataTable)pmi_status_mat.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "6.1": //PMI Summary Material wise - shop
                   dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_PMI_NON_PRODTableAdapter pmi_status1 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_PMI_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PMI_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_PMI",
                        (DataTable)pmi_status1.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                //case "7": //PMI Summary Material wise - Field
                //    VIEW_PMI_STATUS_FIELDTableAdapter pmi_status_mat_f = new VIEW_PMI_STATUS_FIELDTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PMI_StatusField.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsNDE_ReportsA_VIEW_PMI_STATUS_FIELD",
                //        (DataTable)pmi_status_mat_f.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                //        )));
                //    break;
                //-----------------------------------------------PWHT
                case "8": //PWHT Summary Material wise - shop
                    VIEW_PWHT_STATUS_SHOPTableAdapter pwht_status_mat_s = new VIEW_PWHT_STATUS_SHOPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PWHT_StatusShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PWHT_STATUS_SHOP",
                        (DataTable)pwht_status_mat_s.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                case "9": //PWHT Summary Material wise - Field
                    VIEW_PWHT_STATUS_FIELDTableAdapter pwht_status_mat_f = new VIEW_PWHT_STATUS_FIELDTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PWHT_StatusField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsA_VIEW_PWHT_STATUS_FIELD",
                        (DataTable)pwht_status_mat_f.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                        )));
                    break;

                //Fitup Backlog
                //Welding Backlog
                case "10":
                case "11":
                    VIEW_WO_FITUP_WELDING_BACKLOGTableAdapter rep_0010 = new VIEW_WO_FITUP_WELDING_BACKLOGTableAdapter();
                    if (ReportID == "10")
                    {
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FitupBackLog.rdlc";
                        ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                            "DataSet1",
                            (DataTable)rep_0010.GetData(
                            decimal.Parse(Session["PROJECT_ID"].ToString()),
                            decimal.Parse(Arg1)
                            )));
                    }
                    else
                    {
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\WeldingBackLog.rdlc";
                        ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                            "DataSet1",
                            (DataTable)rep_0010.GetWeldingBackLog(
                            decimal.Parse(Session["PROJECT_ID"].ToString()),
                            decimal.Parse(Arg1)
                            )));
                    }
                    break;

                //Repair Status
                case "12":
                    VIEW_RT_REP_ATableAdapter rep_12 = new VIEW_RT_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_Repair.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RT_REP_A",
                        (DataTable)rep_12.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["CAT_ID"])
                        )));
                    break;

                case "12.1":
                    VIEW_RT_REP_A_PRODTableAdapter rep_12_1 = new VIEW_RT_REP_A_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_Repair_Prod.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RT_REP_A_PROD",
                        (DataTable)rep_12_1.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["CAT_ID"])
                        )));
                    break;

                case "12.2":
                    VIEW_RT_REP_A_WELD_DATETableAdapter rep_12_2 = new VIEW_RT_REP_A_WELD_DATETableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\NDE\NDE_RT_RepairWeldDate.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_RT_REP_A_WELD_DATE",
                        (DataTable)rep_12_2.GetData(
                        Request.QueryString["DATE_FROM"],
                        Request.QueryString["DATE_TO"],
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["CAT_ID"])
                        )));
                    break;

                case "13":
                    VIEW_LINE_CLASS_WISE_PWHTTableAdapter rep_13 = new VIEW_LINE_CLASS_WISE_PWHTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PWHT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_PWHT",
                        (DataTable)rep_13.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                       decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "13.1":
                    dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_PWHT_NON_PRODTableAdapter rep_131 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_PWHT_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PWHT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_PWHT",
                        (DataTable)rep_131.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                       decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                //case "13.1":
                //    VIEW_PWHT_PCWBS_FIELDTableAdapter rep_13_1 = new VIEW_PWHT_PCWBS_FIELDTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\PCWBS_PWHT_StatusField.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsNDE_ReportsA_VIEW_PWHT_PCWBS_FIELD",
                //        (DataTable)rep_13_1.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()),
                //        decimal.Parse(Request.QueryString["Arg1"])
                //        )));
                //    break;

                //29-July-2015
                case "14"://NDE(Other) Back Log shop
                    VIEW_NDE_BACK_LOGTableAdapter rep_0014 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogShop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_0014.GetDataFab(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]))));
                    break;

                case "14.1"://NDE(RT) Back Log Shop
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P1 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Shop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P1.GetDataByFabRedo(
                        decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 2)));
                    break;

                case "14.2"://NDE(RT) reshoot/ retake shop
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P2 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Redo_Shop.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P2.GetDataByFabRedo(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 3)));
                    break;

                case "14.3"://NDE(RT) Back Log field
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P3 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P3.GetDataByFieldRedo(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 2)));
                    break;

                case "14.5"://NDE(RT) reshoot/ retake field
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P5 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogRT_Redo_Field.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P5.GetDataByFieldRedo(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]), 3)));
                    break;

                case "14.6"://NDE(Other) Back Log filed
                    VIEW_NDE_BACK_LOGTableAdapter rep_14P6 = new VIEW_NDE_BACK_LOGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_BackLogField.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsB_VIEW_NDE_BACK_LOG",
                        (DataTable)rep_14P6.GetDataByField(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                        decimal.Parse(Request.QueryString["SC_ID"]))));
                    break;

                //Welder Performance
                case "15": //Welder Performance Report (Material wise)
                    VIEW_WELDER_PERF_REPORT_MATTableAdapter welder_perf_mat = new VIEW_WELDER_PERF_REPORT_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformanceMat.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_mat.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "16": //Welder Performance Report (Percent wise)
                    VIEW_WELDER_PERF_REPORT_PRCNTTableAdapter welder_perf_prnct = new VIEW_WELDER_PERF_REPORT_PRCNTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformancePercent.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_prnct.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "17": //Welder Performance Report (Size wise)
                    VIEW_WELDER_PERF_REPORT_SIZETableAdapter welder_perf_size = new VIEW_WELDER_PERF_REPORT_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Welder_PerformanceSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)welder_perf_size.GetData(
                        Arg1, Arg2, decimal.Parse(Session["PROJECT_ID"].ToString()),
                        decimal.Parse(Arg3))));
                    break;

                case "18": //Isometric Joints Staus
                    VIEW_ISOME_JOINTS_REPTableAdapter isome_joints = new VIEW_ISOME_JOINTS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeJointsSummary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_ISOME_JOINTS_REP",
                        (DataTable)isome_joints.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Arg1)));
                    break;

                case "19": //Isometric NDE Staus
                    VIEW_ISOME_NDE_REPTableAdapter isome_nde = new VIEW_ISOME_NDE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeNDE_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_ISOME_NDE_REP",
                        (DataTable)isome_nde.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Arg1)));
                    break;

                case "20":
                    //VIEW_WELDER_NDE_STATUS_ATableAdapter rep_20 = new VIEW_WELDER_NDE_STATUS_ATableAdapter();
                    VIEW_WELDER_NDE_STATUS_BTableAdapter rep_20 = new VIEW_WELDER_NDE_STATUS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\WelderRT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_20.GetData(
                        DateTime.Parse(Request.QueryString["DATE_FROM"]),
                        DateTime.Parse(Request.QueryString["DATE_TO"]),
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                //case "20": //Isometric issuance Staus
                //    VIEW_ISOME_ISSUE_REPTableAdapter isome_issue = new VIEW_ISOME_ISSUE_REPTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeIssue.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsMatIssueA_VIEW_ISOME_ISSUE_REP",
                //        (DataTable)isome_issue.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), Arg2)));
                //    break;

                //case "21": //Isometric available Staus
                //    VIEW_ISOME_AVAIL_REPTableAdapter isome_avail = new VIEW_ISOME_AVAIL_REPTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeAvailable.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsMatIssueA_VIEW_ISOME_AVAIL_REP",
                //        (DataTable)isome_avail.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), Arg2)));
                //    break;

                case "22": //Isometric fabrication Staus
                    //Nothing...
                    break;

                case "23": //New Tracer Report
                    VIEW_TRACER_REPORT_ATableAdapter rep_23 = new VIEW_TRACER_REPORT_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\Tracer_Joints_Rep_New.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsWeldingReportsD_VIEW_TRACER_REPORT_A",
                        (DataTable)rep_23.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "25": //PTMT summary piping class wise - shop
                    VIEW_LINE_CLASS_WISE_MTTableAdapter mt_status = new VIEW_LINE_CLASS_WISE_MTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_MT",
                        (DataTable)mt_status.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));

                    VIEW_LINE_CLASS_WISE_PTTableAdapter pt_status = new VIEW_LINE_CLASS_WISE_PTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_PT",
                        (DataTable)pt_status.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "25.1": //PTMT summary piping class wise - shop
                    dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_MT_NON_PRODTableAdapter mt_status1 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_MT_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_MT",
                        (DataTable)mt_status1.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));

                    dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_PT_NON_PRODTableAdapter pt_status1 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_PT_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_PT",
                        (DataTable)pt_status1.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                //case "26": //PTMT summary piping class wise - Field
                //    VIEW_PTMT_STATUS_FIELDTableAdapter ptmt_status_mat_f = new VIEW_PTMT_STATUS_FIELDTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_PTMT_StatusField.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsNDE_ReportsB_VIEW_PTMT_STATUS_FIELD",
                //        (DataTable)ptmt_status_mat_f.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                //        )));
                //    break;

                case "27": //RT summary piping class wise
                    VIEW_LINE_CLASS_WISE_RTTableAdapter rt_status = new VIEW_LINE_CLASS_WISE_RTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_RT",
                        (DataTable)rt_status.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1),decimal.Parse(Arg2)
                        )));
                    break;
                case "27.1": //RT summary piping class wise
                    dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_RT_NON_PRODTableAdapter rt_status1 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_RT_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_RT",
                        (DataTable)rt_status1.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "29": //UT summary piping class wise
                    VIEW_LINE_CLASS_WISE_UTTableAdapter ut_status = new VIEW_LINE_CLASS_WISE_UTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_UT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_UT",
                        (DataTable)ut_status.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "29.1": //UT summary piping class wise
                    dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_UT_NON_PRODTableAdapter ut_status1 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_UT_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_UT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_UT",
                        (DataTable)ut_status1.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;

                //case "28": //RTUT summary piping class wise - Field
                //    VIEW_RTUT_STATUS_FIELDTableAdapter rtut_status_mat_f = new VIEW_LINE_CLASS_WISE_RTTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_RT_StatusField.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsNDE_ReportsC_VIEW_RTUT_STATUS_FIELD",
                //        (DataTable)rtut_status_mat_f.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                //        )));
                //    break;

                //12-Jul-2013
                //================================================



                //case "29": //RTUT summary piping class wise - Field
                //    VIEW_FIELD_JOINTSTableAdapter rep_29 = new VIEW_FIELD_JOINTSTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = @"BasicReports\Welding\DailyWelding_Joint_RepNo.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsWeldingReportsC_VIEW_FIELD_JOINTS",
                //        (DataTable)rep_29.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["WELD_REP_NO"]
                //        )));
                //    break;

                //HT-SHOP
                case "30":
                    VIEW_LINE_CLASS_WISE_HTTableAdapter rep_30 = new VIEW_LINE_CLASS_WISE_HTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_HT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_HT",
                        (DataTable)rep_30.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "30.1":
                    dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_HT_NON_PRODTableAdapter rep_301 = new dsNDE_ReportsETableAdapters.VIEW_LINE_CLS_WISE_HT_NON_PRODTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_HT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_HT",
                        (DataTable)rep_301.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                //case "31":
                //    VIEW_HT_REP_A_FIELDTableAdapter rep_31 = new VIEW_HT_REP_A_FIELDTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_HT_StatusField.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "DataSet1",
                //        (DataTable)rep_31.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                //        )));
                //    break;

                //FT-Shop
                case "32":
                    VIEW_LINE_CLASS_WISE_FTTableAdapter rep_32 = new VIEW_LINE_CLASS_WISE_FTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_FT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_FT",
                        (DataTable)rep_32.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                case "32.1":
                    VIEW_LINE_CLASS_WISE_FTTableAdapter rep_321 = new VIEW_LINE_CLASS_WISE_FTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_FT_Status.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsNDE_ReportsC_VIEW_LINE_CLASS_WISE_FT",
                        (DataTable)rep_321.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1), decimal.Parse(Arg2)
                        )));
                    break;
                ////FT-Field
                //case "33":
                //    VIEW_FT_REP_A_FIELDTableAdapter rep_33 = new VIEW_FT_REP_A_FIELDTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\NDE_FT_StatusField.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "DataSet1",
                //        (DataTable)rep_33.GetData(
                //        decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Arg1)
                //        )));
                //    break;

                case "42": //Jc wise status
                    VIEW_JC_STATUS_ATableAdapter jc_status_a = new VIEW_JC_STATUS_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\JC_Status_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_A_VIEW_JC_STATUS_A",
                        (DataTable)jc_status_a.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                //============================================
                // D  C  S    R  E  P  O  R  T  S
                //============================================
                case "102"://Erection joint history sheet
                    VIEW_SPL_CLR_HSTableAdapter erec_hs = new VIEW_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Erection\\Erection_HistorySheet.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_CLR_HS",
                        (DataTable)erec_hs.GetData(Decimal.Parse(Arg1))));
                    break;
                case "102.1": //Erection Joint History Sheet -- Joint Categroy Wise
                    VIEW_SPL_CLR_HSTableAdapter erec_hs_1 = new VIEW_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Erection\\Erection_HistorySheet.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_CLR_HS",
                        (DataTable)erec_hs_1.GetDataByCatID(Decimal.Parse(Arg1), decimal.Parse(Request.QueryString["CAT_ID"].ToString()))));                    
                    break;
                case "104"://spoolgen status area wise
                    VIEW_SG_STATUS_BTableAdapter sg_status_b = new VIEW_SG_STATUS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusB.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsDCS_Reports_VIEW_SG_STATUS_B",
                        (DataTable)sg_status_b.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "104.1"://spoolgen status service wise
                    VIEW_SG_STATUS_SRV_BTableAdapter sg_status_SRV = new VIEW_SG_STATUS_SRV_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusB_SRV.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsDCS_Reports_VIEW_SG_STATUS_SRV_B",
                        (DataTable)sg_status_SRV.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "105"://spoolgen status lot wise
                    //VIEW_ISOME_REP_BTableAdapter isome_rep_b = new VIEW_ISOME_REP_BTableAdapter();
                    dsWeeklyReport_AxsdTableAdapters.VIEW_ISOME_REP_CTableAdapter isome_rep_c = new dsWeeklyReport_AxsdTableAdapters.VIEW_ISOME_REP_CTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\WeeklyReport\\SG_StatusC_Exclude_Scope.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)isome_rep_c.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;
                case "105.1"://spoolgen status lot wise
                    //VIEW_ISOME_REP_BTableAdapter isome_rep_b = new VIEW_ISOME_REP_BTableAdapter();
                    dsWeeklyReport_AxsdTableAdapters.VIEW_ISOME_REP_C_EXCLUDE3TableAdapter isome_rep_c3 = new dsWeeklyReport_AxsdTableAdapters.VIEW_ISOME_REP_C_EXCLUDE3TableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\WeeklyReport\\SG_StatusC_Exclude_Scope_3.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)isome_rep_c3.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "106"://spoolgen status Size wise

                    VIEW_SG_STATUS_SIZETableAdapter isome_rep_size = new VIEW_SG_STATUS_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsDCS_Reports_VIEW_SG_STATUS_SIZE",
                        (DataTable)isome_rep_size.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "107"://spoolgen status Area Wise, Size wise

                    VIEW_SG_STATUS_AREA_SIZETableAdapter rep_107 = new VIEW_SG_STATUS_AREA_SIZETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\DCS_Reps\\SG_StatusAreaSize.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_107.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                //============================================
                // S  P  O  O  L      R  E  P  O  R  T  S
                //============================================
                case "200"://Spool History Sheet - A
                    VIEW_SPL_CLR_HSTableAdapter rep_200 = new VIEW_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolClear_HistorySheet_B.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_200.GetDataBySPL_ID(decimal.Parse(Arg1))));
                    break;
                case "200.1"://Bulk Spool History Sheet - A
                    dsBulkDownloadsTableAdapters.VIEW_BULK_SPL_CLR_HSTableAdapter rep_2001 = new dsBulkDownloadsTableAdapters.VIEW_BULK_SPL_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolClear_HistorySheet_B.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2001.GetData(Session["USER_NAME"].ToString())));
                    break;

                case "200.2"://Bulk Spool History Sheet - A
                    dsBulkDownloadsTableAdapters.VIEW_BULK_SFR_RELEASETableAdapter rep_2002 = new dsBulkDownloadsTableAdapters.VIEW_BULK_SFR_RELEASETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SFR_Release_B.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2002.GetData(Session["USER_NAME"].ToString())));
                    break;

                case "202"://Spool id area wise
                    VIEW_SPL_ID_REP_AREATableAdapter spool_0202 = new VIEW_SPL_ID_REP_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryArea_ID.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_AREA",
                        (DataTable)spool_0202.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "202.1":
                    VIEW_SPL_ID_REP_AREA_SCTableAdapter spool_2021 = new VIEW_SPL_ID_REP_AREA_SCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryArea_SPL.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_AREA_SC",
                        (DataTable)spool_2021.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))
                        ));
                    break;

                case "202.3"://Spool id Mat wise
                    VIEW_SPL_ID_REP_MATTableAdapter spool_0203 = new VIEW_SPL_ID_REP_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryMat_ID.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_MAT",
                        (DataTable)spool_0203.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "202.4": // Spool id area wise/ Mat wise
                case "202.5":
                    VIEW_SPL_ID_REP_AREA_BTableAdapter spool_0203_4 = new VIEW_SPL_ID_REP_AREA_BTableAdapter();
                    if (ReportID == "202.4")
                    {
                        if (Request.QueryString["AGUG"] == "1")
                        {
                            ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryAreaMat_ID_AG.rdlc";
                        }
                        else if (Request.QueryString["AGUG"] == "2")
                        {
                            ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryAreaMat_ID_UG.rdlc";
                        }
                    }
                    else
                    {
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummaryAreaMat_SPL.rdlc";
                    }

                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_ID_REP_AREA_B",
                        (DataTable)spool_0203_4.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["AGUG"]
                        )));
                    break;

                case "203"://SFR Release
                    VIEW_SFR_RELEASETableAdapter sfr_release_a = new VIEW_SFR_RELEASETableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SFR_Release_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)sfr_release_a.GetData(decimal.Parse(Arg1))));
                    break;

                case "203.1"://SFR Release - project 1
                    VIEW_SPL_CLR_HS_MATTableAdapter rep_203_1 = new VIEW_SPL_CLR_HS_MATTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SingleMaterialSpoolClear.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_203_1.GetData(Decimal.Parse(Arg1))));
                    break;

                //CRD Date wise Shop Inch Dia Status
                case "204"://SFR Release - project 1
                    VIEW_CRD_DATE_INCH_DIATableAdapter rep_2014 = new VIEW_CRD_DATE_INCH_DIATableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"BasicReports\Spool\CRD_Date_InchDia.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2014.GetData(Decimal.Parse(
                        Session["PROJECT_ID"].ToString()
                        ))));
                    break;

                //case "206"://spool site summary
                //    VIEW_SPL_ID_REP_ERECTableAdapter rep_0206 = new VIEW_SPL_ID_REP_ERECTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolStatus_Erec.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsSpoolReportsC_VIEW_SPL_ID_REP_EREC", rep_0206.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                //    break;

                case "207"://Spool id subcon wise
                    VIEW_SPL_ID_REP_SC_AGUGTableAdapter spool_0207 = new VIEW_SPL_ID_REP_SC_AGUGTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Spool\\SpoolInchDiaSummarySC_AGUG.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsC_VIEW_SPL_ID_REP_SC_AGUG",
                        (DataTable)spool_0207.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "210"://Jobcard joints status
                    VIEW_WO_JNTS_SUMMARY_ATableAdapter wo_jnts = new VIEW_WO_JNTS_SUMMARY_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\NDE\\JC_Joints.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsJcReports_VIEW_WO_JNTS_SUMMARY_A",
                        (DataTable)wo_jnts.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;
                case "211": //Isometric Fabrication Status
                    VIEW_PIPING_DPR_RDLCTableAdapter piping_dpr = new VIEW_PIPING_DPR_RDLCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeFabricationSummary.rdlc";
                    ReportPreview.LocalReport.DisplayName = "PIPING_FAB_STATUS_" + DateTime.Today;
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_PIPING_DPR_RDLC",
                        (DataTable)piping_dpr.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "211.1": //Isometric Fabrication Status
                    VIEW_PIPING_DPR_RDLCTableAdapter piping_dpr2 = new VIEW_PIPING_DPR_RDLCTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeFabricationSummary_2.rdlc";
                    ReportPreview.LocalReport.DisplayName = "PIPING_FAB_STATUS_"+DateTime.Today;
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_PIPING_DPR_RDLC",
                        (DataTable)piping_dpr2.GetData(
                        decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;

                case "211.2": //Isometric Fabrication Status
                    VIEW_SC_WISE_IDF_MTO_REPORTTableAdapter piping_cladded = new VIEW_SC_WISE_IDF_MTO_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Isome\\IsomeFabricationSummary_Cladded.rdlc";
                    ReportPreview.LocalReport.DisplayName = "PIPING_STATUS_CLADDED_" + DateTime.Today;
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsIsomeReportsA_VIEW_PIPING_DPR_RDLC",
                        (DataTable)piping_cladded.GetData("CLADDED")));
                    break;
                //case "212":

                //    VIEW_DPR_MILESTONETableAdapter dpr_milestone = new VIEW_DPR_MILESTONETableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //      "dsIsomeReportsA_VIEW_DPR_MILESTONE",
                //    (DataTable)dpr_milestone.GetData()));

                //    VIEW_ISOMETRIC_INDEX_DPRTableAdapter iso_index = new VIEW_ISOMETRIC_INDEX_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //      "dsIsomeReportsA_VIEW_ISOMETRIC_INDEX_DPR",
                //    (DataTable)iso_index.GetData()));

                //    VIEW_SPOOLGEN_TRANS_DPRTableAdapter trans_spl = new VIEW_SPOOLGEN_TRANS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //      "dsIsomeReportsA_VIEW_SPOOLGEN_TRANS_DPR",
                //      (DataTable)trans_spl.GetData()));

                //    VIEW_SPOOLGEN_PROGRESS_DPRTableAdapter spl_prog = new VIEW_SPOOLGEN_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //      "dsIsomeReportsA_VIEW_SPOOLGEN_PROGRESS_DPR",
                //      (DataTable)spl_prog.GetData()));

                //    VIEW_JOBCARD_PROGRESS_DPRTableAdapter job_prog = new VIEW_JOBCARD_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_JOBCARD_PROGRESS_DPR",
                //        (DataTable)job_prog.GetData()));

                //    VIEW_FITUP_PROGRESS_DPRTableAdapter fitup_prog = new VIEW_FITUP_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_FITUP_PROGRESS_DPR",
                //        (DataTable)fitup_prog.GetData()));

                //    VIEW_NDE_PROGRESS_DPRTableAdapter nde_prog = new VIEW_NDE_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_NDE_PROGRESS_DPR",
                //        (DataTable)nde_prog.GetData()));
                //    VIEW_PAINT_PROGRESS_DPRTableAdapter pnt_req_prog = new VIEW_PAINT_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_PAINT_PROGRESS_DPR",
                //        (DataTable)pnt_req_prog.GetData()));
                //    VIEW_PAINT_PROGRESS_DPRTableAdapter pnt_prog = new VIEW_PAINT_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_PAINT_PROGRESS_DPR",
                //        (DataTable)pnt_prog.GetData()));
                //    VIEW_TRANSF_PROGRESS_DPRTableAdapter before_irn_prog = new VIEW_TRANSF_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_TRANSF_PROGRESS_DPR",
                //        (DataTable)before_irn_prog.GetData()));
                //    VIEW_TRANSF_PROGRESS_DPRTableAdapter after_irn_prog = new VIEW_TRANSF_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_TRANSF_PROGRESS_DPR",
                //        (DataTable)after_irn_prog.GetData()));
                //    VIEW_TRANSF_PROGRESS_DPRTableAdapter srn_prog = new VIEW_TRANSF_PROGRESS_DPRTableAdapter();
                //    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\Piping_dpr.rdlc";
                //    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //        "dsIsomeReportsA_VIEW_TRANSF_PROGRESS_DPR",
                //        (DataTable)srn_prog.GetData()));
                //    break;

                case "212.1":
                    VIEW_FABRICATION_STATUS_RDLCTableAdapter oil_milestone = new VIEW_FABRICATION_STATUS_RDLCTableAdapter();                   
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\FirstOil.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "dsIsomeReportsA_VIEW_FABRICATION_STATUS_RDLC",
                    (DataTable)oil_milestone.GetData()));
                    break;
                case "212.2":
                    VIEW_FAB_STATUS_PHASE_RDLC_1TableAdapter oil_milestone2 = new VIEW_FAB_STATUS_PHASE_RDLC_1TableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\FirstOil2.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "dsIsomeReportsA_VIEW_FAB_STATUS_PHASE_RDLC_1",
                    (DataTable)oil_milestone2.GetData("1")));

                    VIEW_FAB_STATUS_PHASE_RDLC_2TableAdapter oil_milestone3 = new VIEW_FAB_STATUS_PHASE_RDLC_2TableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\FirstOil2.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "dsIsomeReportsA_VIEW_FAB_STATUS_PHASE_RDLC_2",
                    (DataTable)oil_milestone3.GetData("2")));
                    break;


                case "213":
                    VIEW_SITE_JOINTS_SUMMARYTableAdapter flange_summary = new VIEW_SITE_JOINTS_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\FlangeSummary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "dsIsomeReportsA_VIEW_SITE_JOINTS_SUMMARY",
                    (DataTable)flange_summary.GetData()));
                    break;

                case "214":
                    VIEW_TIE_IN_ISOMETRIC_REPTableAdapter tiein = new VIEW_TIE_IN_ISOMETRIC_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\TIE_IN_REPORT.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "dsIsomeReportsA_VIEW_TIE_IN_ISOMETRIC_REP",
                    (DataTable)tiein.GetData()));
                    break;
                case "551":
                    ReportPreview.ProcessingMode = ProcessingMode.Local;
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\RT_Percentage_Lessthan100.rdlc";
                    string query_551 = "SELECT * from VIEW_NDT_LESS_THAN_100";
                    DataTable TABLE_551 = General_Functions.GetDataTable(query_551);
                    ReportDataSource datasource551 = new ReportDataSource("VIEW_NDT_LESS_THAN_100", TABLE_551);
                    ReportPreview.LocalReport.DataSources.Clear();
                    ReportPreview.LocalReport.DataSources.Add(datasource551);
                    break;
                case "220":

                    VIEW_SPOOL_SUMMERYTableAdapter ms_spool_sum = new VIEW_SPOOL_SUMMERYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\MS-2_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "VIEW_SPOOL_SUMMERY",
                    (DataTable)ms_spool_sum.GetData()));

                    VIEW_MS_SCOPE_ID_SUMMARYTableAdapter ms_scope = new VIEW_MS_SCOPE_ID_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\MS-2_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "VIEW_MS_SCOPE_ID_SUMMARY",
                    (DataTable)ms_scope.GetData()));

                    VIEW_MS_SCOPE_ID_TIE_INTableAdapter ms_tie_in = new VIEW_MS_SCOPE_ID_TIE_INTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "Isome\\Reports\\MS-2_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                      "VIEW_MS_SCOPE_ID_TIE_IN",
                    (DataTable)ms_tie_in.GetData()));
                    break;
                case "552":
                    string id = Request.QueryString["MODULE_ID"];
                    string cat_id = Request.QueryString["CAT_ID"];
                    string area = WebTools.GetExpr("AREA", "TABLE_RDLC_SELECTION", "USER_NAME='" + Session["USER_NAME"].ToString() + "' AND REPORT_CODE='" + Request.QueryString["ReportID"] + "'");
                    string subcon = WebTools.GetExpr("FAB_SUBCON", "TABLE_RDLC_SELECTION", "USER_NAME = '" + Session["USER_NAME"].ToString() + "' AND REPORT_CODE = '" + Request.QueryString["ReportID"] + "'");

                    if (id == "1")
                    {
                        ReportPreview.ProcessingMode = ProcessingMode.Local;
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\SpoolSizeWiseWeldProg.rdlc";
                        string query_552 = "SELECT * from VIEW_SPL_SIZE_WISE WHERE AREA_group IN (" + area + ") AND fab_subcon IN (" + subcon + ") AND CAT_ID ="+ cat_id +"";
                        DataTable TABLE_552 = General_Functions.GetDataTable(query_552);
                        ReportDataSource datasource552 = new ReportDataSource("VIEW_SPL_SIZE_WISE", TABLE_552);
                        ReportPreview.LocalReport.DataSources.Clear();
                        ReportPreview.LocalReport.DataSources.Add(datasource552);
                    }
                    if (id == "2")

                    {
                        ReportPreview.ProcessingMode = ProcessingMode.Local;
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\SpoolSizeWiseNdeProg.rdlc";
                        string query_552_1 = "SELECT * from VIEW_SPL_SIZE_WISE WHERE AREA_group IN (" + area + ") AND fab_subcon IN (" + subcon + ")  AND CAT_ID =" + cat_id + "";
                        DataTable TABLE_552_1 = General_Functions.GetDataTable(query_552_1);
                        ReportDataSource datasource552_1 = new ReportDataSource("VIEW_SPL_SIZE_WISE", TABLE_552_1);
                        ReportPreview.LocalReport.DataSources.Clear();
                        ReportPreview.LocalReport.DataSources.Add(datasource552_1);
                    }
                    if (id == "3")

                    {
                        ReportPreview.ProcessingMode = ProcessingMode.Local;
                        ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\SpoolSizeWisePaintProg.rdlc";
                        string query_552_2 = "SELECT * from VIEW_SPL_SIZE_WISE WHERE AREA_group IN (" + area + ") AND fab_subcon IN (" + subcon + ") AND CAT_ID =" + cat_id + " ";
                        DataTable TABLE_552_2 = General_Functions.GetDataTable(query_552_2);
                        ReportDataSource datasource552_2 = new ReportDataSource("VIEW_SPL_SIZE_WISE", TABLE_552_2);
                        ReportPreview.LocalReport.DataSources.Clear();
                        ReportPreview.LocalReport.DataSources.Add(datasource552_2);

                    }
                    break;
                case "553":
                    ReportPreview.ProcessingMode = ProcessingMode.Local;
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FOIPipingFabAreaWise.rdlc";
                    string query_553 = "SELECT * from VIEW_SFR_FAB_AREA_WISE_SPLS";
                    DataTable TABLE_553 = General_Functions.GetDataTable(query_553);
                    ReportDataSource datasource553 = new ReportDataSource("VIEW_SFR_FAB_AREA_WISE_SPLS", TABLE_553);
                    ReportPreview.LocalReport.DataSources.Clear();
                    ReportPreview.LocalReport.DataSources.Add(datasource553);
                    break;
                case "554":
                    ReportPreview.ProcessingMode = ProcessingMode.Local;
                    ReportPreview.LocalReport.ReportPath = "BasicReports\\Welding\\FOIPipingFabSubconWise.rdlc";
                    string query_554 = "SELECT * from VIEW_SFR_FAB_SUBCON_WISE_SPLS";
                    DataTable TABLE_554 = General_Functions.GetDataTable(query_554);
                    ReportDataSource datasource554 = new ReportDataSource("VIEW_SFR_FAB_SUBCON_WISE_SPLS", TABLE_554);
                    ReportPreview.LocalReport.DataSources.Clear();
                    ReportPreview.LocalReport.DataSources.Add(datasource554);
                    break;

            }
        }
    }

    protected void ReportPreview_SubreportProcessing(Object sender, SubreportProcessingEventArgs e)
    {
        string ReportID = Request.QueryString["ReportID"];
        switch (ReportID)
        {
            case "102":
            case "200":
            case "200.1":
            case "203":
            case "203.1":
                PIP_JOINT_REVTableAdapter jnt_rev = new PIP_JOINT_REVTableAdapter();
                e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "dsWeldingReportsB_PIP_JOINT_REV",
                    (DataTable)jnt_rev.GetData()));
                break;

            case "20":
                VIEW_RT_DEFECTTableAdapter rt_defect = new VIEW_RT_DEFECTTableAdapter();
                e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                    "DataSet2",
                    (DataTable)rt_defect.GetData()));
                break;
        }
    }
}