using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_IsoAttribute : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Isometric Attribute Details");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (!FileUpload1.HasFile) return;

            string proj_id = Session["PROJECT_ID"].ToString();
            string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string Extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string FolderPath = WebTools.SessionDataPath();

            string FilePath = FolderPath + FileName;
            FileUpload1.SaveAs(FilePath);

            // delete old data
            WebTools.ExecNonQuery("DELETE FROM TBL_ISO_ATTRIB_IMP WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            ExcelImport.ImportDataTable(dt, "TBL_ISO_ATTRIB_IMP", "", "PROJECT_ID", proj_id);

            WebTools.ExecNonQuery("BEGIN " +
                                            "PKG_PAGE_VALIDATION.PROC_UDPATE_ISO_ATTRIBUTE; " +
                                            " END;");

            string ErrorCount = WebTools.CountExpr("ISO_TITLE1", "TBL_ISO_ATTRIB_IMP", " ISO_ID IS NULL OR ERROR_MSG IS NOT NULL");

            Master.show_success("Isometric Attribute Data Imported Successfully with " + ErrorCount + " Errors.");

            if (Convert.ToInt32(ErrorCount) > 0)
                linkDownloadError.Visible = true;

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void linkDownloadError_Click(object sender, EventArgs e)
    {
        //Response.Redirect()
        WebTools.ExportDataSetToExcel(SqlDataSource1, "ISO_ATTRIBUTE_IMPORT_ERROR.xls");
    }
}