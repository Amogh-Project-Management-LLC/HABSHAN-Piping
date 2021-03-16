using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using Ionic.Zip;
using System.Data.OracleClient;

public partial class Material_Reports_JC_MIV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string filter_ = Session["JC_MIV_FILTER"].ToString();
            if (filter_ != "") txtSearch.Text = filter_;
            Master.HeadingMessage = "Job Card MIV";
            Master.AddModalPopup("~/SpoolFabJobCard/JC_MIV_Register.aspx", btnRegister.ClientID, 450, 550);
            Master.RadGridList = mivGridView.ClientID;
        }
    }
  
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_Register.aspx");
    }
    protected void btnMaterials_Click(object sender, EventArgs e)
    {
        if (mivGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV number!");
            return;
        }
        string wo_id = WebTools.GetExpr("WO_ID", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
            mivGridView.SelectedValue.ToString());
        Response.Redirect("JC_MIV_Rev.aspx?ISSUE_ID=" + mivGridView.SelectedValue.ToString() +
            "&WO_ID=" + wo_id);
    }
    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (mivGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV number!");
            return;
        }
        string wo_id = WebTools.GetExpr("WO_ID", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
            mivGridView.SelectedValue.ToString());
        Response.Redirect("JC_MIV_Spools.aspx?ISSUE_ID=" + mivGridView.SelectedValue.ToString() +
            "&WO_ID=" + wo_id);
    }
    protected void btnMivMats_Click(object sender, EventArgs e)
    {
        if (mivGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=16&Arg1=" + mivGridView.SelectedValue.ToString());
    }
    protected void btnMivSpool_Click(object sender, EventArgs e)
    {
        if (mivGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV number!");
            return;
        }
        string report_id;
        if (Session["PROJECT_ID"].ToString() == "1")
        {
            report_id = "17";
        }
        else
        {
            report_id = "17.1";
        }
        Response.Redirect("ReportViewer.aspx?ReportID=" + report_id + "&Arg1=" +
            mivGridView.SelectedValue.ToString());
    }
    protected void btnPreview1_Click(object sender, EventArgs e)
    {
        if (mivGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the MIV number!");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=18&Arg1=" + mivGridView.SelectedValue.ToString());
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["JC_MIV_FILTER"] = txtSearch.Text;
    }
    protected void btnCutPlan_Click(object sender, EventArgs e)
    {
        if (is_selected() == true)
        {
            Response.Redirect("JC_MIV_CutPlan.aspx?ISSUE_ID=" + mivGridView.SelectedValue.ToString());
        }
    }
    private bool is_selected()
    {
        if (mivGridView.SelectedIndexes.Count== 0)
        {
            Master.ShowMessage("Select the MIV number!");
            return false;
        }
        else
        {
            return true;
        }
    }

    protected void ddlReportType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (is_selected())
        {
            switch (ddlReportType.SelectedValue.ToString())
            {
                case "1":
                        Response.Redirect("ReportViewer.aspx?ReportID=17&Arg1=" + mivGridView.SelectedValue.ToString());    
                        break;
                case "2":
                        Response.Redirect("ReportViewer.aspx?ReportID=18&Arg1=" + mivGridView.SelectedValue.ToString());
                        break;
                case "3":
                        Response.Redirect("ReportViewer.aspx?ReportID=16&Arg1=" + mivGridView.SelectedValue.ToString());
                        break;
                case "4":
                    Response.Redirect("ReportViewer.aspx?ReportID=21&Arg1=" + mivGridView.SelectedValue.ToString());
                    break;
                case "5":
                    Response.Redirect("ReportViewer.aspx?ReportID=22&Arg1=" + mivGridView.SelectedValue.ToString());
                    break;

            }
        }

    }

    protected void btnBulkJCMIVSpool_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=34&RetUrl=~/SpoolFabJobCard/JC_MIV.aspx");
    }

   

    protected void btnCollectPDFs_Click(object sender, EventArgs e)
    {
        if (mivGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the Jobcard MIV no!");
            return;
        }

        string jc_miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", "ISSUE_ID=" + mivGridView.SelectedValue.ToString()).Replace("/", "_");
        string path = WebTools.SessionDataPath();
        string zip_file_path = path + jc_miv_no + ".zip";

        //ZipFile
        using (ZipFile zip = new ZipFile())
        {
            CollectPDFs(zip);
            zip.Save(zip_file_path);
        }

        var updateFile = new FileInfo(zip_file_path);
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("content-disposition", "attachment;filename=\"" + Path.GetFileName(updateFile.FullName) + "\"");
        Response.AddHeader("content-length", updateFile.Length.ToString());
        Response.TransmitFile(updateFile.FullName);
        Response.Flush();
    }
    private void CollectPDFs(ZipFile zip_file)
    {
        //string path = WebTools.SessionDataPath();
        string sql = "";
        string FileName = "";
        string folderPath = WebTools.GetExpr("path", "dir_objects", " dir_obj='ISO_SPOOLGEN'");
        string filePath = string.Empty;
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            //Isometric
            sql = "SELECT * FROM VIEW_ISO_PDF_BLOB_WO_MIV WHERE ISSUE_ID=" + mivGridView.SelectedValue.ToString();
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];
                        if (File.Exists(FileName))
                            File.Delete(FileName);
                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }

                    }
                }//OracleDataReader1
            }//OracleCommand1

            //Spool Piece
            sql = "SELECT * FROM VIEW_SPOOL_PDF_WO_MIV WHERE ISSUE_ID=" + mivGridView.SelectedValue.ToString();
            folderPath = WebTools.GetExpr("path", "dir_objects", " dir_obj='SPL_SPOOLGEN'");
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];
                        if (File.Exists(FileName))
                            File.Delete(FileName);
                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }
                    }
                }//OracleDataReader2
            }//OracleCommand2

            // Iso As Built
            sql = "SELECT * FROM VIEW_ISO_PDF_BLOB_WO_MIV WHERE ISSUE_ID=" + mivGridView.SelectedValue.ToString();
            folderPath = WebTools.GetExpr("path", "dir_objects", " dir_obj='ISO_AB'");
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];
                        if (File.Exists(FileName))
                            File.Delete(FileName);
                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }
                    }
                }//OracleDataReader2
            }//OracleCommand2

        }//OracleConnection
    }

    protected void mivGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("JC_MIV_REQUEST_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("JC_MIV_REQUEST_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
}