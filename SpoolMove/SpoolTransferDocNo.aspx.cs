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
using Telerik.Web.UI;
using System.Data.SqlClient;

public partial class transfdoc_items : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string transfer_no = WebTools.GetExpr("TRANS_NO", "PIP_SPL_TRANSFER", "TRANS_ID=" + Request.QueryString["TRANS_ID"]);
            Master.HeadingMessage ("Spool Transfer Document No( "+ transfer_no+" )" );
          
        }
    }
    

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolTransfer.aspx");
    }



    protected void DOCGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit") 
        {
            if (!WebTools.UserInRole("SPL_TRANSFER_DOC_UPDATE"))
            {
                Master.show_error("Access denied!");
                e.Canceled = true;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("SPL_TRANSFER_DOC_DELETE"))
            {
                Master.show_error("Access denied!");
            }
        }


    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        
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

            DocViewDataSource.Insert();
            Master.show_success("Saved succesfully!");

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

   
}

