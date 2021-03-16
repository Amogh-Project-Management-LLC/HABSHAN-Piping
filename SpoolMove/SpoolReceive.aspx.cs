using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolReceive : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "SPOOL RECEIVE NOTE";
            Master.AddModalPopup("~/SpoolMove/SpoolReceiveNew.aspx", btnNew.ClientID, 500, 650);
            Master.RadGridList = GridItems.ClientID;
        }
    }

    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (GridItems.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Receive Number to Proceed.");
            return;
        }
        Response.Redirect("SpoolReceiveDetail.aspx?id=" + GridItems.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (GridItems.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Receive Number to Proceed.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=53&Arg1=" + GridItems.SelectedValue);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/SpoolMove/SpoolTransSelect.aspx");
    }

    protected void btnBulkImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=24&RetUrl=~/SpoolMove/SpoolReceive.aspx");
    }

    protected void GridItems_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string rcv_id = item.GetDataKeyValue("RCV_ID").ToString();
            string ser_no = WebTools.GetExpr("RCV_NO", "PIP_SPL_RECEIVE", " RCV_ID = " + rcv_id);
            ser_no = ser_no.Replace("/", "-");
            string filename = ser_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_RECEIVE'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_RECEIVE'");

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