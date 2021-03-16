using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialStatusReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MATERIAL STATUS (MSR)";
        }
    }

    protected void RadMenu1_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0 && e.Item.Value != "DOWNLOAD" && e.Item.Value != "SHORTAGE")
        {
            Master.ShowError("Select Material Code to Proceed.");
            return;
        }
        switch (e.Item.Value)
        {
            case "LINE_MTO":
                Response.Redirect("MaterialStock_LineMTO.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "ISO_MTO":
                Response.Redirect("MaterialStock_iso_mto.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "MR":
                Response.Redirect("MaterialStock_Requisition.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "PO":
                Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "MRV":
                Response.Redirect("MaterialStock_Received.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "MRIR":
                Response.Redirect("MaterialStock_MRIR.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "ESD":
                Response.Redirect("MaterialStock_ESD.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "JC":
                Response.Redirect("MaterialStock_JC.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "JC_MIV":
                Response.Redirect("MaterialStock_JC_MIV.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "SITE_MIV":
                Response.Redirect("MaterialStock_SITE_MIV.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "ADD_ISSUE":
                Response.Redirect("MaterialStock_Add_Issue.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "TRANSF":
                Response.Redirect("MaterialStock_Transfer.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "HEAT_NO":
                Response.Redirect("MaterialStock_HeatNo.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "MTC":
                Response.Redirect("MaterialStock_MTC.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "BOM":
                Response.Redirect("MaterialStock_BOM_QTY.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "JOINT_LIST":
                Response.Redirect("MaterialStock_Joints.aspx?MAT_ID=" + itemsGrid.SelectedValue + "&RetUrl=MaterialStatusReport.aspx");
                break;
            case "DOWNLOAD":
                WebTools.ExportDataSetToExcel(sqlDownloadSource, "Material_Status_Report.xls");
                break;
            case "SHORTAGE":
                WebTools.ExportDataSetToExcel(sqlDownShort, "Material_Shortage.xls");
                break;
        }
    }
}