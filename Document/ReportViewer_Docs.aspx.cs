using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMasterTransTableAdapters;
public partial class Document_ReportViewer_Docs : System.Web.UI.Page
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
                case "1": //Master Transmittal
                    VIEW_DCS_TRANS_REPORTTableAdapter master_trans_rep = new VIEW_DCS_TRANS_REPORTTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "DOCUMENT\\REPORTS\\MasterTrans.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsMasterTrans_VIEW_DCS_TRANS_REPORT",
                        (DataTable)master_trans_rep.GetData(decimal.Parse(Arg1),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;
            }
        }
    }
}