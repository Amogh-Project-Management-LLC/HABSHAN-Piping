using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolReceiveImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage ( "Spool Receive Detail" + "<br/>"+ WebTools.GetExpr("RCV_NO", "PIP_SPL_RECEIVE", " WHERE RCV_ID=" + Request.QueryString["id"]));
            
            HiddenStoreID.Value = WebTools.GetExpr("STORE_ID", "PIP_SPL_RECEIVE", " WHERE RCV_ID=" + Request.QueryString["id"]);
        }
    }

    protected void chkHeader_CheckedChanged(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlSubStore.SelectedValue.Equals("-1"))
        {
            lblMessage.Text = "Please select a sub-store !";
            return;
        }
        try
        {
            dsSpoolReportsDTableAdapters.VIEW_SPL_RECEIVE_DETAILTableAdapter spl = new dsSpoolReportsDTableAdapters.VIEW_SPL_RECEIVE_DETAILTableAdapter();
            foreach (GridItem item in itemsGrid.MasterTableView.Items)
            {
                GridDataItem dataitem = (GridDataItem)item;
                if (dataitem.Selected)
                {
                    spl.InsertQuery(decimal.Parse(Request.QueryString["id"]), decimal.Parse(dataitem.GetDataKeyValue("SPL_ID").ToString()), decimal.Parse(ddlSubStore.SelectedValue));
                }
            }
            itemsGrid.Rebind();
            Master.show_success("Selected Spools Added");
        }
        catch (Exception ex)
        {
            Master.show_error("Error:" + ex.Message);
        }

    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolReceiveDetail.aspx?id=" + Request.QueryString["id"]);
    }
}