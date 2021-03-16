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

public partial class SpoolControl_SpoolStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Status";

            Master.RadGridList = RadGrid1.ClientID;

            //Master.AddModalPopup("~/SpoolMove/SpoolStatusFab.aspx", btnFabStatus.ClientID, 550, 670);
            //Master.AddModalPopup("~/SpoolMove/SpoolStatusPaint.aspx", btnPaintStatus.ClientID, 400, 670);

            WebTools.Check_Session_Variable("popup_SPL_STATUS_ID");
            if (Session["SPOOL_STATUS_SEARCH"] != null)
                txtSearch.Text = Session["SPOOL_STATUS_SEARCH"].ToString();
        }
    }
    private string RadGrid_SPL_ID()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("SPL_ID").ToString();
            }
        }
        return string.Empty;
    }
    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popup_SPL_STATUS_ID"] = RadGrid_SPL_ID();
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToString().ToUpper();
        Session["SPOOL_STATUS_SEARCH"] = txtSearch.Text;
        RadGrid1.DataBind();
    }
    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string spl_id = item.GetDataKeyValue("SPL_ID").ToString();
            string paint_no = WebTools.GetExpr("TRD_COAT_REP", "PIP_PAINTING_SPL_DETAIL", " spl_id = " + spl_id);
            paint_no = paint_no.Replace("/", "-");
            string filename = paint_no + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PAINTING'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PAINTING'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='PAINT PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

}