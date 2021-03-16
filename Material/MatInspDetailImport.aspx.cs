using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspDetailImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MRIR Import";
            Master.HeadingMessage += "<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " WHERE MIR_ID='" + Request.QueryString["MIR_ID"] + "'");

            HiddenField1.Value = WebTools.GetExpr("MRV_ID", "PRC_MAT_INSP", " WHERE MIR_ID = '" + Request.QueryString["MIR_ID"] + "'");
        }
    }
}