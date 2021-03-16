using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatExceptionImportMIR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            string str = "Import ESD Detail (";
            str += WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " WHERE EXCP_ID='" + Request.QueryString["EXCP_ID"] + "'");
            str += ")";

            Master.HeadingMessage(str);
        }
    }

    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {

    }
}