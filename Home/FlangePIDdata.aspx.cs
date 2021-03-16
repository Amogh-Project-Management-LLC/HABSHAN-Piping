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
using Telerik.Web.UI;
using System.IO;
using System.Drawing;

public partial class Home_FlangePIDmain_Data : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        RadPersistenceManager1.StorageProvider = new SessionStorageProvider();

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Flange Management PID Data";
            
            if (!WebTools.UserInRole("FLANGE_PID_INSERT"))
            {
                btnSave.Visible = false;
            }
            try
            {
                string from = Request.UrlReferrer.ToString();
                string here = Request.Url.AbsoluteUri.ToString();

                if (from != here)
                    Session["FlangePIDmainpage"] = Request.UrlReferrer.ToString();
            }
            catch (Exception ex)
            {

            }
            try
            {
                if (Session["FLANGE_PIDmain_SESSION"] != null)
                {

                    RadPersistenceManager1.LoadState();
                    FlangeGridView.Rebind();

                }
            }
            catch (Exception ex)
            {

            }

        }
        
    }


  
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("FLANGE_PID_INSERT"))
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
            string code_exist = WebTools.GetExpr("PID_NUMBER", "FLANGE_PID_DATA", " WHERE UPPER(PID_NUMBER)='" + txtPID_NUMBER.Text.ToUpper().Trim()+"'" );
            if (code_exist.Length==0 )
            {
                FlangeDataSource.Insert();
                FlangeGridView.DataBind();
                Master.ShowSuccess(" Saved succesfully!");
            }
            else
            {
                Master.ShowError("Already exist Data!");
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }

    }
    protected void FlangeGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("FLANGE_PID_EDIT"))
            {
                Master.ShowError("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("FLANGE_PID_DELETE"))
            {
                Master.ShowError("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        

    }



   

    protected void btnBack_Click(object sender, EventArgs e)
    {
        object refUrl = Session["FlangePIDmainpage"];
        if (refUrl != null)
            Response.Redirect((string)refUrl);
    }

    protected void FlangeGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {

            GridDataItem item = (GridDataItem)e.Item;
            string PID_NUMBER = item["PID_NUMBER"].Text.ToString();
            string uniq = PID_NUMBER.Replace("/", "_");
            string filename = uniq + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PIDHC'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PIDHC'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");


            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='Hard Copy PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
            string filename1 = uniq + ".pdf";

            string pdf_url1 = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PIDMARKUP'");
            string pdf_asp_url1 = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PIDMARKUP'");

            string full_pdf_path1 = pdf_url1 + filename1;
            string full_asp_path1 = pdf_asp_url1 + filename1;
            Label pdf_label1 = (Label)item.FindControl("MPpdf");


            if (File.Exists(full_pdf_path1))
            {
                string url = "<a title='Markup Copy PDF' href='" + full_asp_path1 + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("MPpdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }

            if (item["FINAL_STATUS"].Text.Contains("COMPLETED"))
            {
                item["FINAL_STATUS"].ForeColor = Color.Green;

            }
            else if (item["FINAL_STATUS"].Text.Contains("BALANCE"))
            {
                item["FINAL_STATUS"].ForeColor = Color.Orange;
            }
            else
            {
                item["FINAL_STATUS"].ForeColor = Color.Red;
            }

        }
    }
    protected void FlangeGridView_PreRender(object sender, EventArgs e)
    {
        SessionStorageProvider.StorageProviderKey = "FLANGE_PIDmain_SESSION";
        RadPersistenceManager1.SaveState();
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

}