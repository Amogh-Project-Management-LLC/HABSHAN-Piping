using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MRIR (";
            Master.HeadingMessage += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID='" + Request.QueryString["MIR_ID"].ToString() + "'");
            Master.HeadingMessage += ")";

            Master.AddModalPopup("~/Material/MatInspDetailAdd.aspx", btnAdd.ClientID, 600, 700);
            Master.AddModalPopup("~/Material/MatInspDetailView.aspx", btnView.ClientID, 600, 700);
            Master.RadGridList = grdMRIRItems.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Material/MatInsp.aspx");
    }

    protected void grdMRIRItems_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popUp_MIR_ITEM_ID"] = grdMRIRItems.SelectedValue;
    }

    protected void btnImportMRV_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatInspDetailImport.aspx?MIR_ID=" + Request.QueryString["MIR_ID"]);
    }
}