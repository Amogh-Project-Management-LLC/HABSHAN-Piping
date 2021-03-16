using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_PriorityMaster : System.Web.UI.Page
{
    protected static string uploadedFileName = "", selected_priority = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("SET PROJECT PRIORITY");
        }
    }

    protected void RadListBoxSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("PRIORITY_IMPORT"))
        //{
        //    btnImport.Visible = false;
        //    return;
        //}


        if (RadListBoxSource.SelectedItem != null)
        {
            RadListBox1.SelectedIndex = -1;
            selected_priority = RadListBoxSource.SelectedItem.Value.ToString();
            lblSampleExcel.Text = "<a href='../Import_Format/Priority_" + selected_priority + ".xlsx'>Sample "
                + selected_priority + " Priority File</a>";
            uploadOptions.Visible = true;
        }

        else
            Master.show_info("Please select an item !!!");
           
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (RadListBoxSource.SelectedItem != null)
        {
            string export_option = RadListBoxSource.SelectedItem.Value.ToString();
            if (export_option == "")
                export_option = RadListBox1.SelectedValue;
            //Master.show_info(export_option);
            switch (export_option)
            {
                case "SPOOL":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_SPOOL";
                    break;
                case "MAIN_MAT":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_MAIN_MAT";
                    break;
                case "AREA":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_AREA";
                    break;
                case "SERVICE":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_SERVICE";
                    break;
                case "LINE":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_LINE";
                    break;
                case "ISOMETRIC":
                    dsExport.SelectCommand = "SELECT * FROM PROJECT_PRIORITY_ISOMETRIC";
                    break;
                case "SPLIT_WBS":
                    dsExport.SelectCommand = "SELECT *  FROM  PROJECT_PRIORITY_SPLIT_WBS";
                    break;
                case "CRD":
                    dsExport.SelectCommand = "SELECT ISO_TITLE1, CRD_DATE FROM PIP_ISOMETRIC WHERE CRD_DATE IS NOT NULL";
                    break;
                case "EQP":
                    dsExport.SelectCommand = "SELECT *  FROM  PROJECT_PRIORITY_EQP_EREC";
                    break;
            }
            dsExport.DataBind();
            WebTools.ExportDataSetToExcel(dsExport, "Priority_" + export_option + ".xls");
        }
        else
            lblMessage.Text = "<font color='red'>Please select an item !!!</font>";
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        

        string uploadOption = rdoUploadOption.SelectedValue;
        //reset
        if (uploadOption.Equals("RESET"))
        {
            Reset();
            //Master.show_success("Priority has been reset for " + uploadOption);
            return;
        }

        if (!uploadPriorityExcel.HasFile) return;
        string proj_id = Session["PROJECT_ID"].ToString();
        string FileName = Path.GetFileName(uploadPriorityExcel.PostedFile.FileName);
        string Extension = Path.GetExtension(uploadPriorityExcel.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();

        string FilePath = FolderPath + FileName;
        uploadPriorityExcel.SaveAs(FilePath);

        string table_name = "";
        string query = "", message="";

        if (RadListBox1.SelectedValue != "")
            selected_priority = RadListBox1.SelectedValue;
        else
            selected_priority = RadListBoxSource.SelectedValue;

        DataTable dt;
        FileStream stream;
        try
        {
            switch (selected_priority)
            {
                case "SPOOL":
                    table_name = "PROJECT_PRIORITY_SPOOL";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE ISO_TITLE1='" + dr[0].ToString().ToUpper().Trim()
                            + "' AND SPOOL='" + dr[1].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);

                        string iso_id = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", "ISO_TITLE1='" + dr[0].ToString() + "'");
                        string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL", "ISO_ID='" + iso_id + "' AND SPOOL='" + dr[1].ToString() + "'");

                        if (!string.IsNullOrEmpty(spl_id))
                        {
                            if (dr[0].ToString().Contains("ISO_TITLE1") || dr[1].ToString().Contains("PRIORITY"))
                                continue;
                            query = "INSERT INTO " + table_name + " (ISO_TITLE1, SPOOL, PRIORITY,SPL_ID) "
                                + " VALUES('" + dr[0].ToString() + "','" + dr[1].ToString() + "','" + dr[2].ToString() + "','" + spl_id + "')";
                            message = WebTools.ExeSql(query);
                        }
                    }
                    break;

                case "MAIN_MAT":
                    table_name = "PROJECT_PRIORITY_MAIN_MAT";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE MAIN_MAT='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("MAIN_MAT") || dr[1].ToString().Contains("PRIORITY"))
                            continue;
                        query = "INSERT INTO " + table_name + " (MAIN_MAT, PRIORITY) VALUES ('" + dr[0].ToString() + "', '" + dr[1].ToString() + "')";                        
                        message = WebTools.ExeSql(query);
                    }

                    break;
                case "AREA":
                    table_name = "PROJECT_PRIORITY_AREA";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE AREA='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("AREA") || dr[1].ToString().Contains("PRIORITY"))
                            continue;
                        query = "INSERT INTO " + table_name + " (AREA, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "SERVICE":
                    table_name = "PROJECT_PRIORITY_SERVICE";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE SERVICE='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("SERVICE") || dr[1].ToString().Contains("PRIORITY"))
                            continue;
                        query = "INSERT INTO " + table_name + " (SERVICE, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";                        
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "LINE":
                    table_name = "PROJECT_PRIORITY_LINE";

                    if (uploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }

                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE LINE_NO='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("LINE_NO") || dr[1].ToString().Contains("PRIORITY"))
                            continue;
                        query = "INSERT INTO " + table_name + " (LINE_NO, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "ISOMETRIC":
                    table_name = "PROJECT_PRIORITY_ISOMETRIC";

                    if (rdoUploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }
                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);
                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE ISO_TITLE1='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("ISO_TITLE1"))
                            continue;
                        query = "INSERT INTO " + table_name + " (ISO_TITLE1, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "SPLIT_WBS":
                    table_name = "PROJECT_PRIORITY_SPLIT_WBS";
                    if (rdoUploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }
                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE  WBS_NO='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("WBS_NO") || dr[1].ToString().Contains("PRIORITY"))
                            continue;
                        query = "INSERT INTO " + table_name + " (WBS_NO, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "CRD":
                    //table_name = "PROJECT_PRIORITY_SPLIT_WBS";
                    if (rdoUploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("UPDATE PIP_ISOMETRIC SET CRD_DATE = NULL");
                    }
                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("ISO_TITLE1") || dr[1].ToString().Contains("CRD_DATE"))
                            continue;
                        query = "UPDATE PIP_ISOMETRIC SET CRD_DATE = '" + dr[1].ToString() + "' WHERE ISO_TITLE1 = '" + dr[0].ToString() + "'";
                        //query = "INSERT INTO " + table_name + " (WBS_NO, PRIORITY) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
                case "EQP":
                    table_name = "PROJECT_PRIORITY_EQP_EREC";
                    if (rdoUploadOption.Equals("DELETE"))
                    {
                        WebTools.ExeSql("TRUNCATE TABLE " + table_name);
                    }
                    stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
                    dt = new DataTable();
                    dt = ExcelImport.xlsxToDT2(stream);

                    foreach (DataRow dr in dt.Rows)
                    {
                        query = "DELETE FROM " + table_name + " WHERE  EQP_NO ='" + dr[0].ToString().ToUpper().Trim() + "'";
                        WebTools.ExeSql(query);
                    }
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr[0].ToString().Contains("EQP_NO") || dr[1].ToString().Contains("EREC_DATE"))
                            continue;
                        query = "INSERT INTO " + table_name + " (EQP_NO, EREC_DATE, REMARKS) VALUES ('" + dr[0].ToString() + "','" + dr[1].ToString() + "','" + dr[2].ToString() + "')";
                        message = WebTools.ExeSql(query);
                    }
                    break;
            }

            Master.show_success("Data Imported Sucessfully!!!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }       
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            for (var i = 0; i < RadListBoxSource.Items.Count(); i++)
            {
                WebTools.ExeSql("UPDATE project_priority_options SET field_order='" + (i +1) + "' WHERE priority_field='" + RadListBoxSource.Items[i].Value + "'");
            }
            Master.show_success("Priority order saved !!!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void RadExportAll_Click(object sender, EventArgs e)
    {
        dsExport.SelectCommand = "SELECT ISO_ID, ISO_TITLE1, MAIN_MAT, AREA_L1, LINE_NO, SRV_CODE, SPOOL, MAT_TYPE, SPL_ID, AREA_PRIORITY, ISO_PRIORITY, LINE_PRIORITY, MAT_PRIORITY, SERV_PRIORITY, SPL_PRIORITY, SPL_PROJ_PRIORITY1  FROM  VIEW_PROJ_SPL_PRIORITY_EXPORT";
        dsExport.DataBind();
        ExportToCSV(dsExport, "Project_Priority_All.csv");
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

    protected void Reset()
    {
        if (RadListBoxSource.SelectedItem != null || RadListBox1.SelectedValue != "")
        {
            string export_option = RadListBoxSource.SelectedValue;
            if (export_option == "")
                export_option = RadListBox1.SelectedValue;
            string sql = string.Empty;
            //Master.show_info(export_option);
            switch (export_option)
            {
                case "SPOOL":
                    sql = "DELETE FROM PROJECT_PRIORITY_SPOOL";
                    break;
                case "MAIN_MAT":
                    sql = "DELETE FROM PROJECT_PRIORITY_MAIN_MAT";
                    break;
                case "AREA":
                    sql = "DELETE FROM PROJECT_PRIORITY_AREA";
                    break;
                case "SERVICE":
                    sql = "DELETE FROM PROJECT_PRIORITY_SERVICE";
                    break;
                case "LINE":
                    sql = "DELETE FROM PROJECT_PRIORITY_LINE";
                    break;
                case "ISOMETRIC":
                    sql = "DELETE FROM PROJECT_PRIORITY_ISOMETRIC";
                    break;
                case "SPLIT_WBS":
                    sql = "DELETE  FROM  PROJECT_PRIORITY_SPLIT_WBS";
                    break;
                case "EQP":
                    sql = "DELETE FROM PROJECT_PRIORITY_EQP_EREC";
                    break;
                case "CRD":
                    sql = "UPDATE PIP_ISOMETRIC SET CRD_DATE = NULL";
                    break;
            }
            WebTools.ExeSql(sql);
            Master.show_success("Priority has been reset for " + export_option);
        }
        else
            lblMessage.Text = "<font color='red'>Please select an item !!!</font>";
    }

    protected void RadListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadListBox1.SelectedValue != "")
        {
            RadListBoxSource.SelectedIndex = -1;
            selected_priority = RadListBox1.SelectedItem.Text.ToString();
            lblSampleExcel.Text = "<a href='../Import_Format/Priority_" + selected_priority + ".xlsx'>Sample "
                + selected_priority + " Priority File</a>";
            uploadOptions.Visible = true;
        }
    }
}