using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_ImportSGText : System.Web.UI.Page
{
    protected static string error_file_location; // = WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT_ERROR'");
    protected static string sg_text_location;   //WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT'");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Spoolgen Text Data";
            LoadInitialData();
        }
    }


    public void LoadInitialData()
    {
        try
        {
            sg_text_location = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\";
            error_file_location = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\ERRORS\\";
            sg_imp_error();
            Session["SessionID"] = Session.SessionID;
            string[] lomfilepaths = Directory.GetFiles(sg_text_location + "LOM\\");
            string[] cutfilepaths = Directory.GetFiles(sg_text_location + "CUTLIST\\");
            string[] weldfilepaths = Directory.GetFiles(sg_text_location + "WELD\\");
            string[] splinfofilepaths = Directory.GetFiles(sg_text_location + "SPOOLINFO\\");
            string[] siteassyfilepaths = Directory.GetFiles(sg_text_location + "SITEASSY\\");

            foreach (var lomfiles in lomfilepaths)
            {
                FileInfo info = new FileInfo(lomfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }

            foreach (var cutfiles in cutfilepaths)
            {
                FileInfo info = new FileInfo(cutfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }

            foreach (var weldfiles in weldfilepaths)
            {
                FileInfo info = new FileInfo(weldfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }

            foreach (var splfiles in splinfofilepaths)
            {
                FileInfo info = new FileInfo(splfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }

            foreach (var assyfiles in siteassyfilepaths)
            {
                FileInfo info = new FileInfo(assyfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AmoghUpdates.aspx");
    }

    private void sg_imp_error()
    {
        // System.IO.Path.GetExtension(IdfMTOUploader.FileName).ToLower()
        string imp_type;

        dsSGImportTableAdapters.VIEW_SG_IMPORT_ERRORTableAdapter sg_imp_err = new dsSGImportTableAdapters.VIEW_SG_IMPORT_ERRORTableAdapter();
        dsSGImport.VIEW_SG_IMPORT_ERRORDataTable sg_imp_dt = new dsSGImport.VIEW_SG_IMPORT_ERRORDataTable();
        try
        {
            sg_imp_dt = sg_imp_err.GetData();
            for (int i = 0; i < sg_imp_dt.Rows.Count; i++)
            {
                imp_type = sg_imp_dt[i].IMPORT_TYPE;

                string dir_path = sg_text_location + imp_type + "\\";

                if (imp_type == "LOM")
                {
                    if (!File.Exists(error_file_location + sg_imp_dt[i].FILE_NAME + "-MATERIAL" + ".txt"))
                    {
                        if (File.Exists(dir_path + sg_imp_dt[i].FILE_NAME + "-MATERIAL" + ".txt"))
                        {
                            File.Copy(dir_path + sg_imp_dt[i].FILE_NAME + "-MATERIAL" + ".txt",
                                error_file_location + sg_imp_dt[i].FILE_NAME + "-MATERIAL" + ".txt");
                        }
                    }
                }

                if (imp_type == "SITEASSY")
                {
                    if (!File.Exists(error_file_location + sg_imp_dt[i].FILE_NAME + "-SITE ASSY" + ".txt"))
                    {
                        if (File.Exists(dir_path + sg_imp_dt[i].FILE_NAME + "-SITE ASSY" + ".txt"))
                        {
                            File.Copy(dir_path + sg_imp_dt[i].FILE_NAME + "-SITE ASSY" + ".txt",
                                error_file_location + sg_imp_dt[i].FILE_NAME + "-SITE ASSY" + ".txt");
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
            return;
        }
        finally
        {
            sg_imp_dt.Dispose();
            sg_imp_err.Dispose();
        }
    }

    protected void txtGo_Click(object sender, EventArgs e)
    {
        string target_location = "", source_location = "", search_string = "";
        try
        {
            source_location = txtLotNumber.Text; //WebTools.GetExpr("SOURCE", "DIR_OBJECTS", "DIR_OBJ='SG_TEXT_FILE_COLLECT'");
            target_location = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\"; //WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_TEXT_FILE_COLLECT'");

            //source_location = source_location + txtLotNumber.Text.Trim() + "\\";
            //target_location = target_location + txtLotNumber.Text.Trim() + "\\";

            //combined_location = target_location + "\\ COMBINED";
            //if (!Directory.Exists(combined_location))
            //    Directory.CreateDirectory(combined_location);

            string[] file_types = { "LOM", "CUTLIST", "SITEASSY", "WELD", "SPOOLINFO" };

            for (int i = 0; i < file_types.Length; i++)
            {
                switch (file_types[i].ToString())
                {
                    case "LOM":
                        search_string = "MATERIAL";
                        break;
                    case "CUTLIST":
                        search_string = "CUT";
                        break;
                    case "SITEASSY":
                        search_string = "SITE";
                        break;
                    case "WELD":
                        search_string = "WELD";
                        break;
                    case "SPOOLINFO":
                        search_string = "SPOOL-INFO";
                        break;
                }

                lblConfirmation.Text = collect_pdfs(source_location, target_location + file_types[i].ToString(), file_types[i].ToString(), search_string);

                //combine all text into one of its category
                //using (var output = new StreamWriter(combined_location + "/" + search_string + ".txt", true))
                //{
                //    foreach (var file in Directory.GetFiles(@target_location + "/" + search_string))
                //    {
                //        using (var input = new StreamReader(file))
                //        {
                //            output.WriteLine(input.ReadToEnd());
                //        }
                //    }
                //}
            }

            txtLotNumber.Text = "";
            txtLotNumber.Focus();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected string collect_pdfs(string root_directory, string target_directory, string file_category, string search_string)
    {
        string message = null;

        try
        {
            if (!Directory.Exists(root_directory))
            {
                return "<font color='red'>" + "Supplied LOT number does not exist in <u>From Indonesia</u> folder, please check again !" + "</font>";
            }

            if (!Directory.Exists(target_directory))
                Directory.CreateDirectory(target_directory);

            //string target_sub_dir = target_directory + search_string;
            //if (!Directory.Exists(target_sub_dir))
            //    Directory.CreateDirectory(target_sub_dir);

            //FIRST SEARCH IN CURRENT DIR
            foreach (string f in Directory.GetFiles(@root_directory))
            {
                string file_name = f.Replace(root_directory, "").Replace("\\", "");

                if (file_name.Contains(search_string) && file_name.ToUpper().EndsWith(".TXT"))
                {
                    File.Copy(f, target_directory + "\\" + file_name, true);
                }
            }

            //SECONDLY SEARCH IN ITS SUB DIRECTORIES
            foreach (string subDir in Directory.GetDirectories(@root_directory))
            {
                foreach (string f in Directory.GetFiles(subDir))
                {
                    string file_name = f.Replace(subDir, "").Replace("\\", "");

                    if (file_name.Contains(search_string) && file_name.ToUpper().EndsWith(".TXT"))
                    {
                        File.Copy(f, target_directory + "\\" + file_name, true);
                    }
                }
                collect_pdfs(subDir, target_directory, search_string, search_string);
            }

            message = "Text file(s) collected successfully into the target location !";
        }
        catch (Exception ex)
        {
            message = "<font color='red'>" + ex.Message + "</font>";
        }
        finally
        {

        }
        return message;
    }


    protected void btnTextDataUpdate_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //sg_text_imported_records
            string query6 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_TEXT_IMPORTED_RECORDS'); END;";
            WebTools.ExeSql(query6);

            string query = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_IMPORT_ERROR'); END;";
            WebTools.ExeSql(query);

            string[] import_types = { "SPOOLINFO", "CUTLIST", "WELD", "SITEASSY", "LOM" };

            try
            {
                //Settings
                WebTools.ExeSql("UPDATE project_setting SET   sg_ignore_and_log__error='" + (chkIgnoreImportError.Checked ? "Y" : "N") + "'" +
                   ", sg_define_new_iso='" + (chkDefineNewIso.Checked ? "Y" : "N") + "', sg_ignore_imported_iso='" + (chkDontUploadImportedISO.Checked ? "Y" : "N") + "'" +
                                                     "WHERE project_id=" + Session["PROJECT_ID"].ToString());

                //Loop through each directory
                foreach (string import_type in import_types)
                {
                    //Get destination table names
                    string table_name = import_type == "CUTLIST" ? "SG_CUT_LIST"
                    : import_type == "LOM" ? "SG_MAT_CONTROL"
                    : import_type == "WELD" ? "SG_WELDING"
                    : import_type == "SPOOLINFO" ? "SG_SPL_INFO"
                    : import_type == "SITEASSY" ? "SG_SITE_ASSEMBLY" : "DUAL";

                    //sg_text_location = WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT'");
                    string file_location = sg_text_location + import_type + "\\";

                    //Loop through each files in the directory
                    //  string file_location = MoveToNewDirectory(import_type);
                    foreach (string strFile in Directory.GetFiles(file_location))
                    {
                        FileInfo fi = new FileInfo(strFile);
                        string full_FileName = fi.FullName;
                        string FileName = fi.Name;
                        using (StreamReader reader = new StreamReader(full_FileName))
                        {
                            string line = "";
                            while ((line = reader.ReadLine()) != null)
                            {
                                line = line.Replace("'", "");
                                //lblMessage.Text = line + "</BR>";
                                try
                                {
                                    WebTools.ExeSql("INSERT INTO sg_text_imported_records(record_row, import_type, file_name)VALUES('" + line + "','" + import_type + "','" + FileName + "')");
                                }
                                catch (Exception exc)
                                {
                                    WebTools.exec_non_qry("INSERT INTO SG_IMPORT_ERROR(PROJECT_ID, FILE_NAME, ERROR_MSG, IMPORT_TYPE) " +
                                        " VALUES('1', '" + FileName + "', 'During import : " + exc.Message + "', '" + import_type + "')");
                                    Master.ShowError(exc.Message);
                                    return;
                                }
                            }
                        }
                    }
                }

                string query7 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_IMPORT_ERR'); END;";
                WebTools.ExeSql(query7);

                string query1 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_CUT_LIST'); END;";
                WebTools.ExeSql(query1);

                string query2 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_MAT_CONTROL'); END;";
                WebTools.ExeSql(query2);

                string query3 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_SITE_ASSEMBLY'); END;";
                WebTools.ExeSql(query3);

                string query4 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_SPL_INFO'); END;";
                WebTools.ExeSql(query4);

                string query5 = "BEGIN EXECUTE IMMEDIATE('TRUNCATE TABLE SG_WELDING'); END;";
                WebTools.ExeSql(query5);
            }
            catch (Exception exc)
            {
                Master.ShowError(exc.Message);
            }

            try
            {
                WebTools.ExeSql("BEGIN  PROC_UPDATE_SG_UPLOADED (" + Session["PROJECT_ID"].ToString() + ");  END;");
                WebTools.ExeSql("BEGIN  update_sg_data;  END;");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "<font color='red'>" + ex.Message + "</font>";
                return;
            }

            //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Spoolgen Text Imported Successfully!!!');", true);

            string errors = WebTools.CountExpr("ERROR_MSG", "SG_IMPORT_ERROR", "PROJECT_ID=" + Session["PROJECT_ID"].ToString());
            string errors2 = WebTools.CountExpr("SQL_ERROR", "packaged_exceptions", "PACKAGE_NAME='PKG_UPDATE_SG_DATA'");
            string total_errors = (Convert.ToInt32(errors) + Convert.ToInt32(errors2)).ToString();
            if (total_errors.Equals("0"))
            {
                lblMessage.Text = "Spoolgen Text Imported Successfully!! Please proceed for Server Updates!";
                //btnTextDataUpdate.Visible = false;
            }
            else
            {
                lblMessage.Text = "<font color='red'>" + total_errors + " error(s) occured during import !" + "</font>";
                //WebTools.ExportDataSetToExcel(SqlDataSource1, "SgImportErrorLog.xls");
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "<font color='red'>" + ex.Message + "</font>";
            return;
        }
    }

    protected void btnErrorExport_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(SqlDataSource1, "SgImportErrorLog.xls");
    }
}