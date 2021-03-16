using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsHydroTestTableAdapters;
public partial class HydroJC_ReportViewer : System.Web.UI.Page
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
                case "1": //Hydro Test 
                    VIEW_HYDRO_TEST_REPTableAdapter hydro_jc_rep = new VIEW_HYDRO_TEST_REPTableAdapter();
                    ReportPreview.LocalReport.ReportPath = "HydroTest\\REPORTS\\HydroTest_JC.rdlc";
                    ReportPreview.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsHydroTest_VIEW_HYDRO_TEST_REP",
                        (DataTable)hydro_jc_rep.GetData(decimal.Parse(Arg1),
                        Decimal.Parse(Session["PROJECT_ID"].ToString()))));
                    break;
            }
        }
    }
}