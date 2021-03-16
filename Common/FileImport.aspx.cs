using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Common_FileImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Import Files");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (RadAsyncUpload1.UploadedFiles.Count == 0 && RadAsyncUpload2.UploadedFiles.Count == 0)
            {
                Master.show_error("Please Upload File to proceed.");
                return;
            }
            if(Request.QueryString["REF_ID"]=="")
            {
                Master.show_error("Select Request Number To Upload");
                return;
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////////
            if (RadAsyncUpload1.UploadedFiles.Count > 0)
            {
                int type_id = int.Parse(Request.QueryString["TYPE_ID"]);
                int ref_id = int.Parse(Request.QueryString["REF_ID"].ToString());
                string proj_id = Session["PROJECT_ID"].ToString();

                string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
                string f_name = "";
                string dir_obj = "";
                string dir_id = "";
                string delquery = "";
                // string irn_id = itemsGrid.SelectedValue.ToString();
                switch (type_id)
                {
                    case 1:
                        f_name = WebTools.GetExpr("REQ_NO", "PIP_MAT_SUBSTITUTE", " WHERE REQ_ID='" + ref_id + "'");
                        dir_obj = "MAT_SUBSTITUTE";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                 

                }
                f_name = f_name.Replace("/", "-");
                string Extension = Path.GetExtension(RadAsyncUpload1.UploadedFiles[0].GetExtension());
                string FileName = f_name + Extension;
                string u_file_name = Path.GetFileName(RadAsyncUpload1.UploadedFiles[0].GetNameWithoutExtension());
              
                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_OBJ='"+dir_obj+"'");
                string FilePath = FolderPath + FileName;
                System.IO.File.Delete(FilePath);
                RadAsyncUpload1.UploadedFiles[0].SaveAs(FilePath);
               
                string query = "INSERT INTO PIP_FILE_UPLOAD(TYPE_ID,REF_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,CREATED_BY) VALUES(" + type_id + "," + ref_id + ",'"+FileName+"','" + Extension + "','" + dir_id + "','" + u_file_name + "',"+decimal.Parse(user_id)+")";
                WebTools.ExeSql(query);
                Master.show_success("File Uploaded");
            }

            if(RadAsyncUpload2.UploadedFiles.Count>0)
            {

                int type_id = int.Parse(Request.QueryString["TYPE_ID"]);
                int ref_id = int.Parse(Request.QueryString["REF_ID"].ToString());
                string proj_id = Session["PROJECT_ID"].ToString();

                string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
                int filecount = RadAsyncUpload2.UploadedFiles.Count;

                string maxdoc = WebTools.CountExpr("REF_ID", "PIP_SUPP_FILE_UPLOAD", " WHERE TYPE_ID = " +type_id+" AND REF_ID = "+ref_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc)+1;
                }
                for (int i=0;i<filecount;i++)
                {
                    string f_name = "";
                    string dir_obj = "";
                    string dir_id = "";
                    // string irn_id = itemsGrid.SelectedValue.ToString();
                    switch (type_id)
                    {

                        case 1:
                            f_name = WebTools.GetExpr("REQ_NO", "PIP_MAT_SUBSTITUTE", " WHERE REQ_ID='" + ref_id + "'");
                            dir_obj = "MAT_SUBST_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                      
                          
                    }
                    f_name = f_name.Replace("/", "-");
                    
                    string Extension = Path.GetExtension(RadAsyncUpload2.UploadedFiles[i].GetExtension());
                    string FileName = f_name+"_"+ doccnt++ + Extension;
                    string u_file_name = Path.GetFileName(RadAsyncUpload2.UploadedFiles[i].GetNameWithoutExtension());
                    u_file_name = u_file_name.Replace("'", "");
                    string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                    string FilePath = FolderPath + FileName;
        
                    RadAsyncUpload2.UploadedFiles[i].SaveAs(FilePath);

                    string query = "INSERT INTO PIP_SUPP_FILE_UPLOAD(TYPE_ID,REF_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,CREATED_BY) VALUES(" + type_id + "," + ref_id + ",'" + FileName + "','" + Extension + "','" + dir_id + "','" + u_file_name + "'," + decimal.Parse(user_id) + ")";
                    WebTools.ExeSql(query);
                    Master.show_success("Files Uploaded");
                }
            }         
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

   
       
    
}