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

public partial class Material_MaterialStock_JC_MIV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Master.HeadingMessage = "Mat JC MIV : ";
            Master.HeadingMessage += WebTools.GetExpr("MAT_CODE1", "PIP_MAT_STOCK", " MAT_ID = '" + Request.QueryString["MAT_ID"] + "'");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        string url = Request.QueryString["RetUrl"];
        if (string.IsNullOrEmpty(url) || string.IsNullOrWhiteSpace(url))
        {
            Response.Redirect("MaterialStock.aspx");
        }
        else
        {
            Response.Redirect(url);
        }
    }
    protected void btnDWN_Click(object sender, EventArgs e)
    {
        db_export.ExportDataSetToExcel(JCMIVDataSource, "JC_MIV.xls");
    }
}