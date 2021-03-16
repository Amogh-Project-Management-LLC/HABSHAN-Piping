using dsTestPackageATableAdapters;
using dsTestPackageBTableAdapters;
using dsTestPkg_RepsTableAdapters;
using System;
using System.Data;

public partial class TestPkg_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;
            String Arg1;
            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            switch (ReportID)
            {
                case "2":
                    VIEW_TOTAL_TPK_SPLTableAdapter tpk_spools = new VIEW_TOTAL_TPK_SPLTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TPK_Spools.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TOTAL_TPK_SPL",
                        (DataTable)tpk_spools.GetData(Decimal.Parse(Arg1))));
                    break;

                case "3":
                    VIEW_TOTAL_TPK_ISOTableAdapter tpk_iso = new VIEW_TOTAL_TPK_ISOTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TPK_Isome.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TOTAL_TPK_ISO",
                        (DataTable)tpk_iso.GetData(Decimal.Parse(Arg1))));
                    break;

                case "4":
                    VIEW_TPK_ISO_INCH_ATableAdapter tpk_id_a = new VIEW_TPK_ISO_INCH_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TPK_Iso_InchDia.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TPK_ISO_INCH_A",
                        (DataTable)tpk_id_a.GetData(Decimal.Parse(Arg1))));
                    break;

                case "5":
                    VIEW_TPK_ISO_JNT_ATableAdapter tpk_jnt_a = new VIEW_TPK_ISO_JNT_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TPK_JointStatus_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TPK_ISO_JNT_A",
                        (DataTable)tpk_jnt_a.GetData(Decimal.Parse(Arg1))));
                    break;

                case "6":
                    VIEW_TPK_JOINTSTableAdapter rep_6 = new VIEW_TPK_JOINTSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TestPackageJoints.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TPK_JOINTS",
                        (DataTable)rep_6.GetData(Decimal.Parse(Arg1))));
                    break;

                case "7":
                    VIEW_TPK_BOMTableAdapter rep_7 = new VIEW_TPK_BOMTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TestPackageLooseMats.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageB_VIEW_TPK_BOM",
                        (DataTable)rep_7.GetData(Decimal.Parse(Arg1))));
                    break;

                case "8":
                    VIEW_TPK_BOMTableAdapter rep_8 = new VIEW_TPK_BOMTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TestPackageLooseSupp.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageB_VIEW_TPK_BOM",
                        (DataTable)rep_8.GetDataBySUPP(Decimal.Parse(Arg1))));
                    break;

                case "10":
                    VIEW_TOTAL_TPK_TRANSTableAdapter tpk_trans_a = new VIEW_TOTAL_TPK_TRANSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TPK_Trans_A.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TOTAL_TPK_TRANS",
                        (DataTable)tpk_trans_a.GetData(Decimal.Parse(Arg1))));
                    break;

                case "11":
                    VIEW_TPK_WELDING_REP_ATableAdapter rep_11 = new VIEW_TPK_WELDING_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\NewReports\\WeldingCompletion.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageA_VIEW_TPK_WELDING_REP_A",
                        (DataTable)rep_11.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["SYS_NUMBER"])
                        ));
                    break;

                case "12":
                    VIEW_TPK_BOM_REP_ATableAdapter rep_12 = new VIEW_TPK_BOM_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\NewReports\\SuppLooseMatInstallCompletion.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageA_VIEW_TPK_BOM_REP_A",
                        (DataTable)rep_12.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["SYS_NUMBER"])
                        ));
                    break;

                case "13":
                    VIEW_TPK_SPL_REP_BTableAdapter rep_13 = new VIEW_TPK_SPL_REP_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\NewReports\\TestPackSpoolsStatus.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageA_VIEW_TPK_SPL_REP_B",
                        (DataTable)rep_13.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["SYS_NUMBER"])
                        ));
                    break;

                case "14":
                    VIEW_ISO_NDE_CTableAdapter rep_14 = new VIEW_ISO_NDE_CTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\NewReports\\NDTCompletion.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageA_VIEW_ISO_NDE_C",
                        (DataTable)rep_14.GetData(Decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["SYS_NUMBER"])
                        ));
                    break;

                case "15":
                    VIEW_TPK_STATUS_ATableAdapter rep_15 = new VIEW_TPK_STATUS_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\TestPackStatus\\TestPackStatusA.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageA_VIEW_TPK_STATUS_A",
                        (DataTable)rep_15.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["SYS_NUMBER"]
                        )));
                    break;

                case "16":
                    VIEW_TPK_STATUS_BTableAdapter rep_16 = new VIEW_TPK_STATUS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\TestPackStatus\\TestPackStatusB.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageA_VIEW_TPK_STATUS_B",
                        (DataTable)rep_16.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()), Request.QueryString["SYS_NUMBER"]
                        )));
                    break;

                case "17":
                case "18":
                case "19":
                    VIEW_TPK_PUNCH_REPTableAdapter rep_17 = new VIEW_TPK_PUNCH_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\TestPackStatus\\PunchListStatus.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPackageB_VIEW_TPK_PUNCH_REP",
                        (DataTable)rep_17.GetData(
                        Decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Request.QueryString["SYS_NUMBER"],
                        Decimal.Parse(Request.QueryString["ORIGIN_ID"]),
                        Request.QueryString["CLEAR_FLAG"]
                        )));
                    break;
                case "1000"://TEST PACK Weld Inspection History Sheet  
                    VIEW_TPK_CLR_HSTableAdapter rep_1000 = new VIEW_TPK_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TestPkg_Weld_Inspection_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TPK_CLR_HS",
                        (DataTable)rep_1000.GetData(decimal.Parse(Arg1))));
                    break;
                case "1001"://TEST PACK Weld Inspection History Sheet  
                    VIEW_TPK_CLR_HSTableAdapter rep_1001 = new VIEW_TPK_CLR_HSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "TestPackage\\Reports\\TestPkg_Weld_Inspection_Summary_New.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsTestPkg_Reps_VIEW_TPK_CLR_HS",
                        (DataTable)rep_1001.GetData(decimal.Parse(Arg1))));
                    break;
            }
        }
    }
}