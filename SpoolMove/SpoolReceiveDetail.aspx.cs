using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolReceiveDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Receive Detail";
            Master.HeadingMessage += "<br/>";
            Master.HeadingMessage += WebTools.GetExpr("RCV_NO", "PIP_SPL_RECEIVE", " WHERE RCV_ID=" + Request.QueryString["id"]);
            Master.AddModalPopup("~/SpoolMove/SpoolReceiveImport.aspx?id=" + Request.QueryString["id"], btnAdd.ClientID, 500, 1000);
            
        }
    }

   

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolReceive.aspx");
    }
}