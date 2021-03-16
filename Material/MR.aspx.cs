using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Requisition";

            Master.AddModalPopup("~/Material/MRAdd.aspx", btnAdd.ClientID, 450, 650);
            Master.AddModalPopup("~/Material/MRImport.aspx", btnImport.ClientID, 400, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnItems_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please select a row to continue.");
            return;
        }
        Response.Redirect("MRDetail.aspx?MR_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlDownload, "Material_Requisition.xls");
    }

    protected void btnPOBal_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlPOBalance, "PO_Balance.xls");
    }
}