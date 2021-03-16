using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsPaintingRepsTableAdapters;
public partial class WeldingInspec_ReportViewer : System.Web.UI.Page
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
                case "1": // Field Joints Paint Report
                    VIEW_REP_JNT_PAINT_DETAILTableAdapter field_jnts_pnt_rep = new VIEW_REP_JNT_PAINT_DETAILTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "WeldingInspec\\REPORTS\\JointsPainting.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsPaintingReps_VIEW_REP_JNT_PAINT_DETAIL",
                        (DataTable)field_jnts_pnt_rep.GetData(decimal.Parse(Arg1))));
                    break;
            }
        }

    }
}