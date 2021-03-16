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
using Telerik.Web.UI.PersistenceFramework;
using Telerik.Web.UI;

public partial class SubcontractorSelect : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
       
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Subcon Selection";

        }

    }


    protected void itemsGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {

        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("SUBCONTRACTOR_SELECT_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("SUBCONTRACTOR_SELECT_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SubContractors.aspx");
    }
}