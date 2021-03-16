using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_SmlForTemp : System.Web.UI.Page
{
    protected static string mto_file = "", mat_eta_file = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Temporary Simulation");
        }
    }

    protected void btnTempExcelUpload_Click(object sender, EventArgs e)
    {
        if (!mtoUploader.HasFile)
            lblMessage.Text = "<font color='red'>* MTO file required</font>";
        else if (!matEtaUploader.HasFile)
            lblMessage.Text = "<font color='red'>* Material ETA file required</font>";
        else
        {
            if (mtoUploader.HasFile && matEtaUploader.HasFile)
            {
                string mto_file_ext = System.IO.Path.GetExtension(mtoUploader.FileName).ToLower();
                string mat_file_ext = System.IO.Path.GetExtension(matEtaUploader.FileName).ToLower();
                if (mto_file_ext != ".xls" && mto_file_ext != ".xlsx" && mat_file_ext != ".xls" && mat_file_ext != ".xlsx")
                {
                    lblMessage.Text = "<font color='red'>" + "Please select an excel file !" + "</font>";
                }
                else
                {
                    UploadMTOFile();
                    UploadETAFile();
                    btnSimulation.Enabled = true;
                    Master.show_success("Data Uploaded Successfully. Please run the simulation now.");
                }
            }
            else
            {
                lblMessage.Text = "<font color='red'>" + "Please select a file to upload !" + "</font>";
            }
        }
    }

    protected void UploadMTOFile()
    {
        try
        {
            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(mtoUploader.PostedFile.FileName);
            string Extension = Path.GetExtension(mtoUploader.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            mtoUploader.SaveAs(FilePath);

            // delete old data
            WebTools.ExecNonQuery("DELETE FROM TBL_TEMP_SML_MTO_RQRD WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            ExcelImport.ImportDataTable(dt, "TBL_TEMP_SML_MTO_RQRD", "", "PROJECT_ID", proj_id);
        }
        catch (Exception ex)
        {
            Master.show_error("Error MTO File : " + ex.Message);
        }

    }

    protected void UploadETAFile()
    {
        try
        {
            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(matEtaUploader.PostedFile.FileName);
            string Extension = Path.GetExtension(matEtaUploader.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            matEtaUploader.SaveAs(FilePath);

            // delete old data
            WebTools.ExecNonQuery("DELETE FROM TBL_TEMP_SML_MAT_ETA WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            ExcelImport.ImportDataTable(dt, "TBL_TEMP_SML_MAT_ETA", "", "PROJECT_ID", proj_id);
        }
        catch (Exception ex)
        {
            Master.show_error("Error ETA File : " + ex.Message);
        }
    }

    protected void btnSimulation_Click(object sender, EventArgs e)
    {
        try
        {
            //CHECK status of 
            //1. PO link
            //2. Line MTO simulation
            //3. Updae server status
            //if not running then proceed

            string po_status = "", any_update_running = "", temp_sml_status = "";

            temp_sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='TEMP_SIMULATION'");
            if (temp_sml_status.Equals("RUNNING"))
            {
                lblMessage.Text = "Temp Simulation is already running!!!";
                return;
            }

            po_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IMPORT_PO_DATA'");

            any_update_running = WebTools.CountExpr("PROCESS_NAME", "PROJECT_JOB_LIST"
                , "PROCESS_GROUP='SERVER_UPDATE' AND CURRENT_STATUS='RUNNING'");

            //If IDF simulation and PO, both are completed
            if (!po_status.Equals("RUNNING") && any_update_running.Equals("0"))
            {
                string sql = "";
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='TEMP_SIMULATION'");
                sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='TEMP_SIMULATION'");
                WebTools.ExeSql(sql);
                lblMessage.Text = "You request is under process, please wait...";
            }
            //If bom simulation is not running
            else
            {
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='TEMP_SIMULATION'");
            }
            Master.show_info("Close the window and check the progress Utilities Page !");
        }
        catch (Exception exc)
        {
            Master.show_error(exc.Message);
        }
    }
}