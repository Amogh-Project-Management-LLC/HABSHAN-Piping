using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_BulkPDFUploads : System.Web.UI.Page
{
    string sample_table_name;
    string sample_export_type;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Bulk PDF Uploads";
        }
    }

    protected void CheckIsomeList_SelectedIndexChanged(object sender, EventArgs e)
    {
    
    }
    protected void CheckSpoolList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckIsomeList.SelectedIndex = -1;
        CheckJointList.SelectedIndex = -1;
        CheckMaterialList.SelectedIndex = -1;
     }

    protected void CheckJointList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckIsomeList.SelectedIndex = -1;
        CheckSpoolList.SelectedIndex = -1;
        CheckMaterialList.SelectedIndex = -1;
     }

    protected void CheckMaterialList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckIsomeList.SelectedIndex = -1;
        CheckSpoolList.SelectedIndex = -1;
        CheckJointList.SelectedIndex = -1;
    }

    protected string exportType()
    {
        if (CheckIsomeList.SelectedIndex != -1)
            return CheckIsomeList.SelectedValue;
        else if (CheckSpoolList.SelectedIndex != -1)
            return CheckSpoolList.SelectedValue;
        else if (CheckJointList.SelectedIndex != -1)
            return CheckJointList.SelectedValue;
        else
            return CheckMaterialList.SelectedValue;
    }

  

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {

            if (!WebTools.UserInRole("FILE_UPLOAD"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                return;
            }
            if (CheckIsomeList.SelectedItem == null && CheckSpoolList.SelectedItem == null && CheckJointList.SelectedItem == null)
            {
                lblMessage.Text = "Please select an a Category !";
                return;
            }
            if (RadAsyncUpload1.UploadedFiles.Count == 0)
            {
                lblMessage.Text = "Please select at least one file!";
                return;
            }
            if (RadAsyncUpload1.UploadedFiles.Count > 0)
            {
                string folder = "";
              if(CheckIsomeList.SelectedItem!= null)
                {
                    folder = CheckIsomeList.SelectedItem.Value;
                }
                if (CheckSpoolList.SelectedItem != null)
                {
                    folder = CheckSpoolList.SelectedItem.Value;
                }
                if (CheckJointList.SelectedItem != null)
                {
                    folder = CheckJointList.SelectedItem.Value;
                }

                FileUpload(folder);              
            }
              lblMessage.Text = "";
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    private void FileUpload(string folder)
    {
        int filecount = RadAsyncUpload1.UploadedFiles.Count;
        for (int i = 0; i < filecount; i++)
        {
            string FileName = Path.GetFileName(RadAsyncUpload1.UploadedFiles[i].FileName);
            string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE FOLDER_NAME='" + folder + "'");
            string FilePath = FolderPath + FileName;
            RadAsyncUpload1.UploadedFiles[i].SaveAs(FilePath);
            Master.ShowSuccess("Files Uploaded");
        }
    }
}