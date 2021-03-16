using dsGalvJobcardTableAdapters;
using dsSpoolReportsBTableAdapters;
using System;
using System.Data;

public partial class SpoolMove_ReportViewer : System.Web.UI.Page
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
                case "1":
                    VIEW_SPL_TRANS_REPTableAdapter rep_0001 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Spool_Packing_List.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_0001.GetData(Decimal.Parse(Arg1))));
                    break;

                case "2":
                    VIEW_SPL_PAINT_REPTableAdapter rep_2 = new VIEW_SPL_PAINT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Paint_Spools.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2.GetData(Decimal.Parse(Arg1))));
                    break;

                case "2.1": // primer
                    VIEW_SPL_PAINT_REPTableAdapter rep_2_1 = new VIEW_SPL_PAINT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Paint_JGC_Primer.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2_1.GetData(Decimal.Parse(Arg1))));
                    break;

                case "2.2": // finish
                    VIEW_SPL_PAINT_REPTableAdapter rep_2_2 = new VIEW_SPL_PAINT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Paint_JGC_Finish.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2_2.GetData(Decimal.Parse(Arg1))));
                    break;

                case "2.3":
                    VIEW_SPL_PAINT_MATSTableAdapter rep_2_3 = new VIEW_SPL_PAINT_MATSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Paint_Mats.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2_3.GetData(Decimal.Parse(Arg1))));
                    break;

                case "3":
                    string reportName = WebTools.GetExpr("SER_NO", "VIEW_SPL_TRANS_REP", "TRANS_ID='" + Decimal.Parse(Arg1) + "'");
                    VIEW_SPL_TRANS_REPTableAdapter rep_0003 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolList_Transmittal.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_0003.GetData(Decimal.Parse(Arg1))));
                    ReportPreview.LocalReport.DisplayName = reportName ;
                    break;
                case "3.1":
                    dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFR_REPTableAdapter rep_00031 = new dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFR_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolList_Transfer.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_00031.GetData(Decimal.Parse(Arg1))));
                    break;
                case "3.2":
                    VIEW_SPL_TRANS_REPTableAdapter rep_00032 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolList_AfterPaint.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_00032.GetData(Decimal.Parse(Arg1))));
                    break;

                case "4":
                    VIEW_SPL_TRANS_REPTableAdapter rep_4 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolList_Blasting.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_4.GetData(Decimal.Parse(Arg1))));
                    break;

                case "5":
                    VIEW_GALV_JC_REPTableAdapter rep_5 = new VIEW_GALV_JC_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\GalvanisingSpoolList.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsGalvJobcard_VIEW_GALV_JC_REP",
                        (DataTable)rep_5.GetData(Decimal.Parse(Arg1))));
                    break;

                case "6":
                    VIEW_SPL_TRANS_REPTableAdapter rep_6 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolList_Laydown.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_6.GetData(Decimal.Parse(Arg1))));
                    break;

                case "7":
                    VIEW_SPL_TRANS_REPTableAdapter rep_7 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolShippingJobCard.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsB_VIEW_SPL_TRANS_REP",
                        (DataTable)rep_7.GetData(Decimal.Parse(Arg1))));
                    break;

                case "8":
                    VIEW_SPL_TRANS_MATS_BTableAdapter rep_8 = new VIEW_SPL_TRANS_MATS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"SpoolMove\Reports\ShippingJobCard_Mats.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_8.GetData(Decimal.Parse(Arg1))
                        ));
                    break;

                case "9":
                    VIEW_SPL_TRANS_MATS_BTableAdapter rep_9 = new VIEW_SPL_TRANS_MATS_BTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"SpoolMove\Reports\PackingList_Mats.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_9.GetData(Decimal.Parse(Arg1))
                        ));
                    break;

                case "10":
                    VIEW_SPL_TRANS_REPTableAdapter rep_10 = new VIEW_SPL_TRANS_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\PaintedSpoolInstReq.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_10.GetData(Decimal.Parse(Arg1))));
                    break;
                case "51":
                    dsGalvJobcardTableAdapters.VIEW_COATING_JC_SPL_REPTableAdapter rep_51 = new VIEW_COATING_JC_SPL_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\CoatingRequestSpool.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                       "DataSet1",
                       (DataTable)rep_51.GetData(Decimal.Parse(Arg1))));
                    break;
                case "52":
                    dsGalvJobcardTableAdapters.VIEW_COATING_JC_MAT_REPTableAdapter rep_52 = new VIEW_COATING_JC_MAT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\CoatingRequestMatList.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                       "DataSet1",
                       (DataTable)rep_52.GetData(Decimal.Parse(Arg1))));
                    break;
                case "52.1":
                    dsPaintingRepsTableAdapters.VIEW_COATING_JC_SPL_MAT_REPTableAdapter rep_52_1 = new dsPaintingRepsTableAdapters.VIEW_COATING_JC_SPL_MAT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Coating_Spool_Material.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                       "DataSet1",
                       (DataTable)rep_52_1.GetData(Decimal.Parse(Arg1))));
                    break;
                case "53":
                    dsSpoolReportsDTableAdapters.VIEW_SPOOL_RECEIVE_REPTableAdapter rep_53 = new dsSpoolReportsDTableAdapters.VIEW_SPOOL_RECEIVE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\SpoolReceiveForm.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                       "DataSet1",
                       (DataTable)rep_53.GetData(Decimal.Parse(Arg1))));
                    break;
                case "54":
                    VIEW_SPL_PICKLING_REPTableAdapter rep_54 = new VIEW_SPL_PICKLING_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "SpoolMove\\Reports\\Pickling_Spool.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_54.GetData(Decimal.Parse(Arg1))));
                    break;
              
            }
        }
    }
}