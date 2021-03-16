using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using System.IO;

public partial class SpoolMove_SpoolSRN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!IsPostBack)
            {
                string trans = WebTools.GetExpr("TRANS_CAT", "PIP_SPOOL_TRANS_CAT", " WHERE CAT_ID=" +
                    Request.QueryString["CAT_ID"]);
                Master.HeadingMessage = trans;
                if (Session["SPL_TRANS_FILTER"] != null) txtSearch.Text = Session["SPL_TRANS_FILTER"].ToString();
                Master.AddModalPopup("~/SpoolMove/SpoolSRNRegister.aspx?CAT_ID=" + Request.QueryString["CAT_ID"], btnNewTrans.ClientID, 500, 600);
            }
        }
    }

  

    protected void TransGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("SPL_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnViewSpools_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the transmittal.");
            return;
        }
        Response.Redirect("SpoolTransSpools.aspx?CAT_ID=" + Request.QueryString["CAT_ID"] +
            "&TRANS_ID=" + TransGridView.SelectedValue.ToString());
    }
  
    protected void TransGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < TransGridView.PageCount; i++)
        {
            Telerik.Web.UI.DropDownListItem pageListItem =
                new Telerik.Web.UI.DropDownListItem(String.Concat("Page ", i + 1, " of ", TransGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == TransGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }


    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TransGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }


    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the transmittal.");
            return;
        }
        string url;
        string report_id;
        switch (Request.QueryString["CAT_ID"])
        {
            case "1":
                report_id = "1";
                break;
            case "4":
                report_id = "4";
                break;
            case "5":
                report_id = "7";
                break;
            case "6":
                report_id = "6";
                break;
            case "7":
                report_id = "10";
                break;
            default:
                report_id = "3";
                break;
        }
        url = string.Format("ReportViewer.aspx?ReportID={0}&Arg1={1}", report_id,
                TransGridView.SelectedValue.ToString());
        Response.Redirect(url);
    }


    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["SPL_TRANS_FILTER"] = txtSearch.Text;
    }


    //protected void btnMatsReport_Click(object sender, EventArgs e)
    //{
    //    if (TransGridView.SelectedIndexes.Count == 0)
    //    {
    //        Master.ShowMessage("Select the transmittal.");
    //        return;
    //    }
    //    string url;
    //    string report_id;
    //    switch (Request.QueryString["CAT_ID"])
    //    {
    //        case "1":
    //            report_id = "9";
    //            break;
    //        case "5":
    //            report_id = "8";
    //            break;
    //        default:
    //            report_id = "0";
    //            break;
    //    }

    //    if (report_id == "0")
    //    {
    //        Master.ShowMessage("Not available!");
    //        return;
    //    }

    //    url = string.Format("ReportViewer.aspx?ReportID={0}&Arg1={1}", report_id,
    //            TransGridView.SelectedValue.ToString());
    //    Response.Redirect(url);
    //}


    protected void btnBulkImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=22&RetUrl=~/SpoolMove/SpoolTrans.aspx?CAT_ID=" + Request.QueryString["CAT_ID"]);
    }

    //protected void btnDelLocation_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/SpoolMove/SpoolTransDeliveryLoc.aspx?RetUrl=~/SpoolMove/SpoolTrans.aspx?CAT_ID=" + Request.QueryString["CAT_ID"]);

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string trans_id = item.GetDataKeyValue("TRANS_ID").ToString();
            string ser_no = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS", " TRANS_ID = " + trans_id);
            ser_no = ser_no.Replace("/", "-");
            string filename = ser_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SRN'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SRN'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='SRN PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

}//}
