using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.OracleClient;
using System.Configuration;
using Ionic.Zip;
using System.Text;

public partial class Utilities_Simulation : System.Web.UI.Page
{
    string sml_status = "", sml_cat = "", process_name = "", sml_cat_id = "", sml_header_id = "", sub_con_sql = "SELECT * FROM SUB_CONTRACTOR ";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            sml_cat = Request.QueryString["SML_CAT"].ToString();
        process_name = sml_cat.Equals("SHOP") ? "BOM_SIMULATION" : "SITE_SIMULATION";
        sml_cat_id = sml_cat.Equals("SHOP") ? "1" : "2";
        sub_con_sql += sml_cat.Equals("SHOP") ? " WHERE FAB_SC='Y'" : " WHERE FIELD_SC='Y'";
        sub_con_sql += " AND USE_COMMON_STORE = '" + rdoUseCommonStore.SelectedValue + "'";
        dsSubContractor.SelectCommand = sub_con_sql;
        dsSubContractor.DataBind();

        Page.Title = sml_cat + " Simulation";
        Master.HeadingMessage = sml_cat + " Simulation";

      
            if (!IsPostBack)
            {
                RadTabStrip1.Tabs[0].Selected = true;
                RadMultiPage1.SelectedIndex = 0;
                if (Session["LAST_SML_TAB"] != null)
                {
                    RadMultiPage1.SelectedIndex = Int32.Parse(Session["LAST_SML_TAB"].ToString());
                    RadTabStrip1.SelectedIndex = Int32.Parse(Session["LAST_SML_TAB"].ToString());
                }
                //RadMultiPage1.SelectedIndex = 0;
                ////testing on timezone
                //TimeZone zone = TimeZone.CurrentTimeZone;
                //string standard = zone.StandardName;
                //string daylight = zone.DaylightName;
                //lblExportSmlResult.Text = standard + "/" + daylight;

                //DateTime utcTime = DateTime.UtcNow;
                //TimeZoneInfo myZone = TimeZoneInfo.FindSystemTimeZoneById(standard);
                //DateTime custDateTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, myZone);
                //lblExportSmlResult.Text = lblExportSmlResult.Text + "/" + custDateTime.ToString("dd-MMM-yyyy HH:mm:ss");
                ////lblExportSmlResult.Text = "Current server time : " + DateTime.Today.ToString("dd-MMM-yyyy hh:mm tt");

                if (Session["SML_LAST_TAB"] != null)
                {
                    RadMultiPage1.SelectedIndex = Int32.Parse(Session["SML_LAST_TAB"].ToString());
                    RadTabStrip1.SelectedIndex = Int32.Parse(Session["SML_LAST_TAB"].ToString());
                }

                lblSmlUser.Text = WebTools.GetExpr("SML_USER", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                lblSmlTime.Text = WebTools.GetExpr("SML_TIME", "SIMULATION_SETTING", "  WHERE SML_CAT='" + sml_cat + "'");
                sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = '" + process_name + "'");

                //SET status for all the fields
                rdoDwgStatus.SelectedValue = WebTools.GetExpr("DWG_STATUS", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoHoldStatus.SelectedValue = WebTools.GetExpr("EXCLUDE_HOLD", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoSpoolSFR.SelectedValue = WebTools.GetExpr("ON_SFR_FIRST", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoAGUG.SelectedValue = WebTools.GetExpr("AGUG", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoMaterialSource.SelectedValue = WebTools.GetExpr("MATERIAL_SOURCE", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoUseCommonStore.SelectedValue = WebTools.GetExpr("USE_COMMON_STORE", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoPriority.SelectedValue = WebTools.GetExpr("SML_PRIORITY", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");

                rdoSelectedSpools.SelectedValue = WebTools.GetExpr("ON_SELECTED_SPOOLS", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoSelectedSpools_SelectedIndexChanged(sender, e);

                rdoSelectedIsos.SelectedValue = WebTools.GetExpr("ON_SELECTED_ISOME", "SIMULATION_SETTING", " WHERE SML_CAT='" + sml_cat + "'");
                rdoSelectedIsos_SelectedIndexChanged(sender, e);

                sub_con_sql = "SELECT * FROM SUB_CONTRACTOR ";
                sub_con_sql += sml_cat.Equals("SHOP") ? " WHERE FAB_SC='Y'" : " WHERE FIELD_SC='Y'";
                dsSubContractor.SelectCommand = sub_con_sql;
                dsSubContractor.DataBind();
                ddSubConForSml.DataBind();

                //refresh_Clicked(sender, e);
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
            string sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = '" + process_name + "'");
            if (sml_status.Equals("RUNNING"))
            {
                Master.ShowWarn("Simulation Already Running. Please Try Again Later.");
                return;
            }

            sml_status = WebTools.CountExpr("STATUS", "SIMULATION_HEADER", " WHERE STATUS = 'PR'");
            if (!sml_status.Equals("0"))
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
                        break;
                }
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr[0].ToString().Trim().Equals("ISO_TITLE1"))
                        continue;
                    iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");
                    spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL", "ISO_ID='" + iso_id + "'" + " AND SPOOL='" + dr[1].ToString() + "'");

                    spl_id2 = WebTools.GetExpr("SPL_ID", "PIP_SML_SPOOL", " SPL_ID='" + spl_id + "'");
                    if (spl_id2.Trim().Length == 0 && spl_id.Trim().Length > 0)
                    {
                        sql = "INSERT INTO PIP_SML_SPOOL (PROJECT_ID, LIST_NAME, SPL_ID) VALUES (1, '" + FileName + "', '" + spl_id + "')";
                        WebTools.ExeSql(sql);
                    }
                }

                Master.ShowSuccess("Selected Spools Imported.");
            }
            catch (Exception ex)
            {
                Master.ShowWarn(ex.Message + "  Invalid ISO / Spool Provided");
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
            sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = '" + process_name + "'");
            if (sml_status.Equals("RUNNING"))
                return;

            //Default Settings
            rdoDwgStatus.SelectedValue = "MCBC";
            rdoHoldStatus.SelectedValue = "Y";
            rdoSpoolSFR.SelectedValue = "Y";
            rdoAGUG.SelectedValue = "BOTH";
            rdoSelectedSpools.SelectedValue = "N";
            rdoSelectedIsos.SelectedValue = "N";
            rdoPriority.SelectedValue = "Y";
            rdoMaterialSource.SelectedValue = "MRIR";
            rdoUseCommonStore.SelectedValue = "Y";
            rowSelectedSpl.Visible = false;
            rowSelectedIso.Visible = false;
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
            + ", ON_SELECTED_ISOME='" + rdoSelectedIsos.SelectedValue + "'"
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
            return "Current settings saved !!!";
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

    protected void btnExportSpools_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(dsSmlSelectedSpools, "SimulationSpools.xls");
    }

    protected void btnRunSimulation_Click(object sender, EventArgs e)
    {
        if (CollectSubCons() && CollectAreas())
        {
            sml_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = '" + process_name + "'");
            if (sml_status.Equals("RUNNING"))
            {
                Master.ShowWarn("Simulation is running, please check status of project jobs!");
                return;
            }

            sml_status = WebTools.CountExpr("STATUS", "SIMULATION_HEADER", " WHERE STATUS = 'PR'");
            if (!sml_status.Equals("0"))
            {
                Master.ShowWarn("Simulation is running, please check status of simulation headers!");
                return;
            }

            btnSaveSettings_Click(sender, e);

            try
            {
                string sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='" + process_name + "'");
                WebTools.ExeSql(sql);
                gridSmlHistory.DataBind();
                Master.ShowSuccess("Current settings saved and Simulation Run started !!!");
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

    private Boolean CollectAreas()
    {
        //lblMessage.Text = "";
        var collection = ddAreaForSml.CheckedItems;
        if (collection.Count != 0)
        {
            try
            {
                string query = "DELETE FROM PIP_SML_AREA";
                WebTools.exec_non_qry(query);

                foreach (var area in collection)
                {
                    query = "INSERT INTO PIP_SML_AREA(AREA_L2) VALUES ('" + area.Text.ToString() + "')";
                    WebTools.ExeSql(query);
                    //lblSmlTime.Text = query;
                    //return false;
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
            Master.ShowWarn("Select any area !");
            return false;
        }
    }

    private Boolean CollectSubCons()
    {
        //lblMessage.Text = "";
        var collection = ddSubConForSml.CheckedItems;
        if (collection.Count != 0)
        {
            try
            {
                string query = "DELETE FROM simulation_sub_con WHERE SML_FOR='" + sml_cat + "'";
                WebTools.exec_non_qry(query);

                foreach (var subcon in collection)
                {
                    query = "INSERT INTO simulation_sub_con(SUB_CON_ID,SML_FOR) " +
                        " VALUES (" + WebTools.GetExpr("SUB_CON_ID", "SUB_CONTRACTOR", "SUB_CON_NAME='" + subcon.Text + "'") + ",'" + sml_cat + "')";
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
        Session["LAST_SML_TAB"] = RadTabStrip1.SelectedIndex;
    }

    protected void btnExportSmlResult_Click(object sender, EventArgs e)
    {
        if (gridSmlHistory.SelectedItems.Count == 0)
        {
            lblExportSmlResult.Text = "<font color='red'>Please select a record ! </font>";
            return;
        }

        foreach (GridDataItem item in gridSmlHistory.MasterTableView.Items)
        {
            if (item.Selected)
            {
                sml_header_id = item.GetDataKeyValue("SML_HEADER_ID").ToString();
            }
        }

        string sml_file_type_id = rdoSmlDownload.SelectedValue.ToString();
        string expt_status = WebTools.GetExpr("STATUS", "SIMULATION_HEADER", "SML_HEADER_ID=" + sml_header_id);

        if (expt_status.Equals("PR"))
        {
            lblExportSmlResult.Text = "<font color='red'>This process is running now, please wait until it gets completed !</font>";
            return;
        }

        if (expt_status.Equals("PE"))
        {
            lblExportSmlResult.Text = "<font color='red'>The run was un-successful, please check error log !</font>";
            return;
        }

        string expt_sql = WebTools.GetExpr("REPLACE(SML_EXPORT_SQL,':SML_HEADER_ID','" + sml_header_id + "')", "SIMULATION_EXPORT_TYPE", "SML_EXPORT_ID=" + rdoSmlDownload.SelectedValue.ToString());
        string sml_time = WebTools.GetExpr("to_char(SML_DATE,'dd_Mon_yyyy_HH_mi')", "SIMULATION_HEADER", "SML_HEADER_ID=" + sml_header_id);
        string file_name = rdoSmlDownload.SelectedText.ToString() + "_" + sml_time;

        dsSmlResult.SelectCommand = expt_sql;
        //WebTools.ExportDataSetToExcel(dsSmlResult, file_name + ".xls");
        ExportToCSV(dsSmlResult, file_name);
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        gridSmlHistory.DataBind();
        grdiProgress.DataBind();
        lblExportSmlResult.Text = "";

        //testing on timezone
        //TimeZone zone = TimeZone.CurrentTimeZone;
        //string standard = zone.StandardName;
        //string daylight = zone.DaylightName;
        //lblExportSmlResult.Text = standard + "/" + daylight;

        //DateTime utcTime = DateTime.UtcNow;
        //TimeZoneInfo myZone = TimeZoneInfo.FindSystemTimeZoneById(standard);
        //DateTime custDateTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, myZone);
        //lblExportSmlResult.Text = lblExportSmlResult.Text + "/" + custDateTime.ToString("dd-MMM-yyyy HH:mm:ss");
    }

    public void ExportToCSV(SqlDataSource dataSrc, string fileName)
    {
        //Add Response header

        Response.Clear();
        Response.AddHeader("content-disposition",
            string.Format("attachment;filename={0}.csv", fileName));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        //GET Data From Database

        OracleConnection cn = new OracleConnection(dataSrc.ConnectionString);

        string query =
            dataSrc.SelectCommand.Replace("\r\n", " ").Replace("\t", " ");

        OracleCommand cmd = new OracleCommand(query, cn);

        cmd.CommandTimeout = 999999;
        cmd.CommandType = CommandType.Text;
        try
        {
            cn.Open();
            OracleDataReader dr = cmd.ExecuteReader();
            StringBuilder sb = new StringBuilder();

            //CSV Header
            for (int count = 0; count < dr.FieldCount; count++)
            {
                if (dr.GetName(count) != null)
                    sb.Append(dr.GetName(count));
                if (count < dr.FieldCount - 1)
                {
                    sb.Append(",");
                }
            }
            Response.Write(sb.ToString() + "\n");
            Response.Flush();

            //CSV Body
            while (dr.Read())
            {
                sb = new StringBuilder();

                for (int col = 0; col < dr.FieldCount - 1; col++)
                {
                    if (!dr.IsDBNull(col))
                    {
                        if (dr.GetDataTypeName(col).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(col).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(col).ToString().Replace(",", " "));
                        }
                    }
                    sb.Append(",");
                }

                if (!dr.IsDBNull(dr.FieldCount - 1))
                {
                    if (!dr.IsDBNull(dr.FieldCount - 1))
                    {
                        if (dr.GetDataTypeName(dr.FieldCount - 1).ToUpper() == "DATE")
                        {
                            sb.Append(DateTime.Parse(dr.GetValue(dr.FieldCount - 1).ToString()).ToString("dd-MMM-yyyy"));
                        }
                        else
                        {
                            sb.Append(dr.GetValue(dr.FieldCount - 1).ToString().Replace(",", " "));
                        }
                    }
                }

                Response.Write(sb.ToString() + "\n");
                Response.Flush();
            }
            dr.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            cmd.Connection.Close();
            cn.Close();
        }
        Response.End();
    }

    protected void rdoSelectedIsos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdoSelectedIsos.SelectedValue.Equals("N"))
        {
            rowSelectedIso.Visible = false;
        }
        else
        {
            rowSelectedIso.Visible = true;
        }

    }

    protected void btnIsoUpload_Click(object sender, EventArgs e)
    {
        string sql, iso_title1;
        if (isoUploader.HasFile)
        {
            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(isoUploader.PostedFile.FileName);
            string Extension = Path.GetExtension(isoUploader.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            isoUploader.SaveAs(FilePath);
            //lblSmlUser.Text = FilePath;
            //return;
            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            try
            {
                switch (rdoUploadOption.SelectedValue)
                {
                    case "DELETE":
                        sql = "DELETE FROM PIP_SML_ISOME";
                        WebTools.ExeSql(sql);
                        break;
                }
                foreach (DataRow dr in dt.Rows)
                {
                    //iso_title1 = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");
                    if (dr[0].ToString().Trim().Equals("ISO_TITLE1"))
                        continue;
                    iso_title1 = dr[0].ToString().Trim();
                    if (iso_title1.Trim().Length > 0)
                    {
                        sql = "INSERT INTO PIP_SML_ISOME (ISO_TITLE) VALUES ('" + iso_title1 + "')";
                        WebTools.ExeSql(sql);
                    }
                }

                Master.ShowSuccess("Selected Isometrics Imported.");
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

    protected void btnExportIso_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(dsSmlSelectedIso, "SimulationIsometrics.xls");
    }



    //protected void ddAreagroup_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    //{
    //    if (ddAreagroup.SelectedValue == "1")
    //    {
    //        dsSubContractor.SelectCommand = "SELECT *FROM VIEW_STORE_SELECTION";
    //        //dsSubContractor.DataBind();
    //        ddSubConForSml.DataBind();
    //            }
    //    if (ddAreagroup.SelectedValue == "2")
    //    {
    //        dsSubContractor.SelectCommand = "SELECT *FROM VIEW_STORE_SELECTION WHERE SML_SC='OTHERS'";
    //        //dsSubContractor.DataBind();
    //        ddSubConForSml.DataBind();
    //    }
    //        foreach (RadComboBoxItem itm in ddSubConForSml.Items)
    //    {
    //        itm.Checked = true;
    //    }
    //}
}