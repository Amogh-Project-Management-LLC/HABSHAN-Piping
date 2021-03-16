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

public partial class TestPkg_TestPkg_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Test Package Details (" +
                WebTools.GetExpr("TPK_NUMBER", "TPK_MASTER", " WHERE TPK_ID=" + Request.QueryString["TPK_ID"]) + ")";
        }
    }
    protected void btnBak_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg.aspx");
    }
}