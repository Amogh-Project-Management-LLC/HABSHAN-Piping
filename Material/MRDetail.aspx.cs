using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MRDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Requisition<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " MR_ID='" + Request.QueryString["MR_ID"] + "'");

            Master.AddModalPopup("~/Material/MRItemAdd.aspx?MR_ID=" + Request.QueryString["MR_ID"], btnAdd.ClientID, 450, 650);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MR.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {

    }
}