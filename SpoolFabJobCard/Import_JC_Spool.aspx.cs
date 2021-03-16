using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;


public partial class SpoolFabJobCard_Import_JC_Spool : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("JC Spool Bulk Import");
        }

    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            //if (!FileUpload1.HasFile) return;

            if (RadAsyncUpload1.UploadedFiles.Count == 0)
            {
                Master.show_error("Please Upload File to proceed.");
                return;
            }


            string user_id = WebTools.GetExpr("USER_ID", "USERS", "USER_NAME='" + Session["USER_NAME"].ToString() + "'");
            string proj_id = Session["PROJECT_ID"].ToString();
           
            string FolderPath = WebTools.SessionDataPath();
            string FileName = Path.GetFileName(RadAsyncUpload1.UploadedFiles[0].FileName);
            string Extension = Path.GetExtension(RadAsyncUpload1.UploadedFiles[0].FileName);
            string FilePath = FolderPath + FileName;
          
            RadAsyncUpload1.UploadedFiles[0].SaveAs(FilePath);
          
            WebTools.ExecNonQuery("DELETE FROM PIP_BULK_JC_SHOP_IMPORT WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND USER_ID="+user_id);

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);
           DataColumn user_id_col= new DataColumn("USER_ID", typeof(int));
            user_id_col.DefaultValue = int.Parse(user_id);
            dt.Columns.Add(user_id_col);

            ExcelImport.ImportDataTable(dt, "PIP_BULK_JC_SHOP_IMPORT", "", "PROJECT_ID", proj_id);
            Master.show_success("Proceed to check status");
            btnProceed.Visible = true;
    }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnProceed_Click(object sender, EventArgs e)
    {
        Master.Dispose();
        string user_id = WebTools.GetExpr("USER_ID", "USERS", "USER_NAME='" + Session["USER_NAME"].ToString() + "'");
        Response.Redirect("Import_JC_Spool_Data.aspx?user_id=" + user_id);
    }
}