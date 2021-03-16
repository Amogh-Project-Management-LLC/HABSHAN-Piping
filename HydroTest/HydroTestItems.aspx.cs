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
using dsHydroTestTableAdapters;

public partial class HydroTest_HydroTestItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string trans_no = WebTools.GetExpr("TEST_NO", "PIP_HYDRO_TEST",
                "TEST_ID=" + Request.QueryString["TEST_ID"]);
            Master.HeadingMessage = "Hydro Test Joints <br/>" + trans_no;
        }
    }
   
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("HydroTest_Spools.aspx?TEST_ID=" + Request.QueryString["TEST_ID"]);
    }
  
}