using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Utilities_ShopSimulation : System.Web.UI.Page
{
    string sml_status, sml_cat;
    protected void Page_Load(object sender, EventArgs e)
    {
        sml_cat = "SHOP";
        try
        {
            if (!IsPostBack)
            {
                RadTabStrip1.Tabs[0].Selected = true;
                RadMultiPage1.SelectedIndex = 0;

                if (Session["SML_SHOP_LAST_TAB"] != null)
                {
                    RadMultiPage1.SelectedIndex = Int32.Parse(Session["SML_SHOP_LAST_TAB"].ToString());
                    RadTabStrip1.SelectedIndex = Int32.Parse(Session["SML_SHOP_LAST_TAB"].ToString());
                }

                lblSmlUser.Text = WebTools.GetExpr("SML_USER", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                lblSmlTime.Text = WebTools.GetExpr("SML_TIME", "SIMULATION_SETTING", "  WHERE SML_CAT='" + sml_cat + "'");
                sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = 'BOM_SIMULATION'");
                //SET status for all the fields
                rdoDwgStatus.SelectedValue = WebTools.GetExpr("DWG_STATUS", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoHoldStatus.SelectedValue = WebTools.GetExpr("EXCLUDE_HOLD", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoSpoolSFR.SelectedValue = WebTools.GetExpr("ON_SFR_FIRST", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoAGUG.SelectedValue = WebTools.GetExpr("AGUG", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoMaterialSource.SelectedValue = WebTools.GetExpr("MATERIAL_SOURCE", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoSelectedSpools.SelectedValue = WebTools.GetExpr("ON_SELECTED_SPOOLS", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoUseCommonStore.SelectedValue = WebTools.GetExpr("USE_COMMON_STORE", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoSelectedSpools_SelectedIndexChanged(sender, e);

                rdoPriority.SelectedValue = WebTools.GetExpr("SML_PRIORITY", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");

                //refresh_Clicked(sender, e);

                Master.HeadingMessage = "Shop Simulation";
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }


    protected void btnSaveSettings_Click(object sender, EventArgs e)
    {
        try
        {
            string sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = 'BOM_SIMULATION'");
            if (sml_status.Equals("RUNNING"))
            {
                Master.ShowWarn("Simulation Already Running. Please Try Again Later.");
                return;
            }
            string message = set_current_page_settings();
            Master.ShowSuccess(message);
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnSplUpload_Click(object sender, EventArgs e)
    {
        string filepath = "", filename = "";
        string sql, iso_id, spl_id, spl_id2;
        if (splUploader.HasFile)
        {
            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(splUploader.PostedFile.FileName);
            string Extension = Path.GetExtension(splUploader.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            splUploader.SaveAs(FilePath);

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            try
            {
                switch (rdoUploadOption.SelectedValue)
                {
                    case "DELETE":
                        sql = "DELETE FROM PIP_SML_SPOOL";
                        WebTools.ExeSql(sql);

                        foreach (DataRow dr in dt.Rows)
                        {
                            iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");
                            spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL", "ISO_ID='" + iso_id + "' AND SPOOL='" + dr[1].ToString() + "'");

                            spl_id2 = WebTools.GetExpr("SPL_ID", "PIP_SML_SPOOL", " SPL_ID='" + spl_id + "'");
                            if (spl_id2.Trim().Length == 0 && spl_id.Trim().Length > 0)
                            {
                                sql = "INSERT INTO PIP_SML_SPOOL (PROJECT_ID, LIST_NAME, SPL_ID) VALUES (1, '" + FileName + "', '" + spl_id + "')";
                                WebTools.ExeSql(sql);
                            }
                        }

                        break;
                    case "APPEND":
                        foreach (DataRow dr in dt.Rows)
                        {
                            iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");
                            spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL", "ISO_ID=" + iso_id + " AND SPOOL='" + dr[1].ToString() + "'");

                            spl_id2 = WebTools.GetExpr("SPL_ID", "PIP_SML_SPOOL", " SPL_ID='" + spl_id + "'");
                            if (spl_id2.Trim().Length == 0 && spl_id.Trim().Length > 0)
                            {
                                sql = "INSERT INTO PIP_SML_SPOOL (PROJECT_ID, LIST_NAME, SPL_ID) VALUES (1, '" + FileName + "', '" + spl_id + "')";
                                WebTools.ExeSql(sql);
                            }
                        }
                        break;
                }

                Master.ShowSuccess("Selected Spools Imported.");
            }
            catch (Exception ex)
            {
                Master.ShowWarn(ex.Message);
            }
        }
        else
        {
            Master.ShowWarn("Please Select a file to upload");
            return;
        }
    }

    protected void btnDefault_Click(object sender, EventArgs e)
    {
        try
        {
            sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = 'BOM_SIMULATION'");
            if (sml_status.Equals("RUNNING"))
                return;

            //Default Settings
            rdoDwgStatus.SelectedValue = "MCBC";
            rdoHoldStatus.SelectedValue = "Y";
            rdoSpoolSFR.SelectedValue = "Y";
            rdoAGUG.SelectedValue = "BOTH";
            rdoSelectedSpools.SelectedValue = "N";
            rdoPriority.SelectedValue = "Y";
            rdoMaterialSource.SelectedValue = "MRIR";
            rdoUseCommonStore.SelectedValue = "Y";
            rowSelectedSpl.Visible = false;
            Master.ShowSuccess("Default settings applied, click on Save !!!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected string set_current_page_settings()
    {
        string counter = WebTools.CountExpr("*", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
        string query = string.Empty;
        if (Int32.Parse(counter) > 0)
        {
            query = "UPDATE SIMULATION_SETTING SET "
            + " SML_CAT='" + sml_cat + "'"
            + ", SML_TIME=TO_CHAR(SYSDATE,'dd-Mon-yyyy HH:MI AM')"
            + ", SML_USER='" + Session["USER_NAME"].ToString() + "'"
            + ", DWG_STATUS='" + rdoDwgStatus.SelectedValue + "'"
            + ", ON_SFR_FIRST='" + rdoSpoolSFR.SelectedValue + "'"
            + ", ON_SELECTED_SPOOLS='" + rdoSelectedSpools.SelectedValue + "'"
            + ", AGUG='" + rdoAGUG.SelectedValue + "'"
            + ", SML_PRIORITY='" + rdoPriority.SelectedValue + "'"
            + ", EXCLUDE_HOLD='" + rdoHoldStatus.SelectedValue + "'"
            + ", MATERIAL_SOURCE='" + rdoMaterialSource.SelectedValue + "'"
            + ", USE_COMMON_STORE='" + rdoUseCommonStore.SelectedValue + "'"
            + " WHERE SML_CAT='" + sml_cat + "'";
        }
        else
        {
            return "Setting info not updated !";
        }

        try
        {
            //return query;
            WebTools.ExeSql(query);
            return "Saved !!!";
        }
        catch (Exception exc)
        {
            Master.ShowWarn(exc.Message);
            return exc.Message;
        }
    }

    protected void rdoSelectedSpools_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdoSelectedSpools.SelectedValue.Equals("N"))
        {
            rowSelectedSpl.Visible = false;
        }
        else
        {
            rowSelectedSpl.Visible = true;
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(dsExport, "SimulationSpools.xls");
    }

    protected void btnRunSimulation_Click(object sender, EventArgs e)
    {
        sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = 'BOM_SIMULATION'");

        if (CollectSubCons())
        {
            if (sml_status.Equals("RUNNING"))
            {
                Master.ShowSuccess("Ooops... Simulation is already running !!!");
                //return;
            }

            btnSaveSettings_Click(sender, e);

            try
            {
                string user_id = WebTools.GetExpr("USER_ID", "USERS", "UPPER(USER_NAME)=UPPER('" + Session["USER_NAME"].ToString() + "')");
                string sql_new_sml_header = "";
                sql_new_sml_header = "INSERT INTO SIMULATION_HEADER(sml_user_id,sml_cat_id,sml_date,exclude_hold,dwg_status,on_sfr_first" +
                    ",agug,sml_priority,on_selected_spools,use_common_store,material_source)"
                    + "VALUES('" + user_id + "','1',SYSDATE,'" + rdoHoldStatus.SelectedValue + "','" + rdoDwgStatus.SelectedValue + "','" + rdoSpoolSFR.SelectedValue +
                    "','" + rdoAGUG.SelectedValue + "','" + rdoPriority.SelectedValue + "','" + rdoSelectedSpools.SelectedValue + "','" + rdoUseCommonStore.SelectedValue + "','" + rdoMaterialSource.SelectedValue + "')";
                WebTools.exec_non_qry(sql_new_sml_header);

                //Master.ShowSuccess(sql_new_sml_header); return;

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
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='BOM_SIMULATION'");
                    sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='BOM_SIMULATION'");

                    WebTools.ExeSql(sql);
                    Master.ShowSuccess("You request for Simulation has started !!!");
                }
                //If bom simulation is not running
                else
                {
                    WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='BOM_SIMULATION'");
                    Master.ShowSuccess("You request for Simulation process is waiting to run!!!");
                }
                // Response.Redirect("~/UTILITIES/Amogh_Utilities.aspx");
                //UpateProgressContext();
            }
            catch (Exception exc)
            {
                if (exc.Message.Contains("ORA-27478"))
                    Master.ShowWarn("Simulation is already running !!!");
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
                string query = "DELETE FROM simulation_sub_con WHERE SML_FOR='SHOP'";
                WebTools.exec_non_qry(query);

                foreach (var subcon in collection)
                {
                    query = "INSERT INTO simulation_sub_con(SUB_CON_ID,SML_FOR) " +
                        " VALUES (" + WebTools.GetExpr("SUB_CON_ID", "SUB_CONTRACTOR", "SUB_CON_NAME='" + subcon.Text + "'") + ",'SHOP')";
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

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {

        if (Session["SML_SHOP_LAST_TAB"] != null)
        {
            RadMultiPage1.SelectedIndex = Int32.Parse(Session["SML_SHOP_LAST_TAB"].ToString());
            RadTabStrip1.SelectedIndex = Int32.Parse(Session["SML_SHOP_LAST_TAB"].ToString());
        }
    }

    protected void gridSmlHistory_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in gridSmlHistory.MasterTableView.Items)
        {
            if (item.Selected)
            {
                item.GetDataKeyValue("SML_DETAIL_ID").ToString();
            }
        }

    }

    protected void btnExportSmlResult_Click(object sender, EventArgs e)
    {
        if (gridSmlHistory.SelectedItems.Count == 0)
        {
            lblExportSmlResult.Text = "<font color='red'>Please select a row ! </font>";
            return;
        }
        lblExportSmlResult.Text = "<font color='red'>This module is pending now, please download from export section !</font>";
    }
}