using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolTransfer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!IsPostBack)
            {
                Master.HeadingMessage = "Spool Transfer Request";

                Master.AddModalPopup("~/SpoolMove/SpoolTransferNew.aspx", btnNew.ClientID, 520, 550);
                Master.RadGridList = itemsGrid.ClientID;
            }
        }
   
    }

    protected void btnSpool_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select a Transfer Number to Continue.");
            return;
        }
        Response.Redirect("SpoolTransferDetail.aspx?TRANS_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnSpoolPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select a Transfer Number to Continue.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=3.1&Arg1=" + itemsGrid.SelectedValue);
    }

  
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/SpoolMove/SpoolTransSelect.aspx");
    }

    protected void btnBulkImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=23&RetUrl=~/SpoolMove/SpoolTransfer.aspx");
    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string trans_id = item.GetDataKeyValue("TRANS_ID").ToString();
            string ser_no = WebTools.GetExpr("TRANS_NO", "PIP_SPL_TRANSFER", " TRANS_ID = " + trans_id);
            ser_no = ser_no.Replace("/", "-");
            string filename = ser_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_TRANSFER'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_TRANSFER'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='SPOOL TRANSFER PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }

            
           
        }
        
    }
}