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

public partial class Home_FlangeSys_PID_Data : System.Web.UI.Page
{
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string system = WebTools.GetExpr("SYSTEM_NO||'_'||SUB_SYSTEM_NO", "FLANGE_SYS_DATA", " WHERE SEQ=" + Request.QueryString["SEQ"]);
            Master.HeadingMessage ( "PID Data Sys & Sub System("+ system+")");
            
            if (!WebTools.UserInRole("FLANGE_PID_INSERT"))
            {
                btnSave.Visible = false;
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
            string code_exist = WebTools.GetExpr("UNIQ_ID", "FLANGE_SYSPID_DATA", " WHERE PID_SEQ='" + RadcobPidNo.SelectedValue+ "' AND " +
                "SEQ=" + Request.QueryString["SEQ"]);
            if (code_exist.Length==0 )
            {
                FlangeDataSource.Insert();
                FlangeGridView.DataBind();
                Master.show_success(" Saved succesfully!");
            }
            else
            {
                Master.show_error("Already exist Data!");
            }
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }

    }
    protected void FlangeGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("FLANGE_PID_EDIT"))
            {
                Master.show_error("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("FLANGE_PID_DELETE"))
            {
                Master.show_error("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        

    }





    protected void RadcobPidNo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (RadcobPidNo.SelectedValue.Length>0)
        {
            string pid_area = WebTools.GetExpr("AREA", "FLANGE_PID_DATA", " PID_SEQ=" + RadcobPidNo.SelectedValue);
            string pid_descr = WebTools.GetExpr("PID_DESCR", "FLANGE_PID_DATA", " PID_SEQ=" + RadcobPidNo.SelectedValue);
            txtArea.Text = pid_area;
            txtPID_DESCR.Text = pid_descr;
        }
        
    }
}