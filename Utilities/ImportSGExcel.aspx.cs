using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_ImportTalismanData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Import Excel Data";

          

        }
        string err = WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=1");
        err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=2");
        err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=3");

        txtEpicOutput.Text = err;

        string err2 = WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=1");
        err2 += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=2");
        err2 += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=3");
        err2 += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=4");
        txtAmoghOutput.Text = err2;

        string amg_site_joint_cnt = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=1");
        string amg_bal_joint_count = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=2");
        string amg_bal_bom_cnt = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=3");
        string amg_bal_spool_cnt = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=4");

        string epic_bal_joint_cnt = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=1");
        string epic_bal_bom_cnt = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=2");
        string epic_bal_spool_cnt = WebTools.GetExpr("CNT", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=3");
        string dir_obj = importformat.SelectedValue.ToString();

        AmpBalFlangeJoints.Visible = false;
        AmgBaljoints.Visible = false;
        AmgBalBom.Visible = false;
        AmgBalSpool.Visible = false;
        EpicBalJoint.Visible = false;
        EpicBalBom.Visible = false;
        EpicBalSpool.Visible = false;

        switch (dir_obj)
        {

            case "AMOGH_DATA_IMPORT":
                if (int.Parse(amg_site_joint_cnt) > 0)
                {
                    AmpBalFlangeJoints.Visible = true;
                }
                if (int.Parse(amg_bal_joint_count) > 0)
                {
                    AmgBaljoints.Visible = true;
                }
                if (int.Parse(amg_bal_bom_cnt) > 0)
                {
                    AmgBalBom.Visible = true;
                }
                if (int.Parse(amg_bal_spool_cnt) > 0)
                {
                    AmgBalSpool.Visible = true;
                }

                break;

            case "EPIC_DATA_IMPORT":

                if (int.Parse(epic_bal_joint_cnt) > 0)
                {
                    EpicBalJoint.Visible = true;
                }
                if (int.Parse(epic_bal_bom_cnt) > 0)
                {
                    EpicBalBom.Visible = true;
                }
                if (int.Parse(epic_bal_spool_cnt) > 0)
                {
                    EpicBalSpool.Visible = true;
                }



                break;
        }

        RefreshButtons();
    }

    private void RefreshButtons()
    {
        
        string amg_import = "~/Import_Format/AmoghSgImport/";
        string Epic_import = "~/Import_Format/EpicSgImport/";

        string dir_obj = importformat.SelectedValue.ToString();


        if (dir_obj == "AMOGH_DATA_IMPORT")
        {
            HyperLink1.NavigateUrl = amg_import + "CUTLIST.xlsx";
            HyperLink2.NavigateUrl = amg_import + "SPOOL.xlsx";
            HyperLink3.NavigateUrl = amg_import + "JOINT.xlsx";
            HyperLink4.NavigateUrl = amg_import + "LOM.xlsx";
            HyperLink5.NavigateUrl = amg_import + "SITEJOINT.xlsx";
            txtAmoghOutput.Visible = true;
            txtEpicOutput.Visible = false;

            
            string cutlist_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_CUT_LIST_AMOGH", " WHERE IMPORT_REMARKS IS NOT NULL ");
            string spl_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_SPOOL_AMOGH", " WHERE IMPORT_REMARKS IS NOT NULL ");
            string jnt_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_JOINT_AMOGH", " WHERE IMPORT_REMARKS IS NOT NULL ");
            string lom_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_LOM_AMOGH", " WHERE IMPORT_REMARKS IS NOT NULL ");
            string siteJnt_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_SITE_JOINT_AMOGH", " WHERE IMPORT_REMARKS IS NOT NULL ");
            if (cutlist_cnt != "0")
            {
                btnCutlist.Visible = true;
            }
            else
            {
                btnCutlist.Visible = false;
            }
            if (spl_cnt != "0")
            {
                btnSpool.Visible = true;
            }
            else
            {
                btnSpool.Visible = false;
            }
            if (jnt_cnt != "0")
            {
                btnJoint.Visible = true;
            }
            else
            {
                btnJoint.Visible = false;
            }
            if (lom_cnt != "0")
            {
                btnLom.Visible = true;
            }

            else
            {
                btnLom.Visible = false;
            }
            if (siteJnt_cnt != "0")
            {
                btnFlange.Visible = true;
            }
            else
            {
                btnFlange.Visible = false;
            }
        }

        if (dir_obj == "EPIC_DATA_IMPORT")
        {
            HyperLink6.NavigateUrl = Epic_import + "SPOOL_EPIC.xlsx";
            HyperLink7.NavigateUrl = Epic_import + "JOINT_EPIC.xlsx";
            HyperLink8.NavigateUrl = Epic_import + "BOM_EPIC.xlsx";
            txtEpicOutput.Visible = true;
            txtAmoghOutput.Visible = false;
            
           
            string spl_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_SPOOL_DATA_EPIC", " WHERE IMPORT_REMARKS IS NOT NULL ");
            string jnt_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_JOINT_EPIC", " WHERE IMPORT_REMARKS IS NOT NULL ");
            string lom_cnt = WebTools.CountExpr("IMPORT_REMARKS", "CLIENT_BOM_N_JC_EPIC", " WHERE IMPORT_REMARKS IS NOT NULL ");

            if (spl_cnt != "0")
            {
                btnEpicSpool.Visible = true;
            }
            else
            {
                btnEpicSpool.Visible = false;
            }
            if (jnt_cnt != "0")
            {
                btnEpicJoint.Visible = true;
            }
            else
            {
                btnEpicJoint.Visible = false;
            }
            if (lom_cnt != "0")
            {
                btnEpicBom.Visible = true;
            }
            else
            {
                btnEpicBom.Visible = false;
            }

        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AmoghUpdates.aspx");
    }
    //old
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        bool flag;

        
        flag = fileUploadCutList.HasFile;
        flag = fileUploadSpoolStatus.HasFile;
        flag = fileUploadWeldMTO.HasFile;
        flag = fileUploadBOM.HasFile;
        flag = fileUploadFlange.HasFile;

        string dir_obj = importformat.SelectedValue.ToString();
        if (dir_obj == "")
        {
            RadWindowManager1.RadAlert("Select Import Type Format.", 300, 150, "Warning", "");
            return;
        }

        if (!flag)
        {
            Master.ShowError("One or more file is missing to upload. Please check again and upload.");
            return;
        }


        string cutlistfilename = fileUploadCutList.FileName;
        string Spoolfilename = fileUploadSpoolStatus.FileName;
        string Weldfilename = fileUploadWeldMTO.FileName;
        string Bomfilename = fileUploadBOM.FileName;
        string Flangefilename = fileUploadFlange.FileName;
        
        if(cutlistfilename!= "CUTLIST.csv")
        {
            Master.ShowError("CUTLIST filename should be CUTLIST.csv, re-upload after renaming");
            return;
        }

        if (Spoolfilename != "SPOOL.csv")
        {
            Master.ShowError("SPOOL filename should be SPOOL.csv, re-upload after renaming");
            return;
        }

        if (Weldfilename != "JOINT.csv")
        {
            Master.ShowError("JOINT filename should be JOINT.csv, re-upload after renaming");
            return;
        }

        if (Bomfilename != "LOM.csv")
        {
            Master.ShowError("LOM filename should be LOM.csv, re-upload after renaming");
            return;
        }

        if (Flangefilename != "SITEJOINT.csv")
        {
            Master.ShowError("FLANGE filename should be SITEJOINT.csv, re-upload after renaming");
            return;
        }
        
        try
        {
           
            string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + dir_obj+"'");
            //string FolderPath = "G:\\PDF_DIR\\BIFP\\SG_EXT_DATA\\";
            // System.IO.File.Delete(FilePath);

            //Isometric MTO            
            string FilePath = FolderPath + cutlistfilename;           
            fileUploadCutList.SaveAs(FilePath);
            

            //Spool Status                    
            FilePath = FolderPath + Spoolfilename;
            fileUploadSpoolStatus.SaveAs(FilePath);
          

            //Welding          
            FilePath = FolderPath + Weldfilename;
            fileUploadWeldMTO.SaveAs(FilePath);

            //BOM           
            FilePath = FolderPath + Bomfilename;
            fileUploadBOM.SaveAs(FilePath);

            //Flange            
            FilePath = FolderPath + Flangefilename;
            fileUploadFlange.SaveAs(FilePath);           

            Master.ShowSuccess("All Files Uploaded Successfully.");
            //btnUpload.Visible = false;
            //btnRun.Visible = true;
        }
        catch (Exception ex)
        {
            Master.ShowError("Error in file upload:" + "<br/>" + ex.Message);
        }
    }

    protected void UploadFile(FileUpload f, string DestinationTable)
    {
        string proj_id = Session["PROJECT_ID"].ToString();
        string FileName = Path.GetFileName(f.PostedFile.FileName);
        string Extension = Path.GetExtension(f.PostedFile.FileName);
        string FolderPath = WebTools.SessionDataPath();

        string FilePath = FolderPath + FileName;
        f.SaveAs(FilePath);

        // delete old data
        WebTools.ExecNonQuery("DELETE FROM "+ DestinationTable + " WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");

        FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

        DataTable dt = new DataTable();
        dt = ExcelImport.xlsxToDT2(stream);

        dt.Columns.Add("IMPORT_BY");

        foreach (DataRow r in dt.Rows)
        {
            r["IMPORT_BY"] = Session["USER_NAME"].ToString();
        }
            
        ExcelImport.ImportDataTable(dt, DestinationTable, "", "PROJECT_ID", proj_id);       
    }
    //amogh run
    protected void btnRun_Click(object sender, EventArgs e)
    {
        try
        {
            //btnRun.Enabled = false;
            string dir_obj = importformat.SelectedValue.ToString();
       //     string prc_run = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIRECTORY_NAME='" + dir_obj+"'");
            WebTools.ExecuteProcedure("AMOGH_DATA_IMPORT");
            string FilePath;

            string folderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + dir_obj + "'");
           // FilePath = folderPath + "output.txt";
            switch (importformat.SelectedValue)
            {


                case "AMOGH_DATA_IMPORT":
                    //FilePath = folderPath + "output.txt";
                    //if (File.Exists(FilePath))
                    //{

                    //    txtAmoghOutput.Text = File.ReadAllText(FilePath);
                    //}
                  

                    string err=WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=1");
                    err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=2");
                    err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=3");
                    err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_AMOGH", " WHERE SNO=4");
                    txtAmoghOutput.Text = err;
                    break;
            }

        
             
           
            RefreshButtons();

            Master.ShowSuccess("Imported successfully");
           
            //btnRun.Visible = false;
            //btnUpload.Visible = true;
        }
        catch(Exception ex)
        {
            Master.ShowError("Error in Importing, Try Again!" + "<br/>" +ex.Message);
            //btnRun.Visible = false;
            //btnUpload.Visible = true;
        }

    }

    protected void btnISO_Click(object sender, EventArgs e)
    {
    //    string filename = WebTools.GetExpr("IMP_REP_TITLE", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
    //    string sql = WebTools.GetExpr("IMP_ERR_LOG_SQL", "PIP_BULK_IMPORT_REP", " IMP_REP_ID=" + Request.QueryString["IMPORT_ID"]);
    //    string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"].ToString() + "'");
    //    itemsErrorSource.SelectCommand = sql.Replace("PARAM", user_id);
    //    WebTools.ExportDataSetToExcel(itemsErrorSource, filename + ".xls");
    }


    protected void btnCutlist_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(AmoghCutList, "CutList_error.xls");
    }

    protected void btnSpool_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(AmoghSpoolList, "Spool_error.xls");

    }

    protected void btnJoint_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(AmoghJointList, "Joint_error.xls");
    }

    protected void btnLom_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(AmoghLomList, "Lom_error.xls");
    }

    protected void btnFlange_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(AmoghSiteJointList, "Flange_error.xls");
    }

    protected void importformat_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshButtons();
        
        switch (importformat.SelectedValue)
        {
             
        case "AMOGH_DATA_IMPORT":

                Amogh_format.Visible = true;
                Epic_format.Visible = false;
                txtEpicOutput.Visible = false;             
                break;
                case "EPIC_DATA_IMPORT":
                Amogh_format.Visible = false;
                Epic_format.Visible = true;
                txtAmoghOutput.Visible = false;           
                break;
         

        }
    }

    protected void btnEpicSpool_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(EpicSpoolList, "Epic_Spool_error.xls");
    }

    protected void btnEpicJoint_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(EpicJointList, "Epic_Joint_error.xls");
    }

    protected void btnEpicBom_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(EpicBomList, "Epic_Lom_error.xls");
    }

    //old
    protected void btnEpicUpload_Click(object sender, EventArgs e)
    {
        bool flag;


        flag = fileUploadEpicSpool.HasFile;
        flag = fileUploadEpicJoint.HasFile;
        flag = fileUploadEpicBom.HasFile;
        

        string dir_obj = importformat.SelectedValue.ToString();
        if (dir_obj == "")
        {
            RadWindowManager1.RadAlert("Select Import Type Format.", 300, 150, "Warning", "");
            return;
        }

        if (!flag)
        {
            Master.ShowError("One or more file is missing to upload. Please check again and upload.");
            return;
        }


        string Spoolfilename = fileUploadEpicSpool.FileName;
        string Weldfilename = fileUploadEpicJoint.FileName;
        string Bomfilename = fileUploadEpicBom.FileName;
        

        if (Spoolfilename != "SPOOL_EPIC.csv")
        {
            Master.ShowError("SPOOL filename should be SPOOL_EPIC.csv, re-upload after renaming");
            return;
        }

        if (Weldfilename != "JOINT_EPIC.csv")
        {
            Master.ShowError("JOINT filename should be JOINT_EPIC.csv, re-upload after renaming");
            return;
        }

        if (Bomfilename != "BOM_EPIC.csv")
        {
            Master.ShowError("BOM filename should be BOM_EPIC.csv, re-upload after renaming");
            return;
        }


        try
        {

            string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + dir_obj + "'");
            //string FolderPath = "G:\\PDF_DIR\\BIFP\\SG_EXT_DATA\\";
            // System.IO.File.Delete(FilePath);

         
            //Spool Status                    
            string FilePath = FolderPath + Spoolfilename;
            fileUploadEpicSpool.SaveAs(FilePath);


            //Welding          
            FilePath = FolderPath + Weldfilename;
            fileUploadEpicJoint.SaveAs(FilePath);

            //BOM           
            FilePath = FolderPath + Bomfilename;
            fileUploadEpicBom.SaveAs(FilePath);


            Master.ShowSuccess("All Files Uploaded Successfully.");
            //btnUpload.Visible = false;
            //btnRun.Visible = true;
        }
        catch (Exception ex)
        {
            Master.ShowError("Error in file upload:" + "<br/>" + ex.Message);
        }
    }

    protected void btnEpicRun_Click(object sender, EventArgs e)
    {
        try
        {
            string dir_obj = importformat.SelectedValue.ToString();
          //  string prc_run = WebTools.GetExpr("DIRECTORY_PATH", "DBA_DIRECTORIES", " WHERE DIRECTORY_NAME='" + dir_obj + "'");
            WebTools.ExecuteProcedure("EPIC_DATA_IMPORT");

           
           

            string folderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + dir_obj + "'");
          //  FilePath = folderPath + "output.txt";
            switch (importformat.SelectedValue)
            {              
                case "EPIC_DATA_IMPORT":
                    //FilePath = folderPath + "output.txt";
                    //if (File.Exists(FilePath))
                    //{
                    //    txtEpicOutput.Text = File.ReadAllText(FilePath);
                    //}
                    //break;
                    string err = WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=1");
                    err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=2");
                    err += Environment.NewLine + WebTools.GetExpr("LABEL", "SG_IMPORT_ERROR_CHECK_EPIC", " WHERE SNO=3");
                    
                    txtEpicOutput.Text = err;
                    break;


            }
          
            RefreshButtons();
            Master.ShowSuccess("Imported successfully");
            
        }
        catch (Exception ex)
        {

            Master.ShowError("Error in Importing, Try Again!" + "<br/>" + ex.Message);
            
        }

    }

    protected Telerik.Web.UI.FileExplorer.FileExplorerControls GetVisibleControls()
    {
        Telerik.Web.UI.FileExplorer.FileExplorerControls explorerControls = 0;

        //explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.AddressBox;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.Grid;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.ListView;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.Toolbar;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.TreeView;

        //explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.ContextMenus;

        return explorerControls;
    }


    protected void btnUploadEPIC_Click(object sender, EventArgs e)
    {
        bool flag;

        flag = fileUploadEpicSpool.HasFile;
        flag = fileUploadEpicJoint.HasFile;
        flag = fileUploadEpicBom.HasFile;


        string dir_obj = importformat.SelectedValue.ToString();
        if (dir_obj == "")
        {
            RadWindowManager1.RadAlert("Select Import Type Format.", 300, 150, "Warning", "");
            return;
        }

        if (!flag)
        {
            Master.ShowError("One or more file is missing to upload. Please check again and upload.");
            return;
        }


        string Spoolfilename = fileUploadEpicSpool.FileName;
        string Weldfilename = fileUploadEpicJoint.FileName;
        string Bomfilename = fileUploadEpicBom.FileName;
        

        if (Spoolfilename != "SPOOL_EPIC.xlsx" && Spoolfilename != "SPOOL_EPIC.xls")
        {
            Master.ShowError("/SPOOL filename should be SPOOL_EPIC.xls/xlsx, re-upload after renaming");
            return;
        }

        if (Weldfilename != "JOINT_EPIC.xlsx" && Weldfilename != "JOINT_EPIC.xls")
        {
            Master.ShowError("JOINT filename should be JOINT_EPIC.xls/xlsx, re-upload after renaming");
            return;
        }

        if (Bomfilename != "BOM_EPIC.xlsx" && Bomfilename != "BOM_EPIC.xls")
        {
            Master.ShowError("BOM filename should be BOM_EPIC.xls/xlsx, re-upload after renaming");
            return;
        }


        try
        {

            string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + dir_obj + "'");
            //string FolderPath = "G:\\PDF_DIR\\BIFP\\SG_EXT_DATA\\";
            // System.IO.File.Delete(FilePath);

         
            //Spool Status                    
            string FilePath = FolderPath + Spoolfilename;
            fileUploadEpicSpool.SaveAs(FilePath);


            //Welding          
            FilePath = FolderPath + Weldfilename;
            fileUploadEpicJoint.SaveAs(FilePath);

            //BOM           
            FilePath = FolderPath + Bomfilename;
            fileUploadEpicBom.SaveAs(FilePath);


            Master.ShowSuccess("All Files Uploaded Successfully.");
            //btnUpload.Visible = false;
            //btnRun.Visible = true;

            ///////////////////////////////////////////////////////////////////////

            ImportTable("EXT_BOM_EPIC", FolderPath + Bomfilename, "PROJECT_ID");

            ImportTable("EXT_JOINT_EPIC", FolderPath + Weldfilename, "PROJECT_ID");

            ImportTable("EXT_SPOOL_EPIC", FolderPath + Spoolfilename, "PROJECT_ID");


        }
        catch (Exception ex)
        {
            Master.ShowError( "Error in file upload:" + "<br/>" + ex.Message);
        }
    }
    public void ImportTable(string table_name,string file_path,string project_field)
    {
       
        WebTools.ExecNonQuery("DELETE FROM " + table_name);
        FileStream stream;
        DataTable dt;

        stream = new FileStream(file_path, FileMode.Open, FileAccess.Read);

        dt = new DataTable();
        dt = ExcelImport.xlsxToDT2(stream);

       
        ExcelImport.ImportDataTable(dt, table_name, "", project_field, "1");
    }

    protected void btnUploadAmogh_Click(object sender, EventArgs e)
    {
        bool flag;

        flag = fileUploadCutList.HasFile;
        flag = fileUploadSpoolStatus.HasFile;
        flag = fileUploadWeldMTO.HasFile;
        flag = fileUploadBOM.HasFile;
        flag = fileUploadFlange.HasFile;

        string dir_obj = importformat.SelectedValue.ToString();
        if (dir_obj == "")
        {
            RadWindowManager1.RadAlert("Select Import Type Format.", 300, 150, "Warning", "");
            return;
        }

        if (!flag)
        {
            Master.ShowError("One or more file is missing to upload. Please check again and upload.");
            return;
        }


        string cutlistfilename = fileUploadCutList.FileName;
        string Spoolfilename = fileUploadSpoolStatus.FileName;
        string Weldfilename = fileUploadWeldMTO.FileName;
        string Bomfilename = fileUploadBOM.FileName;
        string Flangefilename = fileUploadFlange.FileName;

        if (cutlistfilename != "CUTLIST.xls" && cutlistfilename != "CUTLIST.xlsx")
        {
            Master.ShowError("CUTLIST filename should be CUTLIST.xls/xlsx, re-upload after renaming");
            return;
        }

        if (Spoolfilename != "SPOOL.xls" && Spoolfilename != "SPOOL.xlsx")
        {
            Master.ShowError("SPOOL filename should be SPOOL.xls/xlsx, re-upload after renaming");
            return;
        }

        if (Weldfilename != "JOINT.xls" && Weldfilename != "JOINT.xlsx")
        {
            Master.ShowError("JOINT filename should be JOINT.xls/xlsx, re-upload after renaming");
            return;
        }

        if (Bomfilename != "LOM.xls" && Bomfilename != "LOM.xlsx")
        {
            Master.ShowError("LOM filename should be LOM.xls/xlsx, re-upload after renaming");
            return;
        }

        if (Flangefilename != "SITEJOINT.xls" && Flangefilename != "SITEJOINT.xlsx")
        {
            Master.ShowError("FLANGE filename should be SITEJOINT.xls/xlsx, re-upload after renaming");
            return;
        }

        try
        {

            string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + dir_obj + "'");
            //string FolderPath = "G:\\PDF_DIR\\BIFP\\SG_EXT_DATA\\";
            // System.IO.File.Delete(FilePath);

            //Isometric MTO            
            string FilePath = FolderPath + cutlistfilename;
            fileUploadCutList.SaveAs(FilePath);


            //Spool Status                    
            FilePath = FolderPath + Spoolfilename;
            fileUploadSpoolStatus.SaveAs(FilePath);


            //Welding          
            FilePath = FolderPath + Weldfilename;
            fileUploadWeldMTO.SaveAs(FilePath);

            //BOM           
            FilePath = FolderPath + Bomfilename;
            fileUploadBOM.SaveAs(FilePath);

            //Flange            
            FilePath = FolderPath + Flangefilename;
            fileUploadFlange.SaveAs(FilePath);


            ///////////////////////////////////////////////////////////////////////

            ImportTable("EXT_CUT_LIST_AMOGH", FolderPath + cutlistfilename, "PROJECT_CODE");

            ImportTable("EXT_JOINT_AMOGH", FolderPath + Weldfilename, "PROJECT_CODE");

            ImportTable("EXT_LOM_AMOGH", FolderPath + Bomfilename, "PROJECT_CODE");

            ImportTable("EXT_SITE_JOINT_AMOGH", FolderPath + Flangefilename, "PROJECT_CODE");

            ImportTable("EXT_SPOOL_AMOGH", FolderPath + Spoolfilename, "PROJECT_CODE");
            //////////////////////////////////////////////////////


            Master.ShowSuccess("All Files Uploaded Successfully.");
            //btnUpload.Visible = false;
            //btnRun.Visible = true;
        }
        catch (Exception ex)
        {
            Master.ShowError("Error in file upload:" + "<br/>" + ex.Message);
        }
    }



    protected void AmgBaljoints_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlAmgBaljoints, "Balance_Joints.xls");

    }

    protected void AmpBalFlangeJoints_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlAmpBalFlangeJoints, "Balance_Flange_Joints.xls");
    }

    protected void AmgBalBom_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlAmgBalBom, "Balance_Bom.xls");
    }

    protected void AmgBalSpool_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlAmgBalSpool, "Balance_Spool.xls");
    }

    protected void EpicBalJoint_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlEpicBalJoint, "Balance_Joints.xls");
    }

    protected void EpicBalBom_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlEpicBalBom, "Balance_Bom.xls");
    }

    protected void EpicBalSpool_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlEpicBalSpool, "Balance_Spool.xls");
    }
}