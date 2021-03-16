using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialReserve : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Reserve";
            Master.AddModalPopup("~/Material/MaterialReserveAdd.aspx", btnAdd.ClientID, 450, 650);
            Master.RadGridList = gvMatReserve.ClientID;
        }
    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (gvMatReserve.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select Reserve Request No to Proceed.");
            return;
        }

        string reserve_type = WebTools.GetExpr("MAT_RES_TYPE", "MAT_RESERVE", " WHERE MAT_RES_ID='" + gvMatReserve.SelectedValue + "'");
        if (reserve_type == "SG_COMPLETE")
            Response.Redirect("MaterialReserveBOM.aspx?REQ_ID=" + gvMatReserve.SelectedValue);
        else
            Response.Redirect("MaterialReserveItems.aspx?REQ_ID=" + gvMatReserve.SelectedValue);
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        if (gvMatReserve.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select Reserve Request No to Proceed.");
            return;
        }

        string res_type = WebTools.GetExpr("MAT_RES_TYPE", "MAT_RESERVE", " WHERE MAT_RES_ID='" + gvMatReserve.SelectedValue + "'");

        if (res_type == "SG_BALANCE")
            Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=14&RetUrl=~/Material/MaterialReserve.aspx");
        else
            Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=15&RetUrl=~/Material/MaterialReserve.aspx");
    }

    protected void gvMatReserve_ItemDeleted(object sender, Telerik.Web.UI.GridDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            if (e.Exception.Message == "Exception has been thrown by the target of an invocation.")
                Master.ShowError("Child Records Found!!");
            else
                Master.ShowError(e.Exception.Message);
        }
    }
}