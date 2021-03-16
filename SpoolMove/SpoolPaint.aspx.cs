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
using Microsoft.Reporting.WebForms;
using Ionic.Zip;
using System.IO;
using dsSpoolMoveTableAdapters;
using dsSpoolReportsATableAdapters;
using dsWeldingReportsBTableAdapters;
using dsSpoolReportsCTableAdapters;

public partial class SpoolMove_SpoolPaint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Painting";
            Master.AddModalPopup("~/SpoolMove/SpoolPaintNew.aspx", btnNewTrans.ClientID, 550, 650);
            Master.RadGridList = TransGridView.ClientID;
        }
    }
    protected void btnNewTrans_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolPaintNew.aspx");
    }
    protected void btnViewSpls_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the paint request no!");
            return;
        }
        Response.Redirect("SpoolPaintItems.aspx?SPL_PNT_ID=" + TransGridView.SelectedValue.ToString());
    }
    protected void TransGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < TransGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", TransGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == TransGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TransGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
  
    protected void TransGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //if (!WebTools.UserInRole("SPL_UPDATE"))
        //{
        //    Master.ShowWarn("Access Denied!");
        //    e.Cancel = true;
        //}
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the paint Request/ Report number!");
            return;
        }

        Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() + "&Arg1=" +
             TransGridView.SelectedValue.ToString());
    }
    
    protected void btnSCR_PDF_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the paint request no!");
            return;
        }

        Warning[] warnings;
        string[] streamids;
        string mimeType;
        string encoding;
        string filenameExtension;
        string rep_id;
        string spl_id;
        string spl_title;
        int i = 0;

        string path = WebTools.SessionDataPath();
        string pdf_file = string.Empty;
        string zip_file = path + "spool_clear.zip";
        dsSpoolMove.PIP_PAINTING_SPL_DETAILRow row;

        //New
        PIP_PAINTING_SPL_DETAILTableAdapter adp = new PIP_PAINTING_SPL_DETAILTableAdapter();
        dsSpoolMove.PIP_PAINTING_SPL_DETAILDataTable table = new dsSpoolMove.PIP_PAINTING_SPL_DETAILDataTable();
        table = adp.GetData(decimal.Parse(TransGridView.SelectedValue.ToString()), "%");

        if (string.IsNullOrEmpty(txtSCRFrom.Text)) txtSCRFrom.Text = "1";
        if (string.IsNullOrEmpty(txtSCRTo.Text)) txtSCRTo.Text = table.Rows.Count.ToString();

        if (int.Parse(txtSCRTo.Text) > table.Rows.Count)
        {
            txtSCRTo.Text = table.Rows.Count.ToString();
        }

        if (int.Parse(txtSCRFrom.Text) >= table.Rows.Count)
        {
            Master.ShowWarn(string.Format("Total {0} rows found!", table.Rows.Count));

            if (table != null)
            {
                table.Dispose();
            }

            if (adp != null)
            {
                adp.Dispose();
            }
            return;
        }
        //table.Rows.Count
        //ZipFile
        using (ZipFile zip = new ZipFile())
        {
            ReportViewer reportViewer = new ReportViewer();
            reportViewer.LocalReport.EnableExternalImages = true;

            for (int k = int.Parse(txtSCRFrom.Text) - 1; k < int.Parse(txtSCRTo.Text); k++)
            {
                row = table.Rows[k] as dsSpoolMove.PIP_PAINTING_SPL_DETAILRow;
                reportViewer.LocalReport.DataSources.Clear();
                //Add PDF to Zip
                spl_id = row.SPL_ID.ToString();
                rep_id = WebTools.get_scr_rep_id(spl_id);

                spl_title = WebTools.GetExpr("ISO_TITLE1 || '-' || SPOOL", "VIEW_SPOOL_TITLE", "SPL_ID=" + spl_id);
                if (rep_id == "200")
                {
                    reportViewer.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(ReportPreview_SubreportProcessing);

                    VIEW_SPL_CLR_HSTableAdapter spool_hs_a = new VIEW_SPL_CLR_HSTableAdapter();
                    reportViewer.LocalReport.ReportPath = @"BasicReports\Spool\SpoolClear_HistorySheet_A.rdlc";
                    reportViewer.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SPL_CLR_HS",
                        (DataTable)spool_hs_a.GetDataBySPL_ID(Decimal.Parse(spl_id))));

                }
                else if (rep_id == "203")
                {
                    VIEW_SFR_RELEASETableAdapter sfr_release_a = new VIEW_SFR_RELEASETableAdapter();
                    reportViewer.LocalReport.ReportPath = @"BasicReports\Spool\SFR_Release_A.rdlc";
                    reportViewer.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "dsSpoolReportsA_VIEW_SFR_RELEASE",
                        (DataTable)sfr_release_a.GetData(Decimal.Parse(spl_id))));
                }
                else if (rep_id == "203.1")
                {
                    VIEW_SPL_CLR_HS_MATTableAdapter rep_203_1 = new VIEW_SPL_CLR_HS_MATTableAdapter();
                    reportViewer.LocalReport.ReportPath = "BasicReports\\Spool\\SingleMaterialSpoolClear.rdlc";
                    reportViewer.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                        "DataSet1",
                        (DataTable)rep_203_1.GetData(Decimal.Parse(spl_id))));
                }

                byte[] bytes = reportViewer.LocalReport.Render(
                                "PDF", null, out mimeType, out encoding, out filenameExtension, out streamids, out warnings);

                pdf_file = path + spl_title + ".pdf";

                using (FileStream fs = new FileStream(pdf_file, FileMode.Create))
                {
                    fs.Write(bytes, 0, bytes.Length);
                    zip.AddFile(pdf_file, "PDF");
                    i++;
                }
            }

            zip.Save(zip_file);
        }

        if (table != null)
        {
            table.Dispose();
        }

        if (adp != null)
        {
            adp.Dispose();
        }

        var updateFile = new FileInfo(zip_file);
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("content-disposition", "attachment;filename=\"" + Path.GetFileName(updateFile.FullName) + "\"");
        Response.AddHeader("content-length", updateFile.Length.ToString());
        Response.TransmitFile(updateFile.FullName);
        Response.Flush();
    }

    protected void ReportPreview_SubreportProcessing(Object sender, SubreportProcessingEventArgs e)
    {
        PIP_JOINT_REVTableAdapter jnt_rev = new PIP_JOINT_REVTableAdapter();
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
            "dsWeldingReportsB_PIP_JOINT_REV",
            (DataTable)jnt_rev.GetData()));
    }

    protected void btnSCR_PDF1_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the paint request no!");
            return;
        }

        txtSCRFrom.Visible = !txtSCRFrom.Visible;
        txtSCRTo.Visible = !txtSCRTo.Visible;
        btnSCR_PDF.Visible = !btnSCR_PDF.Visible;

        if (!txtSCRTo.Visible) return;

        PIP_PAINTING_SPL_DETAILTableAdapter adp = new PIP_PAINTING_SPL_DETAILTableAdapter();
        dsSpoolMove.PIP_PAINTING_SPL_DETAILDataTable table = new dsSpoolMove.PIP_PAINTING_SPL_DETAILDataTable();
        table = adp.GetData(decimal.Parse(TransGridView.SelectedValue.ToString()),"%");
        try
        {
            txtSCRFrom.Text = "1";
            txtSCRTo.Text = table.Rows.Count.ToString();
        }
        finally
        {
            table.Dispose();
            adp.Dispose();
        }
    }

    protected void btnBulkImportSpl_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=21&RetUrl=~/SpoolMove/SpoolPaint.aspx");
    }

    protected void btnPreview_Click1(object sender, EventArgs e)
    {

    }

    protected void TransGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("SPOOL_PAINT_REQUEST_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("SPOOL_PAINT_REQUEST_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
}