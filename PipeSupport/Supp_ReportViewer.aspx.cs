using dsSupp_ATableAdapters;
using dsSupp_BTableAdapters;
using dsSupp_CTableAdapters;
using dsSupp_DTableAdapters;
using dsSupp_ETableAdapters;
//using dsSupp_FTableAdapters;
using dsSupp_GTableAdapters;
using Microsoft.Reporting.WebForms;
using System;
using System.Data;

public partial class Supp_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Preview Report";
            string ReportID;
            string Arg1, Arg2, Arg3;
            ReportID = Request.QueryString["ReportID"];
            Arg1 = Request.QueryString["Arg1"];
            Arg2 = Request.QueryString["Arg2"];
            Arg3 = Request.QueryString["Arg3"];

            string wo_name = "";
            switch (ReportID)
            {
                case "1":
                case "2":
                case "3":
                case "4":
                    wo_name = WebTools.GetExpr("JC_NO", "PIP_SUPP_JC", "JC_ID=" + Arg1);
                    break;

                default:
                    break;
            }

            switch (ReportID)
            {
                case "1":
                    ReportPreview.LocalReport.DisplayName = wo_name + " Iso Wise";
                    VIEW_SUPP_JC_ISOTableAdapter sup_summary = new VIEW_SUPP_JC_ISOTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_JobCard.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_C_VIEW_SUPP_JC_ISO",
                        (DataTable)sup_summary.GetData(decimal.Parse(Arg1))));
                    break;

                case "2":
                    ReportPreview.LocalReport.DisplayName = wo_name + " Pick Ticket";
                    VIEW_SUPP_JC_MATSTableAdapter mat_summary = new VIEW_SUPP_JC_MATSTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_JobCard_Mats.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_D_VIEW_SUPP_JC_MATS",
                        (DataTable)mat_summary.GetData(decimal.Parse(Arg1))));
                    break;

                case "3":
                    ReportPreview.LocalReport.DisplayName = wo_name + " Summary";
                    VIEW_SUPP_JC_SUMMARYTableAdapter mat_summary2 = new VIEW_SUPP_JC_SUMMARYTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_JobCard_Summary.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_C_VIEW_SUPP_JC_SUMMARY",
                        (DataTable)mat_summary2.GetData(decimal.Parse(Arg1))));
                    break;

                case "4":
                    ReportPreview.LocalReport.DisplayName = wo_name + " PCWBS";
                    VIEW_SUPP_JC_AREATableAdapter rep_4 = new VIEW_SUPP_JC_AREATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_JobCard_Area.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_4.GetData(decimal.Parse(Arg1))));
                    break;

                case "6":
                    VIEW_BOM_SUPP_REP_ATableAdapter supp_inst = new VIEW_BOM_SUPP_REP_ATableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_Install_Rep.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_D_VIEW_BOM_SUPP_REP_A",
                        (DataTable)supp_inst.GetData(decimal.Parse(Session["PROJECT_ID"].ToString()),
                        Arg1, Arg2, Arg3)));
                    break;

                case "7":
                    VIEW_SUPP_PACKING_REPTableAdapter packing_list = new VIEW_SUPP_PACKING_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_PackingList.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_A_VIEW_SUPP_PACKING_REP",
                        (DataTable)packing_list.GetData(
                        decimal.Parse(Request.QueryString["PACKING_ID"])
                        )));
                    break;

                case "8":
                    VIEW_SUPP_RECEIVE_REPTableAdapter supp_recv = new VIEW_SUPP_RECEIVE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"PipeSupport\Reports\Supp_Receive.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_E_VIEW_SUPP_RECEIVE_REP",
                        (DataTable)supp_recv.GetData(
                        decimal.Parse(Request.QueryString["RECV_ID"])
                        )));
                    break;

                case "11":
                    VIEW_SUPP_SWN_REPTableAdapter rep_11 = new VIEW_SUPP_SWN_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_SWN.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_D_VIEW_SUPP_SWN_REP",
                        (DataTable)rep_11.GetData(
                        decimal.Parse(Arg1)
                        )));
                    break;

                case "12":
                    VIEW_SUPP_REL_REPTableAdapter rep_12 = new VIEW_SUPP_REL_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipeSupport\\Reports\\Supp_Release.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSupp_E_VIEW_SUPP_REL_REP",
                        (DataTable)rep_12.GetData(
                        decimal.Parse(Arg1)
                        )));
                    break;

                case "14":
                    VIEW_SUPP_SHIP_JC_REPTableAdapter rep_14 = new VIEW_SUPP_SHIP_JC_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"PipeSupport\Reports\Supp_ShippingJC.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_14.GetData(
                        decimal.Parse(Request.QueryString["SHIP_ID"])
                        )));
                    break;

                case "15":
                    VIEW_SUPP_REQUEST_REPTableAdapter rep_15 = new VIEW_SUPP_REQUEST_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"PipeSupport\Reports\Supp_Issue_Form.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_15.GetData(
                        decimal.Parse(Request.QueryString["REQ_ID"])
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
            case "2":
                //VIEW_SUPP_JC_COATING_REPTableAdapter dcutlen_detail = new VIEW_SUPP_JC_COATING_REPTableAdapter();
                //e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                //    "dsSupp_D_VIEW_SUPP_JC_COATING_REP", dcutlen_detail.GetData(decimal.Parse(Request.QueryString["Arg1"]))));
                break;
        }
    }

}