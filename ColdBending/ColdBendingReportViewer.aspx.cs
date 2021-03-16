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
using dsCoolBendingTableAdapters;

public partial class ColdBending_ColdBendingReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;
            String JC_ID;
            ReportID = Request.QueryString["ReportID"];
            JC_ID = Request.QueryString["JC_ID"];
            switch (ReportID)
            {
                case "1":
                    VIEW_COOL_BENDING_JC_REPTableAdapter rep_1 = new VIEW_COOL_BENDING_JC_REPTableAdapter();

                    ReportPreview.LocalReport.ReportPath = @"ColdBending\Reports\ColdBendingDetail.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsCoolBending_VIEW_COOL_BENDING_JC_REP",
                        (DataTable)rep_1.GetData(decimal.Parse(JC_ID))
                        ));
                    break;

                case "2":
                    VIEW_COOL_BENDING_JC_SUMMARYTableAdapter rep_2 = new VIEW_COOL_BENDING_JC_SUMMARYTableAdapter();

                    ReportPreview.LocalReport.ReportPath = @"ColdBending\Reports\ColdBendingMaterial.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsCoolBending_VIEW_COOL_BENDING_JC_SUMMARY",
                        (DataTable)rep_2.GetData(decimal.Parse(JC_ID))
                        ));
                    break;

                case "3":
                    VIEW_COOL_BENDING_JC_PAINTTableAdapter rep_3 = new VIEW_COOL_BENDING_JC_PAINTTableAdapter();

                    ReportPreview.LocalReport.ReportPath = @"ColdBending\Reports\ColdBendingPaint.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsCoolBending_VIEW_COOL_BENDING_JC_PAINT",
                        (DataTable)rep_3.GetData(decimal.Parse(JC_ID))
                        ));
                    break;

            }
        }
    }
}