using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_SiteSimulation : System.Web.UI.Page
{
    protected static string sml_status = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Site Simulation Settings";
            rdoDwgStatus.SelectedValue = WebTools.GetExpr("DWG_STATUS", "SIMULATION_SETTING", "1=1");
            rdoHoldStatus.SelectedValue = WebTools.GetExpr("EXCLUDE_HOLD", "SIMULATION_SETTING", "1=1");
            rdoSpoolSFR.SelectedValue = WebTools.GetExpr("ON_SFR_FIRST", "SIMULATION_SETTING", "1=1");
            rdoAGUG.SelectedValue = WebTools.GetExpr("AGUG", "SIMULATION_SETTING", "1=1");
            rdoSelectedIsome.SelectedValue = WebTools.GetExpr("ON_SELECTED_ISOME", "SIMULATION_SETTING", "1=1");
            rdoMaterialSource.SelectedValue = WebTools.GetExpr("MATERIAL_SOURCE", "SIMULATION_SETTING", "1=1");
            rdoUseCommonStore.SelectedValue = WebTools.GetExpr("USE_COMMON_STORE", "SIMULATION_SETTING", "1=1");
            rdoSelectedIsome_SelectedIndexChanged(sender, e);
            rdoPriority.SelectedValue = WebTools.GetExpr("SML_PRIORITY", "SIMULATION_SETTING", "1=1");

        }
    }


    protected void btnSaveSettings_Click(object sender, EventArgs e)
    {
        if (sml_status.Equals("RUNNING"))
        {
            Master.ShowError("Simulation already running. System cannot process your request now");
            return;
        }
        Master.ShowSuccess(set_current_page_settings());
    }


    protected void btnIsomeUpload_Click(object sender, EventArgs e)
    {
        //string filepath = "", filename = "";
        //if (splUploader.HasFile)
        //{
        //    string extension = System.IO.Path.GetExtension(splUploader.FileName).ToLower();
        //    if (extension == ".xls" || extension == ".xlsx")
        //    {
        //        // FILE UPLOAD
        //        filename = System.IO.Path.GetFileName(splUploader.FileName);
        //        filepath = WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='TEMP_LOCATION'");
        //        filepath = filepath + "\\SML_ISOMES\\";

        //        //Save the uploaded file into newly created folder
        //        splUploader.SaveAs(filepath + filename);
        //    }
        //    else
        //    {
        //        Master.ShowWarn("Please Select a Excel file !!!");
        //        return;
        //    }
        //}
        //else
        //{
        //    Master.ShowWarn("Please Select a file to upload");
        //    return;
        //}

        ////Update the file into corresponding table
        //DataTable table = null; string query = "", message = "", iso_id = "";
        //try
        //{
        //    //List<DataTable> dt = excelNewImport.ImportExcel(uploadedFileName);
        //    DataSet ds = ExcelImport.ViewData.ExcelData(filepath + filename);
        //    table = ds.Tables[0];

        //    string table_name = "PIP_SML_ISOME";

        //    if (rdoUploadOption.SelectedValue.Equals("DELETE"))
        //    {
        //        WebTools.exec_non_qry("DELETE FROM " + table_name);
        //    }

        //    foreach (DataRow dr in table.Rows)
        //    {
        //        iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");

        //        query = "DELETE FROM " + table_name + " WHERE ISO_ID='" + iso_id + "'";
        //        WebTools.ExeSql(query);
        //    }
        //    string total_isome = table.Rows.Count.ToString();
        //    foreach (DataRow dr in table.Rows)
        //    {
        //        string[] column_names = { "ISO_ID" };
        //        iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");

        //        if (!iso_id.Equals(""))
        //        {
        //            string[] column_values = { iso_id };
        //            query = WebTools.GetInsertQuery(table_name, column_names, column_values);
        //            message = WebTools.ExeSql(query);
        //        }
        //        //lblMessage.Text = dr[0].ToString()+" and iso "+iso_id; return;
        //    }

        //    //lblMessage.Text = query;return;
        //    if (message.Contains("ORA"))
        //        Master.ShowWarn("Error during the process !!! <br/>" + message);
        //    else
        //        Master.show_success(total_isome + " Isometrics for site simulaiton imported successfully!!!");
        //}
        //catch (Exception exc)
        //{
        //    Master.ShowWarn("Error during the process !!! <br/>" + exc.Message);
        //    return;
        //}
        //finally
        //{
        //    //Delete Files after upload complete
        //    string[] all_files = Directory.GetFiles(filepath);

        //    foreach (var file_name in all_files)
        //    {
        //        if (file_name.Contains(".xls") || file_name.Contains(".xlsx") || file_name.Contains(".XLS") || file_name.Contains(".XLSX"))
        //            File.Delete(file_name);
        //    }
        //}
    }

    protected void btnDefault_Click(object sender, EventArgs e)
    {
        if (sml_status.Equals("RUNNING"))
            return;

        //Default Settings
        rdoDwgStatus.SelectedValue = "MCBC";
        rdoHoldStatus.SelectedValue = "Y";
        rdoSpoolSFR.SelectedValue = "Y";
        rdoAGUG.SelectedValue = "BOTH";
        rdoSelectedIsome.SelectedValue = "N";
        rdoPriority.SelectedValue = "Y";
        rdoMaterialSource.SelectedValue = "MRIR";
        rdoUseCommonStore.SelectedValue = "Y";
        rowSelectedIsome.Visible = false;
        Master.ShowSuccess("Default settings applied, click on Save !!!");
    }

    protected string set_current_page_settings()
    {
        string query = "UPDATE SIMULATION_SETTING SET "
            + " SML_CAT='SITE'"
            + ", SITE_SML_TIME=TO_CHAR(SYSDATE,'dd-Mon-yyyy HH:MI AM')"
            + ", SITE_SML_USER='" + Session["USER_NAME"].ToString() + "'"
            + ", DWG_STATUS='" + rdoDwgStatus.SelectedValue + "'"
            + ", ON_SFR_FIRST='" + rdoSpoolSFR.SelectedValue + "'"
            + ", ON_SELECTED_ISOME='" + rdoSelectedIsome.SelectedValue + "'"
            + ", AGUG='" + rdoAGUG.SelectedValue + "'"
            + ", SML_PRIORITY='" + rdoPriority.SelectedValue + "'"
            + ", EXCLUDE_HOLD='" + rdoHoldStatus.SelectedValue + "'"
            + ", MATERIAL_SOURCE='" + rdoMaterialSource.SelectedValue + "'"
            + ", USE_COMMON_STORE='" + rdoUseCommonStore.SelectedValue + "'";
        try
        {
            WebTools.ExeSql(query);
        }
        catch (Exception exc)
        {
            return "<font color='red'>Something went wrong <br/>" + exc.Message + "</font>";
        }
        return "Settings saved !";
    }

    protected void rdoSelectedIsome_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdoSelectedIsome.SelectedValue.Equals("N"))
        {
            rowSelectedIsome.Visible = false;
        }
        else
        {
            rowSelectedIsome.Visible = true;
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(dsExport, "SimulationIsome.xls");
    }

    protected void btnRunSimulation_Click(object sender, EventArgs e)
    {
        if (CollectSubCons())
        {
            if (sml_status.Equals("RUNNING"))
            {
                Master.ShowWarn("Ooops... Simulation is already running !!!");
                return;
            }

            btnSaveSettings_Click(sender, e);

            try
            {
                //CHECK status of 
                //1. PO link
                //2. Line MTO simulation
                //3. Updae server status
                //if not running then proceed

                string po_status = "", any_update_running = "";

                po_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IMPORT_PO_DATA'");
                any_update_running = WebTools.CountExpr("PROCESS_NAME", "PROJECT_JOB_LIST", "PROCESS_GROUP='SERVER_UPDATE' AND CURRENT_STATUS='RUNNING'");

                //If IDF simulation and PO, both are completed
                if (!po_status.Equals("RUNNING") && any_update_running.Equals("0"))
                {
                    string sql = "";
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='SITE_SIMULATION'");
                    sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='SITE_SIMULATION'");

                    WebTools.ExeSql(sql);
                    Master.ShowSuccess("You request for Site simulation has started !!!");
                }
                //If bom simulation is not running
                else
                {
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='SITE_SIMULATION'");
                    Master.ShowSuccess("You request for Simulation process is waiting to run!!!");
                }
                //Response.Redirect("~/UTILITIES/Amogh_Utilities.aspx");
                //UpateProgressContext();
            }
            catch (Exception exc)
            {
                if (exc.Message.Contains("ORA-27478"))
                    Master.ShowWarn("Site simulation is already running !!!");
                else
                    Master.ShowWarn(exc.Message);
            }
        }
    }

    private Boolean CollectSubCons()
    {
        //lblMessage.Text = "";
        var collection = ddSubConSelect.CheckedItems;
        if (collection.Count != 0)
        {
            try
            {
                string query = "DELETE FROM simulation_sub_con WHERE SML_FOR='SITE'";
                WebTools.exec_non_qry(query);

                foreach (var subcon in collection)
                {
                    query = "INSERT INTO simulation_sub_con(SUB_CON_ID,SML_FOR) " +
                        " VALUES (" + WebTools.GetExpr("SUB_CON_ID", "SUB_CONTRACTOR", "SUB_CON_NAME='" + subcon.Text + "'") + ",'SITE')";
                    WebTools.exec_non_qry(query);
                }
            }
            catch (Exception exc)
            {
                Master.ShowWarn(exc.Message);
                return false;
            }
            return true;
        }
        else
        {
            Master.ShowWarn("Select any subcon !");
            return false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Utilities/AmoghUpdates.aspx");
    }
}