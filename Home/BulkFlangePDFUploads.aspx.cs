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

public partial class BulkFlangePDFUploads : System.Web.UI.Page
{
    string sample_table_name;
    string sample_export_type;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Bulk Flange PDF Uploads";
        }
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
            if (CheckFlange.SelectedItem == null)
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
              if(CheckFlange.SelectedItem!= null)
                {
                    folder = CheckFlange.SelectedItem.Value;
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