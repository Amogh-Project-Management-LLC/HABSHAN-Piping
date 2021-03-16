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

public partial class SpoolMove_SpoolTrans : System.Web.UI.Page
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
                Master.AddModalPopup("~/SpoolMove/SpoolTransRegister.aspx?CAT_ID=" + Request.QueryString["CAT_ID"], btnNewTrans.ClientID, 500, 600);
                
            }
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolTransSelect.aspx");
    }
    protected void TransGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //if (!WebTools.UserInRole("SPL_UPDATE"))
        //{
        //    Master.ShowWarn("Access Denied!");
        //    e.Cancel = true;
        //}
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
            case "16":
                report_id = "3.2";
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
    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string trans_id = item.GetDataKeyValue("TRANS_ID").ToString();
            string ser_no = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS", " TRANS_ID = " + trans_id);
            ser_no = ser_no.Replace("/", "-");
            string filename = ser_no + ".pdf";
            string cat_id = Request.QueryString["CAT_ID"];
            string pdf_url = "";
            string pdf_asp_url="";

            switch (cat_id)
            {
                case "10":
                     pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'ARN'");
                     pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'ARN'");
                    break;
                case "16":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_IRN'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_IRN'");
                    break;
                case "2":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPOOL_REQUEST'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPOOL_REQUEST'");
                    break;
                case "8":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SRN'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SRN'");
                    break;
                case "15":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPOOL_RELEASE'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPOOL_RELEASE'");
                    break;
                case "5":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_SITE_INSP'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_SITE_INSP'");
                    break;

                case "12":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_TO_SITE_SC'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'SPL_TO_SITE_SC'");
                    break;
            }

            

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title=' PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }
    protected void btnSplHistory_Click(object sender, EventArgs e)
    {
        try
        {
            string user_name = Session["USER_NAME"].ToString();
            string Delsql = "DELETE FROM BULK_SPOOL_DOWNLOAD WHERE USER_NAME = '" + Session["USER_NAME"] + "'";
            WebTools.ExeSql(Delsql);
            string sql = "INSERT INTO BULK_SPOOL_DOWNLOAD (ISO_TITLE1, SPOOL_NO, USER_NAME)" +
                "SELECT  iso_title1,spool,'" + user_name + "' FROM pip_isometric, pip_spool, PIP_SPOOL_TRANS_DETAIL " +
                "WHERE pip_isometric.iso_id = pip_spool.iso_id AND pip_spool.spl_id = PIP_SPOOL_TRANS_DETAIL.spl_id " +
                "And trans_id='" + TransGridView.SelectedValue + "'";
            WebTools.ExeSql(sql);
            Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=200.1");
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }

    }

    protected void btnSFRHistory_Click(object sender, EventArgs e)
    {
        try
        {
            string user_name = Session["USER_NAME"].ToString();
            string Delsql = "DELETE FROM BULK_SPOOL_DOWNLOAD WHERE USER_NAME = '" + Session["USER_NAME"] + "'";
            WebTools.ExeSql(Delsql);
            string sql = "INSERT INTO BULK_SPOOL_DOWNLOAD (ISO_TITLE1, SPOOL_NO, USER_NAME)" +
                "SELECT  iso_title1,spool,'" + user_name + "' FROM pip_isometric, pip_spool, PIP_SPOOL_TRANS_DETAIL " +
                "WHERE pip_isometric.iso_id = pip_spool.iso_id AND pip_spool.spl_id = PIP_SPOOL_TRANS_DETAIL.spl_id " +
                "And trans_id='" + TransGridView.SelectedValue + "'";
            WebTools.ExeSql(sql);
            Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=200.2");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void TransGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("SPOOL_TRANS_REQUEST_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("SPOOL_TRANS_REQUEST_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
}