using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolTransferDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "SPOOL TRANSFER DETAIL";
            heading += "<br/>";
            heading += WebTools.GetExpr("TRANS_NO", "PIP_SPL_TRANSFER", " WHERE TRANS_ID='" + Request.QueryString["TRANS_ID"].ToString() + "'");

            Master.HeadingMessage = heading;
            Master.AddModalPopup("~/SpoolMove/SpoolTransferDetailAdd.aspx?TRANS_ID=" + Request.QueryString["TRANS_ID"], btnAddSpool.ClientID, 300, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolTransfer.aspx");
    }
}