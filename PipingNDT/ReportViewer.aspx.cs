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
using dsNDE_ReportsATableAdapters;

public partial class WeldingInspec_ReportViewer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string ReportID;
            string Arg1;

            ReportID = Request.QueryString["ReportID"];

            Arg1 = Request.QueryString["Arg1"];

            switch (ReportID)
            {
                case "1":
                    VIEW_NDE_REQUESTTableAdapter nde_req = new VIEW_NDE_REQUESTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipingNDT\\Reports\\NDE_Request.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)nde_req.GetData(Decimal.Parse(Arg1))));
                    break;

                case "2":
                    VIEW_NDE_REQUESTTableAdapter rep_2 = new VIEW_NDE_REQUESTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "PipingNDT\\Reports\\NDE_RequestHMD.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_2.GetData(Decimal.Parse(Arg1))));
                    break;
            }
        }
    }
}