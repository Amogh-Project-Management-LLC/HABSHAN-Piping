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
using dsHotDipTableAdapters;

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
                    VIEW_HOT_DIP_JOBCARD_REPTableAdapter rep_1 = new VIEW_HOT_DIP_JOBCARD_REPTableAdapter();

                    ReportPreview.LocalReport.ReportPath = @"HotDip\Reports\HotDipSpoolsB.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_1.GetData(decimal.Parse(JC_ID))
                        ));
                    break;

            }
        }
    }
}