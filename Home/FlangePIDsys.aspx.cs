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

public partial class Home_FlangePID_sys_Data : System.Web.UI.Page
{
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string pid_no = WebTools.GetExpr("PID_NUMBER", "FLANGE_PID_DATA", " PID_SEQ='" + Request.QueryString["PID_SEQ"] + "'");
            Master.HeadingMessage ("Sys & Sub System Data(" + pid_no + ")");

            if (!WebTools.UserInRole("FLANGE_SYSTEM_INSERT"))
            {
                btnSave.Visible = false;
            }
        }
        
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("FLANGE_SYSTEM_INSERT"))
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
            int code_exist = int.Parse(WebTools.CountExpr("UNIQ_ID", "FLANGE_SYSPID_DATA", " WHERE PID_SEQ='" + Request.QueryString["PID_SEQ"] + "' AND " +
                "SEQ=" + RadcobSysSub.SelectedValue));
            if (code_exist == 0)
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
            if (!WebTools.UserInRole("FLANGE_SYSTEM_EDIT"))
            {
                Master.show_error("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("FLANGE_SYSTEM_DELETE"))
            {
                Master.show_error("Access denied.");
                e.Canceled = true;
                return;
            }
        }


    }



    protected void RadcobSysSub_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (RadcobSysSub.SelectedValue.Length > 0)
        {
            string sys_area = WebTools.GetExpr("AREA", "FLANGE_SYS_DATA", " SEQ=" + RadcobSysSub.SelectedValue);
            string sys_descr = WebTools.GetExpr("SYSTEM_DESCR", "FLANGE_SYS_DATA", " SEQ=" + RadcobSysSub.SelectedValue);
            txtArea.Text = sys_area;
            txtSYSTEM_DESCR.Text = sys_descr;
        }

    }
}