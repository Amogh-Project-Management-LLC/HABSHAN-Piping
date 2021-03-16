using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_MaterialLengthUpd : System.Web.UI.Page
{
    protected static string error_file_location; // = WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT_ERROR'");
    protected static string sg_text_location;   //WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT'");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadInitialData();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AmoghUpdates.aspx");
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        //Read Cat File:
        //Telerik.Web.UI.fileco
        sg_text_location = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\";
        //Session["SessionID"] = Session.SessionID;
        string catfilePaths = sg_text_location + "CAT\\";
        string ciffilePaths = sg_text_location + "CIF\\";

        
    }


    public void LoadInitialData()
    {
        try
        {
            sg_text_location = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\";
            
            Session["SessionID"] = Session.SessionID;
            string[] catfilePaths = Directory.GetFiles(sg_text_location + "CAT\\");
            string[] ciffilePaths = Directory.GetFiles(sg_text_location + "CIF\\");

            foreach (var lomfiles in catfilePaths)
            {
                FileInfo info = new FileInfo(lomfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }

            foreach (var cutfiles in ciffilePaths)
            {
                FileInfo info = new FileInfo(cutfiles);
                if (info.Exists)
                {
                    info.Delete();
                }
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }
}