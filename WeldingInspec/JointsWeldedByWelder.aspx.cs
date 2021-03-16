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
using System.Text;
using System.Data.OracleClient;

public partial class JointsWeldedByWelder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Welder Joints <br/>" +
                WebTools.GetExpr("WELDER_NO", "PIP_WELDERS", "WELDER_ID=" + Request.QueryString["WELDER_ID"]);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("WelderRegistration.aspx?Filter=" + Request.QueryString["Filter"]);
    }

    protected void btnExpExcel_Click(object sender, EventArgs e)
    {
        string query = itemsDataSource.SelectCommand.Replace("\r\n", " ").Replace("\t", " ").Replace(":WELDER_ID", Request.QueryString["WELDER_ID"]);
        db_export.ExportToCSV(query, "Joints");
    }
}
