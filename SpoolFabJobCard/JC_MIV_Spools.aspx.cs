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
using dsFabricationJCTableAdapters;

public partial class Material_Reports_JC_MIV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
                Request.QueryString["ISSUE_ID"]);
            string wo = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);
            Master.HeadingMessage = "MIV Spools (" + wo + "/ " + miv_no + ")";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }
  
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("JC_MIV_Spools_Select.aspx?ISSUE_ID="+Request.QueryString["ISSUE_ID"] + "&WO_ID=" + Request.QueryString["WO_ID"]);
        //txtIsome.Visible = true;
        //cboNewSpool.Visible = true;
        //btnAddSpool.Visible = true;
        //btnAddAll.Visible = true;
    }
    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        if (cboNewSpool.SelectedIndex < 0) return;
        PIP_MAT_ISSUE_WO_SPLTableAdapter miv_spl = new PIP_MAT_ISSUE_WO_SPLTableAdapter();
        try
        {
            miv_spl.InsertQuery(Decimal.Parse(Request.QueryString["ISSUE_ID"]), Decimal.Parse(cboNewSpool.SelectedValue));
            miv_spl.Dispose();
            rowsGridView.DataBind();
            Master.ShowMessage("Spool added to MIV.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
            miv_spl.Dispose();
        }
    }
    protected void btnAddAll_Click(object sender, EventArgs e)
    {
        string result = WebTools.GetExpr("FNC_JCMIV_ADD_ALL(" +
            Request.QueryString["ISSUE_ID"] + ", " + Request.QueryString["WO_ID"] + ")", "DUAL", "");
        if (result == "0")
        {
            Master.ShowWarn("Can't select all job card spools! Some spool[s] already added to miv.");
        }
        else if (result == "1")
        {
            rowsGridView.DataBind();
        }
    }

    protected void rowsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("JC_MIV_DETAILS_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("JC_MIV_DETAILS_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }
}