using dsPaintingMatTableAdapters;
using dsPaintingRepsTableAdapters;
using System;
using System.Data;

public partial class PaintISO_PaintISO_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID, Arg1;
            string PAINT_ID;
            string DateFrom;
            string DateTo;

            Arg1 = Request.QueryString["Arg1"];
            ReportID = Request.QueryString["ReportID"];
            PAINT_ID = Request.QueryString["PAINT_ID"];
            DateFrom = Request.QueryString["DateFrom"];
            DateTo = Request.QueryString["DateTo"];

            switch (ReportID)
            {
                case "4":
                case "4.1":
                    VIEW_PAINTING_MAT_REPTableAdapter rep_4 = new VIEW_PAINTING_MAT_REPTableAdapter();
                    if (ReportID == "4")
                    {
                        ReportPreview.LocalReport.ReportPath = @"Painting\Reports\PaintBulk_Summary.rdlc";
                    }
                    else
                    {
                        ReportPreview.LocalReport.ReportPath = @"Painting\Reports\PaintBulk_SummaryBlind.rdlc";
                    }
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsPaintingMat_VIEW_PAINTING_MAT_REP",
                        (DataTable)rep_4.GetData(decimal.Parse(PAINT_ID))
                        ));
                    break;

                case "5":
                    VIEW_PAINTING_MAT_REPTableAdapter rep_5 = new VIEW_PAINTING_MAT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"Painting\Reports\PaintBulk_MaterialReq.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsPaintingMat_VIEW_PAINTING_MAT_REP",
                        (DataTable)rep_5.GetData(decimal.Parse(PAINT_ID))
                        ));
                    break;

                case "6":
                    VIEW_LINE_MTO_PAINT_REPTableAdapter rep_6 = new VIEW_LINE_MTO_PAINT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"Painting\Reports\PaintingAvailableVsIssued.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsPaintingReps_VIEW_LINE_MTO_PAINT_REP",
                        (DataTable)rep_6.GetData(
                        DateFrom,
                        DateTo,
                        decimal.Parse(Session["PROJECT_ID"].ToString())
                        )));
                    break;

                case "7":
                    VIEW_PAINTING_MAT_REPTableAdapter rep_7 = new VIEW_PAINTING_MAT_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"Painting\Reports\PaintBulk_MaterialReturn.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsPaintingMat_VIEW_PAINTING_MAT_REP",
                        (DataTable)rep_7.GetData(decimal.Parse(PAINT_ID))
                        ));
                    break;
                case "8":
                    dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_REPTableAdapter rep_8 = new VIEW_BULK_PAINT_ISSUE_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = @"Painting\Reports\PaintBulk_MIV.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_8.GetData(decimal.Parse(Arg1))
                        ));
                    break;
            }
        }
    }
}