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
using iTextSharp;
using iTextSharp.text.pdf;
using System.IO;
using iTextSharp.text;
using Ionic.Zip;
using dsSpoolReportsATableAdapters;
using Microsoft.Reporting.WebForms;
using dsSpoolMoveTableAdapters;
using System.Data.OracleClient;

public partial class Material_FabricationJobCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string filter_ = Session["JC_FILTER"].ToString();
            if (filter_ != "") txtSearch.Text = filter_;

            Master.HeadingMessage = "Job Card";
            Master.AddModalPopup("~/SpoolFabJobCard/JobCardNew.aspx", btnNewJC.ClientID, 500, 600);
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnNewJC.Visible = false;
            }
        }
    }

    

    protected void btnViewSpools_Click(object sender, EventArgs e)
    {
        
        //jcGridView.DataKeys[1].Values["WO_ID"];
        //return;
        if (jcGridView.SelectedIndexes.Count== 0)
        {
            Master.ShowWarn("Select the job card!");
            return;
        }
        Master.HeadingMessage = jcGridView.SelectedIndexes.Count.ToString() + jcGridView.SelectedIndexes[0].ToString();
        string PAINT_CODE = WebTools.GetExpr("PAINT_CODE", "PIP_WORK_ORD", "WO_ID=" + jcGridView.SelectedValue.ToString());
        Response.Redirect("JobCardSpools.aspx?WO_ID=" + jcGridView.SelectedValue.ToString() +
            "&PAINT_CODE=" + PAINT_CODE);
    }

    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void jcGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //if (!WebTools.UserInRole("MM_UPDATE"))
        //{
        //    e.Cancel = true;
        //    Response.Redirect("~/ErrorPages/NoAccess.htm");
        //}
    }

    protected void jcGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < jcGridView.PageCount; i++)
        {
            Telerik.Web.UI.DropDownListItem pageListItem=
                new Telerik.Web.UI.DropDownListItem(String.Concat("Page ", i + 1, " of ", jcGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == jcGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        jcGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (decimal.Parse(cboReports.SelectedValue.ToString()) < 0)
        {
            Master.ShowMessage("Select the entire report!");
            return;
        }
        if (jcGridView.SelectedIndexes.Count== 0)
        {
            Master.ShowMessage("Select the job card!");
            return;
        }

        //preview the report
        string rep_id = cboReports.SelectedValue.ToString();
        string wo_id = jcGridView.SelectedValue.ToString();

        Response.Redirect("ReportViewer.aspx?ReportID=" + rep_id + "&Arg1=" + wo_id);
    }

   
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["JC_FILTER"] = txtSearch.Text;
    }
    protected void btnUpdatePlateMTO_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }

        if (jcGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the job card number!");
            return;
        }

        string result2;

        result2 = WebTools.GetExpr(
            "FNC_INSERT_WO_PLATE(" + jcGridView.SelectedValue.ToString() + ")", "DUAL", "");
        Master.ShowMessage("Updated!");

    }
    protected void btnJC_Plate_Click(object sender, EventArgs e)
    {
        if (jcGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the job card!");
            return;
        }
        Response.Redirect("JobCardPlate.aspx?WO_ID=" + jcGridView.SelectedValue.ToString());
    }
    protected void btnSelectSpls_Click(object sender, EventArgs e)
    {
        if (jcGridView.SelectedIndexes.Count== 0)
        {
            Master.ShowMessage("Select the job card!");
            return;
        }
        Response.Redirect("JobCard_Select.aspx?WO_ID=" + jcGridView.SelectedValue.ToString());
    }

    //Add Text to PDF
    private void add_text_to_pdf(string pdf_path, string new_pdf_path, string text1)
    {
        string oldFile = pdf_path;
        string newFile = new_pdf_path;

        // open the reader
        PdfReader reader = new PdfReader(oldFile);
        Rectangle size = reader.GetPageSizeWithRotation(1);
        Document document = new Document(size);

        FileStream fs = new FileStream(newFile, FileMode.Create, FileAccess.Write);
        PdfWriter writer = PdfWriter.GetInstance(document, fs);
        document.Open();

        // the pdf content
        PdfContentByte cb = writer.DirectContent;

        // create the new page and add it to the pdf
        PdfImportedPage page;

        for (int i = 1; i <= reader.NumberOfPages; i++)
        {

            page = writer.GetImportedPage(reader, i);

            var pageRotation = reader.GetPageRotation(i);
            var pageWidth = reader.GetPageSizeWithRotation(i).Width;
            var pageHeight = reader.GetPageSizeWithRotation(i).Height;

            switch (pageRotation)
            {
                case 0:
                    cb.AddTemplate(page, 1f, 0, 0, 1f, 0, 0);
                    break;

                case 90:
                    cb.AddTemplate(page, 0, -1f, 1f, 0, 0, pageHeight);
                    break;

                case 180:
                    cb.AddTemplate(page, -1f, 0, 0, -1f, pageWidth, pageHeight);
                    break;

                case 270:
                    cb.AddTemplate(page, 0, 1f, -1f, 0, pageWidth, 0);
                    break;

                default:
                    cb.AddTemplate(page, 0, 0);
                    break;
            }

            // select the font properties
            BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            cb.SetColorFill(BaseColor.BLUE);
            //cb.SetFontAndSize(bf, 25);

            float text_x = 0f, text_y = 0f;
            if (pageWidth < 850)
            {
                text_x = 450f;
                text_y = 120f;
                cb.SetFontAndSize(bf, 20);
            }
            else
            {
                text_x = 600f;
                text_y = 160f;
                cb.SetFontAndSize(bf, 25);
            }
            // write the text in the pdf content
            cb.BeginText();
            string text = string.Format("Width: {0}, Height: {1}", pageWidth, pageHeight);
            // put the alignment and coordinates here
            cb.ShowTextAligned(PdfContentByte.ALIGN_LEFT, text, text_x, text_y, 0);
            cb.EndText();

            document.NewPage();
        }
        // close the streams and voilá the file should be changed :)
        document.Close();
        fs.Close();
        writer.Close();
        reader.Close();
    }
    protected void btnCollectPDFs_Click(object sender, EventArgs e)
    {
        if (jcGridView.SelectedIndexes.Count== 0)
        {
            Master.ShowMessage("Select the Jobcard no!");
            return;
        }

        string jc_no = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", "WO_ID=" + jcGridView.SelectedValue.ToString()).Replace("/", "_");
        string path = WebTools.SessionDataPath();
        string zip_file_path = path + jc_no + ".zip";
        
        //ZipFile
        using (ZipFile zip = new ZipFile())
        {
            CollectPDFs(zip);
            zip.Save(zip_file_path);
        }
        
        var updateFile = new FileInfo(zip_file_path);
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("content-disposition", "attachment;filename=\"" + Path.GetFileName(updateFile.FullName) + "\"");
        Response.AddHeader("content-length", updateFile.Length.ToString());
        Response.TransmitFile(updateFile.FullName);
        Response.Flush();
    }
    private void CollectPDFs(ZipFile zip_file)
    {
        //string path = WebTools.SessionDataPath();
        string sql = "";
        string FileName = "";
        string folderPath = WebTools.GetExpr("path", "dir_objects", " dir_obj='ISO_SPOOLGEN'");
        string filePath = string.Empty;
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            //Isometric
            sql = "SELECT * FROM VIEW_ISO_PDF_BLOB_WO WHERE WO_ID=" + jcGridView.SelectedValue.ToString();
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];

                        if (File.Exists(FileName))
                            File.Delete(FileName);

                        //if (dataReader["SG_PDF_BLOB"] == DBNull.Value) continue;

                        //byte[] byteArray = (Byte[])dataReader["SG_PDF_BLOB"];

                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {                           
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }
                       
                    }
                }//OracleDataReader1
            }//OracleCommand1

            //Spool Piece
            sql = "SELECT * FROM VIEW_SPOOL_PDF_WO WHERE WO_ID=" + jcGridView.SelectedValue.ToString();
            folderPath = WebTools.GetExpr("path", "dir_objects", " dir_obj='SPL_SPOOLGEN'");
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];

                        if (File.Exists(FileName))
                            File.Delete(FileName);

                        //if (dataReader["SG_PDF_BLOB"] == DBNull.Value) continue;

                        //byte[] byteArray = (Byte[])dataReader["SG_PDF_BLOB"];
                        //using (FileStream fs = new FileStream(FileName, FileMode.CreateNew, FileAccess.Write))
                        //{
                        //    fs.Write(byteArray, 0, byteArray.Length);
                        //    zip_file.AddFile(FileName, "SPOOL");
                        //}

                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }
                    }
                }//OracleDataReader2
            }//OracleCommand2

            // Iso AS Built
            sql = "SELECT * FROM VIEW_ISO_PDF_BLOB_WO WHERE WO_ID=" + jcGridView.SelectedValue.ToString();
            folderPath = WebTools.GetExpr("path", "dir_objects", " dir_obj='ISO_AB'");
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];

                        if (File.Exists(FileName))
                            File.Delete(FileName);                        
                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }
                    }
                }
            }

        }//OracleConnection
    }

    protected void btnBulkImportSpl_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=13&RetUrl=~/SpoolFabJobCard/JobCard.aspx");
    }



    protected void jcGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("JOBCARD_REQUEST_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("JOBCARD_REQUEST_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
}