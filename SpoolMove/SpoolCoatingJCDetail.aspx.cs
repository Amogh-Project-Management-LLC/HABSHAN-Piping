using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolCoatingJCDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string str = "Spool Coating JC";
            str += "<br/>";
            str += WebTools.GetExpr("COAT_JC_NO", "PIP_COATING_JC", " WHERE JC_ID='" + Request.QueryString["JC_ID"] + "'");
            Master.HeadingMessage = str;

            Master.AddModalPopup("~/SpoolMove/SpoolCoatingJCDetailAdd.aspx?JC_ID=" + Request.QueryString["JC_ID"], btnAddSpool.ClientID, 370, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolCoatingJC.aspx");
    }
}