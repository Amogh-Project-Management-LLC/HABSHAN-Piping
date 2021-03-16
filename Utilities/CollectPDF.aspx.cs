using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Upload;

public partial class Utilities_CollectPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Collect PDF Files");
            //Do not display SelectedFilesCount progress indicator.
            RadProgressArea1.ProgressIndicators &= ~ProgressIndicators.SelectedFilesCount;
        }

        RadProgressArea1.Localization.Uploaded = "Total Progress";
        RadProgressArea1.Localization.UploadedFiles = "Progress";
        RadProgressArea1.Localization.CurrentFileName = "File Collection in action: ";
    }

    protected void btnSpoolgenPDF_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("ISO_SPOOLGEN");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void StartCollectingFiles(string FileType)
    {
        string source = WebTools.GetExpr("source", "dir_objects", " dir_obj='" + FileType + "'");
        string destination = WebTools.GetExpr("path", "dir_objects", " dir_obj='" + FileType + "'");

        int FileCount = Directory.GetFiles(source).Count();
        if (FileCount == 0)
        {
            Master.show_info("0 files found at source location.");
            return;
        }
        else
        {
            //UpdateProgressContext(FileCount);
            collect_pdfs(source, destination, FileType);
            Master.show_info(string.Format("{0} files collected from source location.", FileCount.ToString()));
        }
    }
    
    
    protected string collect_pdfs(string source_directory, string target_directory, string specific_file)
    {
        string message = null;

        int Total = Directory.GetFiles(source_directory).Count();

        RadProgressContext progress = RadProgressContext.Current;
        progress.Speed = "N/A";

        int i = 1;
        string iso = string.Empty;
        string spl = string.Empty;
        string id = string.Empty;
        //non replacement drawings
        try
        {
            foreach (string f in Directory.GetFiles(source_directory))
            {
                progress.PrimaryTotal = 1;
                progress.PrimaryValue = 1;
                progress.PrimaryPercent = 100;

                progress.SecondaryTotal = Total;
                progress.SecondaryValue = i;
                progress.SecondaryPercent = Math.Round((double)(i * 100/ Total), 0);

                progress.CurrentOperationText = "Step " + i.ToString();

                if (!Response.IsClientConnected)
                {
                    //Cancel button was clicked or the browser was closed, so stop processing
                    break;
                }

                progress.TimeEstimated = (Total - i) * 100;
                //Stall the current thread for 0.1 seconds
                //System.Threading.Thread.Sleep(100);

                string file_name = f.Replace(source_directory, "").Replace("\\", "").ToUpper();

                //CHECK  if pdf name does not contain SPL then its ISO pdf also ignore PDFs with transmittal name
                if (specific_file.Equals("ISO_SPOOLGEN"))
                {
                    if (file_name.Contains(".PDF") && !file_name.Contains("_SPL-") &&
                        WebTools.CountExpr("SERIAL_NO", "PIP_DWG_TRANS", "SERIAL_NO='" + file_name.Replace(".PDF", "") + "'").Equals("0"))
                    {
                        if (!File.Exists(target_directory + file_name))
                        {
                            File.Copy(f, target_directory + file_name, true);
                            File.Delete(f);
                        }
                        else
                        {
                            //File.Delete(target_directory + file_name);
                            File.Copy(f, target_directory + file_name, true);
                            //File.Replace(f, target_directory + file_name,);
                            File.Delete(f);
                        }

                        //iso = file_name.Replace(".PDF", "");
                        id = WebTools.GetExpr("REV_ID", "VIEW_ISOME_PDF", " WHERE FILE_NAME = '" + file_name + "'");
                        WebTools.ExeSql("UPDATE PIP_REVISION SET ISOSG_PDF_FLG = 'Y' WHERE REV_ID = '" + id + "'");
                    }


                }
                else if (specific_file.Equals("SPL_SPOOLGEN"))
                {
                    if (file_name.Contains(".PDF") && file_name.Contains("_SPL-"))
                        if (!File.Exists(target_directory + file_name))
                        {
                            File.Copy(f, target_directory + file_name, true);
                            File.Delete(f);
                        }
                        else
                        {
                            File.Delete(target_directory + file_name);
                            File.Move(f, target_directory + file_name);
                        }
                    //spl = file_name.Replace(".PDF", "");
                    id = WebTools.GetExpr("SPL_ID", "VIEW_SPOOL_PDF", " WHERE FILE_NAME = '" + file_name + "'");
                    WebTools.ExeSql("UPDATE PIP_SPOOL SET SG_PDF = 'Y' WHERE SPL_ID = '" + id + "'");
                }

                else if (specific_file.Equals("ISO_HARDCOPY") || specific_file.Equals("ISO_MD"))
                {
                    if (file_name.EndsWith(".PDF")) //&& !WebTools.CountExpr("ISO_TITLE1", "PIP_ISOMETRIC", " WHERE ISO_TITLE1 ||'_'|| REV ||'-'|| SCR ||'-'|| FCR LIKE '" + file_name.Replace(".PDF", "") + "%'").Equals("0"))
                    {
                        if (!File.Exists(target_directory + file_name))
                        {
                            File.Copy(f, target_directory + file_name, true);
                            File.Delete(f);
                        }
                        else
                        {
                            File.Delete(target_directory + file_name);
                            File.Copy(f, target_directory + file_name);
                            File.Delete(f);
                        }
                       // iso = file_name.Replace(".PDF", "");
                        id = WebTools.GetExpr("REV_ID", "VIEW_ISOME_PDF", " WHERE FILE_NAME = '" + file_name + "'");
                        if (specific_file.Equals("ISO_HARDCOPY"))
                            WebTools.ExeSql("UPDATE PIP_REVISION SET ISOHC_PDF_FLG = 'Y' WHERE REV_ID = '" + id + "'");
                        else
                            WebTools.ExeSql("UPDATE PIP_REVISION SET ISOMD_PDF_FLG = 'Y' WHERE REV_ID = '" + id + "'");
                    }
                }


                else if (specific_file.Equals("MTC"))
                {
                    if (file_name.EndsWith(".PDF") &&
                        !WebTools.CountExpr("TC_CODE", "PIP_TEST_CARDS", "'" + file_name.Replace(".PDF", "") + "' LIKE TC_CODE||'%'").Equals("0"))
                        if (!File.Exists(target_directory + file_name))
                        {
                            File.Copy(f, target_directory + file_name, true);
                            File.Delete(f);
                        }
                        else
                        {
                            File.Delete(target_directory + file_name);
                            File.Move(f, target_directory + file_name);
                        }
                }
                i++;

            }

            //foreach (string subDir in Directory.GetDirectories(@source_directory))
            //{
            //    collect_pdfs(subDir, target_directory, specific_file);
            //}            
            Master.show_success("PDFs collected successfully ! Please proceed for flag update!");
        }
        catch (Exception ex)
        {
            message = "<font color='red'>" + ex.Message + "</font>";
        }
        return message;
    }

    protected void btnHardcopy_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("ISO_HARDCOPY");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnSplPDF_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("SPL_SPOOLGEN");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("MTC");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void RadButton1_Click(object sender, EventArgs e)
    {
        try
        {
            StartCollectingFiles("ISO_MD");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void UpdateIsomeHCFlag()
    {
        //Isometric Spoolgen Copy
        dsGeneralA.VIEW_ISOME_PDF_HCDataTable dt = new dsGeneralA.VIEW_ISOME_PDF_HCDataTable();
        dsGeneralATableAdapters.VIEW_ISOME_PDF_HCTableAdapter isome_pdf = new dsGeneralATableAdapters.VIEW_ISOME_PDF_HCTableAdapter();
        dt = isome_pdf.GetData();


        RadProgressContext progress = RadProgressContext.Current;
        progress.Speed = "N/A";

        int Total = dt.Rows.Count;
        progress.SecondaryTotal = Total;

        int i = 1;

        foreach (DataRow r in dt.Rows)
        {
            progress.PrimaryTotal = 1;
            progress.PrimaryValue = 1;
            progress.PrimaryPercent = 100;


            progress.TimeEstimated = (Total - i) * 100;

            progress.SecondaryValue = i;
            progress.SecondaryPercent = Math.Round((double)(i * 100 / Total), 0);

            if (File.Exists(r["PDF_TITLE"].ToString()))
                WebTools.ExeSql("UPDATE PIP_REVISION SET ISOHC_PDF_FLG = 'Y' WHERE REV_ID = '" + r["REV_ID"] + "'");

            i++;
        }

    }

    protected void UpdateIsomeSGFlag()
    {
        //Isometric Spoolgen Copy
        dsGeneralA.VIEW_ISOME_PDFDataTable dt = new dsGeneralA.VIEW_ISOME_PDFDataTable();
        dsGeneralATableAdapters.VIEW_ISOME_PDFTableAdapter isome_pdf = new dsGeneralATableAdapters.VIEW_ISOME_PDFTableAdapter();
        dt = isome_pdf.GetDataBy();


        RadProgressContext progress = RadProgressContext.Current;
        progress.Speed = "N/A";

        int Total = dt.Rows.Count;
        progress.SecondaryTotal = Total;

        int i = 1;

        foreach (DataRow r in dt.Rows)
        {
            progress.PrimaryTotal = 1;
            progress.PrimaryValue = 1;
            progress.PrimaryPercent = 100;


            progress.TimeEstimated = (Total - i) * 100;

            progress.SecondaryValue = i;
            progress.SecondaryPercent = Math.Round((double)(i * 100 / Total), 0);

            if (File.Exists(r["PDF_TITLE"].ToString()))
                WebTools.ExeSql("UPDATE PIP_REVISION SET ISOSG_PDF_FLG = 'Y' WHERE REV_ID = '" + r["REV_ID"] + "'");

            i++;
        }

    }

    protected void UpdateSpoolFlag()
    {
        //Spool Copy
        dsGeneralA.VIEW_SPOOL_PDFDataTable dt = new dsGeneralA.VIEW_SPOOL_PDFDataTable();
        dsGeneralATableAdapters.VIEW_SPOOL_PDFTableAdapter spl_pdf = new dsGeneralATableAdapters.VIEW_SPOOL_PDFTableAdapter();
        dt = spl_pdf.GetDataBy();

        RadProgressContext progress = RadProgressContext.Current;
        progress.Speed = "N/A";

        int Total = dt.Rows.Count;
        progress.SecondaryTotal = Total;

        int i = 1;
    
        foreach (DataRow r in dt.Rows)
        {
            progress.PrimaryTotal = 1;
            progress.PrimaryValue = 1;
            progress.PrimaryPercent = 100;

            progress.TimeEstimated = (Total - i) * 100;

            progress.SecondaryValue = i;
            progress.SecondaryPercent = Math.Round((double)(i * 100 / Total), 0);

            if (File.Exists(r["PDF_TITLE"].ToString()))
                WebTools.ExeSql("UPDATE PIP_SPOOL SET SPLSG_PDF_FLG = 'Y' WHERE SPL_ID = '" + r["SPL_ID"] + "'");

            i++;
        }
    }


    protected void RadButton2_Click(object sender, EventArgs e)
    {
        try
        {
            UpdateIsomeSGFlag();
            Master.show_success("Isometric PDF Flag Updated.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void RadButton3_Click(object sender, EventArgs e)
    {
        try
        {
            UpdateSpoolFlag();
            Master.show_success("Spool PDF Flag Updated.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnHCFlag_Click(object sender, EventArgs e)
    {
        try
        {
            UpdateIsomeHCFlag();
            Master.show_success("Spool PDF Flag Updated.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}