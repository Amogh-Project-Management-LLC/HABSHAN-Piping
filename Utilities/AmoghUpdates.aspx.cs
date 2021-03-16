using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public partial class Utilities_AmoghUpdates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("SECOND_ADMIN"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Amogh Updates";
            //Master.AddModalPopup("~/Utilities/LineMTOImport.aspx", btnLineMTOImport.ClientID, 600, 600);
            RadTabStrip1.Tabs[0].Selected = true;
            RadMultiPage1.SelectedIndex = 0;

            if (Session["LAST_TAB"] != null)
            {
                RadMultiPage1.SelectedIndex = Int32.Parse(Session["LAST_TAB"].ToString());
                RadTabStrip1.SelectedIndex = Int32.Parse(Session["LAST_TAB"].ToString());
            }

            Master.AddModalPopup("~/Utilities/LineMTOImport.aspx", btnLineMTOImport.ClientID, 250, 600);
            Master.AddModalPopup("~/Utilities/ImportIDFMTO.aspx", btnIsoMTOImport.ClientID, 250, 600);
            Master.AddModalPopup("~/Utilities/SmlForLineMto.aspx", btnLineMTOSimulation.ClientID, 250, 600);
            //Master.AddModalPopup("~/Utilities/SmlForIdfMto.aspx", btnSimulIsoMTO.ClientID, 250, 600);
            Master.AddModalPopup("~/Utilities/PPCSCustomSrn.aspx", btnSRNUpdate.ClientID, 600, 800);
            Master.AddModalPopup("~/Utilities/CollectPDF.aspx", btnCollectPDF.ClientID, 500, 740);
            Master.AddModalPopup("~/Utilities/SmlForTemp.aspx", btnSimulTemp.ClientID, 500, 740);
            Master.AddModalPopup("~/Utilities/IsoAttribute.aspx", btnAttriImport.ClientID, 500, 740);
            //Master.AddModalPopup("~/Utilities/ShopSimulation.aspx", btnSimulShopBOM.ClientID, 600, 800);
            //Master.AddModalPopup("~/Utilities/UnregisteredIDF.aspx", btnDeleteUnRegIDF.ClientID, 500, 740);
            //Master.AddModalPopup("~/Utilities/SiteSimulation.aspx", btnSimulSiteBOM.ClientID, 600, 800);
            //Master.AddModalPopup("~/Utilities/POAddOn.aspx", btnAddOnPO.ClientID, 600, 900);
            disableOptions();
            CheckRunningProcess();
            btnRefresh_Click(sender, e);
        }
    }

    protected void btnLineMTO_Click(object sender, EventArgs e)
    {
        //Master.HeadingMessage = "Server Click Event";
    }

    protected void disableOptions()
    {
        //btnSGExcelImport.Enabled = false;
    }

    protected void btnPOUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            string po_status = "", any_update_run_count = "";

            any_update_run_count = WebTools.CountExpr("PROCESS_NAME", "PROJECT_JOB_LIST", "CURRENT_STATUS='RUNNING' "
                + " AND (PROCESS_NAME LIKE '%SIMULATION%' OR PROCESS_GROUP='SERVER_UPDATE')");

            po_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='IMPORT_PO_DATA'");

            if ((po_status.Equals("COMPLETED") || po_status.Equals("REQUEST_TO_RUN"))
                                        && any_update_run_count.Equals("0"))
            {
                string sql = "";
                sql = "UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='IMPORT_PO_DATA'";
                WebTools.ExeSql(sql);

                sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='IMPORT_PO_DATA'");
                WebTools.ExeSql(sql);
                Master.ShowMessage("You request is under process, please wait...");
                SetPPCSRunning();
            }
            else if (!po_status.Equals("RUNNING"))
            {
                WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='REQUEST_TO_RUN' WHERE  PROCESS_NAME='IMPORT_PO_DATA'");
                Master.ShowMessage("You request is under process, please wait...");
            }
            else
                Master.ShowWarn("<font color='red'>Sorry, your request can not be processed now !!!</font>");
        }
        catch (Exception exc)
        {
            Master.ShowWarn(exc.Message);
        }
    }

    protected void CheckRunningProcess()
    {
        string status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " PROCESS_NAME = 'IMPORT_PO_DATA'");
        if (status == "RUNNING")
        {
            menuUpdPOLink.Items[0].Text = "Processing";
            menuUpdPOLink.Items[0].Enabled = false;
        }
    }

    protected void SetPPCSRunning()
    {
        string status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " PROCESS_NAME = 'IMPORT_PO_DATA'");
        if (status == "RUNNING")
        {

            menuUpdPOLink.Items[0].Text = "Processing";
            menuUpdPOLink.Items[0].Enabled = false;
        }
    }

    protected void ddPackageSelect_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvExceptions.DataBind();
    }

    protected void ddStepsStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectCommand = "";

        if (!ddStepsStatus.SelectedValue.Equals("ALL"))
        {
            selectCommand = "SELECT * FROM VIEW_RUNNING_PROCESSES WHERE STATUS='" + ddStepsStatus.SelectedValue + "'";
            dsProcesses.SelectCommand = selectCommand;
        }
        dsProcesses.DataBind();
        gvProcesses.DataBind();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        try
        {
            lblPdfStatus.Text = "<b>PDF Upload Status</b>"
                              + "<br /><font color=Blue>Start Date : </font>" + WebTools.GetExpr("START_DATE", "PROJECT_JOB_LIST", "PROCESS_NAME='PDF UPLOAD STATUS'")
                               + "<br /><font color=Blue>Complete Date : </font>" + WebTools.GetExpr("COMPLETE_DATE", "PROJECT_JOB_LIST", "PROCESS_NAME='PDF UPLOAD STATUS'");

            lblPOStatus.Text = "<b>PO Link Update</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'PO_CLIENT_LINK_UPDATE')", "dual", "1=1");

            lblUpdateStatus.Text = "<b>Server Update</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'PKG_UPDATE_ALL')", "dual", "1=1");

            lblShopSimStatus.Text = "<b>Shop BOM Simulation</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'P_PROCESS_SHOP_SIMULATION')", "dual", "1=1");

            lblSiteSimStatus.Text = "<b>Site BOM Simulation</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'P_PROCESS_SITE_SIMULATION')", "dual", "1=1");

            lblIsoMTOSimStatus.Text = "<b>ISO MTO Simulation</b>"
                                + WebTools.GetExpr("fnc_get_running_process('SUMMARY', 'IDF_MTO_SIMULATION')", "dual", "1=1");
            gvExceptions.DataBind();
            gvProcesses.DataBind();
            lblMessage.Text = "";

        }
        catch (Exception exc)
        {
            lblMessage.Text = exc.Message;
        }
    }

    protected void btnCheckCurrentStatus_Click(object sender, EventArgs e)
    {
        errorTable.Visible = false;
        processTable.Visible = true;
        gvProcesses.DataBind();
    }

    protected void btnStopJobs_Click(object sender, EventArgs e)
    {
        WebTools.exec_non_qry("BEGIN PROC_STOP_JOBS(); END;");
        lblMessage.Text = "All running jobs are stopped";
    }

    protected void btnCheckException_Click(object sender, EventArgs e)
    {
        errorTable.Visible = true;
        processTable.Visible = false;
        lblMessage.Text = "Please note: Exceptions will be cleared each time when its respective PACKAGE starts running !";
        ddPackageSelect_SelectedIndexChanged(sender, e);
    }

    protected void btnSetFlagCmplt_Click(object sender, EventArgs e)
    {
        WebTools.ExeSql("UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='COMPLETED'");
        WebTools.ExeSql("UPDATE SIMULATION_HEADER SET STATUS='PS' WHERE STATUS<>'PS'");
        WebTools.ExeSql("UPDATE UPDATE_HEADER SET STATUS='PS' WHERE STATUS<>'PS'");
        lblMessage.Text = "All running & waiting flags are set as Completed";
    }

    protected void btnServerUpdate_Click(object sender, EventArgs e)
    {
        Response.Redirect("ServerUpdates.aspx");
    }

    //protected void btnUpdateTalisman_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("ImportTalismanData.aspx");
    //}

    protected void btnAddOnPO_Click(object sender, EventArgs e)
    {
        Response.Redirect("POAddOn.aspx");
    }

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        Session["LAST_TAB"] = RadTabStrip1.SelectedIndex;
    }

    protected void btnSGTextImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("ImportSGText.aspx");
    }

    protected void btnAttriImport_Click(object sender, EventArgs e)
    {

    }

    protected void btmMatLength_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialLengthUpd.aspx");
    }

    protected void btnDeleteUnRegIDF_Click(object sender, EventArgs e)
    {
        //Delete Isometric MTO of drawings which are not yet received or deleted. 
        try
        {
            string status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", "PROCESS_NAME='DELETE_X_REVISION_ISO'");

            if (status.Equals("COMPLETED"))
            {
                string sql = "";
                sql = "UPDATE PROJECT_JOB_LIST SET CURRENT_STATUS='RUNNING' WHERE  PROCESS_NAME='DELETE_X_REVISION_ISO'";
                WebTools.ExeSql(sql);
                sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='DELETE_X_REVISION_ISO'");
                WebTools.ExeSql(sql);
                lblMessage.Text = "You request is under process, please wait...";
            }
            else
                lblMessage.Text = "<font color='red'>Sorry, your request can not be processed now !!!</font>";
        }
        catch (Exception exc)
        {
            lblMessage.Text = exc.Message;
        }
    }

    protected void btnSimulSiteBOM_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Utilities/Simulation.aspx?SML_CAT=SITE");
    }

    protected void btnSimulShopBOM_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Utilities/Simulation.aspx?SML_CAT=SHOP");
    }

    protected void btnSimulIsoMTO_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Utilities/SmlForIdfMto.aspx");
    }

    protected void btnSGExcelImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Utilities/ImportSGExcel.aspx");
    }
    protected void btmBulkImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/AdminPage.aspx");
    }


    
    protected void btnPDFFlag_Click(object sender, EventArgs e)
    {

        //    string query = "SELECT * from PDF_UPLOAD";
        //    DataTable dt = General_Functions.GetDataTable(query);
        //    string result = "";
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        result += General_Functions.UpdatePDFlag(row["DIROBJ"].ToString(), row["TABLENAME"].ToString(), row["SEARCHCOLUMN"].ToString(), row["SEARCHCOLUMNID"].ToString(), row["UPDATETABLE"].ToString(), row["UPDATECOLUMN"].ToString()) + "  ";
        //        if (result.Contains("Error:"))
        //        {
        //            result += "Error directory:" + row["DIROBJ"].ToString() + " ";
        //        }
        //    }
        //    if (result.Contains("Error:"))
        //    {
        //        Master.ShowMessage(result);
        //    }
        //    else
        //    {
        //        Master.ShowMessage("PDF Flag Successfully Updated!");
        //    }
        try
        {
            string status_query = "UPDATE PROJECT_JOB_LIST SET START_DATE ='" + DateTime.Now + "' WHERE PROCESS_NAME ='PDF UPLOAD STATUS'";
            WebTools.ExeSql(status_query);
            string query = "SELECT * FROM DIR_OBJECTS WHERE VISIBLE='Y'";
            string delete_query = "DELETE FROM TABLE_PDF_FLAG";
            WebTools.ExeSql(delete_query);

            DataTable dt = General_Functions.GetDataTable(query);
            foreach (DataRow row in dt.Rows)
            {
                DataTable dt1 = new DataTable();
                string PATH = WebTools.GetExpr("PATH", "DIR_OBJECTS", " DIR_ID='" + row["DIR_ID"] + "' ");
                DirectoryInfo d = new DirectoryInfo(@PATH);
                FileInfo[] Files = d.GetFiles("*.pdf");
                string str = "";
                foreach (FileInfo file in Files)
                {
                    str = "INSERT INTO TABLE_PDF_FLAG (DIR_ID,PATH) VALUES ("+ row["DIR_ID"] +",'"+file.Name+"' )";
                    WebTools.ExeSql(str);
                }
                status_query = "UPDATE PROJECT_JOB_LIST SET COMPLETE_DATE ='" + DateTime.Now + "' WHERE PROCESS_NAME ='PDF UPLOAD STATUS'";
                WebTools.ExeSql(status_query);
                Master.ShowMessage("PDF flags has been updated");
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }
}