using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.OracleClient;
using System.Configuration;
using Ionic.Zip;
using System.Text;
using System.Timers;

public partial class Utilities_Simulation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Server Updates";

        try
        {
            //testing on timezone
            //TimeZone zone = TimeZone.CurrentTimeZone;
            //string standard = zone.StandardName;
            //string daylight = zone.DaylightName;
            ////lblExportMessage.Text = standard + "/" + daylight;
            //DateTime utcTime = DateTime.UtcNow;
            //TimeZoneInfo myZone = TimeZoneInfo.FindSystemTimeZoneById(standard);
            //DateTime custDateTime = TimeZoneInfo.ConvertTimeFromUtc(utcTime, myZone);
            ////lblExportMessage.Text = lblExportMessage.Text + "/" + custDateTime.ToString("dd-MMM-yyyy HH:mm:ss");
            //lblExportMessage.Text = "Current server time : " + DateTime.Today.ToString("dd-MMM-yyyy hh:mm tt");
            if (!IsPostBack)
            {
                RadTabStrip1.Tabs[0].Selected = true;
                RadMultiPage1.SelectedIndex = 0;
                if (Session["LAST_SERVER_UPD_TAB"] != null)
                {
                    RadMultiPage1.SelectedIndex = Int32.Parse(Session["LAST_SERVER_UPD_TAB"].ToString());
                    RadTabStrip1.SelectedIndex = Int32.Parse(Session["LAST_SERVER_UPD_TAB"].ToString());
                }
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Utilities/AmoghUpdates.aspx");
    }

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        Session["LAST_SERVER_UPD_TAB"] = RadTabStrip1.SelectedIndex;
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        gridUpdHistory.DataBind();
        grdiProgress.DataBind();
        lblExportMessage.Text = "";
    }

    protected void btnProceed_Click(object sender, EventArgs e)
    {
        string process_name = "UPDATE_ALL";
        string upd_status = WebTools.GetExpr("CURRENT_STATUS", "PROJECT_JOB_LIST", " WHERE PROCESS_NAME = '" + process_name + "'");
        if (upd_status.Equals("RUNNING"))
        {
            Master.ShowWarn("Server update is running, please check status of project jobs!");
            return;
        }

        upd_status = WebTools.CountExpr("STATUS", "UPDATE_HEADER", " WHERE STATUS = 'PR'");
        if (!upd_status.Equals("0"))
        {
            Master.ShowWarn("Server update is running, please check status of update headers!");
            return;
        }

        try
        {
            string sql = WebTools.GetExpr("SQL_TO_RUN", "PROJECT_JOB_LIST", " PROCESS_NAME='" + process_name + "'");
            WebTools.ExeSql(sql);
            string user_id = WebTools.GetExpr("USER_ID", "USERS", "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper().Trim() + "'");
            sql = "INSERT INTO UPDATE_HEADER(UPD_USER_ID, UPD_DATE, STATUS) VALUES ('" + user_id + "',SYSDATE,'PR')";
            WebTools.ExeSql(sql);

            gridUpdHistory.DataBind();
            grdiProgress.DataBind();
            Master.ShowMessage("Server update run started...");
        }
        catch (Exception exc)
        {
            if (exc.Message.Contains("ORA-27478"))
                Master.ShowWarn("Server Update is already running !!!");
            else
                Master.ShowWarn(exc.Message);
        }
    }
}