using dsDCS_ReportsTableAdapters;
using dsIsomeControlBTableAdapters;
using System;
using System.Data;
using dsFCRI_ReportsTableAdapters;

public partial class RevisionControl_ReportViewer : System.Web.UI.Page
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
                    VIEW_FCRI_REPTableAdapter rep_1 = new VIEW_FCRI_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "RevisionControl\\Reports\\FCRITrans.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1",
                            (DataTable)rep_1.GetData(decimal.Parse(Request.QueryString["FCRI_ID"]))
                            ));
                    break;
                case "2":
                    VIEW_FCRI_MAT_IMPACTTableAdapter rep_2 = new VIEW_FCRI_MAT_IMPACTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "RevisionControl\\Reports\\FCRI_MatImpact.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1",
                            (DataTable)rep_2.GetData(decimal.Parse(Request.QueryString["FCRI_ID"]))
                            ));
                    break;
                case "3":
                    VIEW_FCRI_WELD_IMPACTTableAdapter rep_3 = new VIEW_FCRI_WELD_IMPACTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "RevisionControl\\Reports\\FCRI_WeldImpact.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(
                        new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1",
                            (DataTable)rep_3.GetData(decimal.Parse(Request.QueryString["FCRI_ID"]))
                            ));
                    break;
            }
        }
    }
}