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
using Telerik.Web.UI.PersistenceFramework;

public partial class Home_Flange_Basic_Data : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Flange Management Torque Detail";
            if (!WebTools.UserInRole("FLANGE_TORQUE_INSERT"))
            {
                btnSave.Visible = false;
            }
        }
        try
        {
            if (Session["FLANGE_BASIC_SESSION"] != null)
            {

                RadPersistenceManager1.LoadState();
                FlangeGridView.Rebind();

            }
        }
        catch (Exception ex)
        {

        }
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/IsomeIndex.aspx");
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("FLANGE_TORQUE_INSERT"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        if (!EntryTable.Visible)
        {
            btnSave.Visible = true;
            EntryTable.Visible = true;
        }
        else
        {
            btnSave.Visible = false;
            EntryTable.Visible = false;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string code_exist = WebTools.GetExpr("UPPER(MAT_CODE1)", "PIP_SITE_JOINTS_IPMS", " WHERE UPPER(MAT_CODE1)='" + txtMAT_CODE1.Text.ToUpper().Trim() + "'");
            if (code_exist != txtMAT_CODE1.Text.ToUpper().Trim())
            {
                FlangeDataSource.Insert();
                Master.ShowMessage(" Saved succesfully!");
            }
            else
            {
                Master.ShowWarn(code_exist + " Invalid Data!");
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }

    }
    protected void FlangeGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("FLANGE_TORQUE_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("FLANGE_TORQUE_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }

    }
    public class SessionStorageProvider : IStateStorageProvider
    {
        private System.Web.SessionState.HttpSessionState session = HttpContext.Current.Session;
        static string storageKey;

        public static string StorageProviderKey
        {
            set { storageKey = value; }
        }

        public void SaveStateToStorage(string key, string serializedState)
        {
            session[storageKey] = serializedState;
        }

        public string LoadStateFromStorage(string key)
        {

            return session[storageKey].ToString();
        }
    }



    protected void FlangeGridView_PreRender(object sender, EventArgs e)
    {

        SessionStorageProvider.StorageProviderKey = "FLANGE_BASIC_SESSION";
        RadPersistenceManager1.SaveState();
    }
}