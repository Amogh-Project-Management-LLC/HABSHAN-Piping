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
using dsGeneralATableAdapters;

public partial class Home_SubContractors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Sub-Contractors";
        }
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }


    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
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
        VIEW_SUB_CONTRACTORTableAdapter items = new VIEW_SUB_CONTRACTORTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(txtSubconID.Text),
                txtSubconName.Text, txtShortCode.Text,
                ddFieldSC.SelectedValue.ToString(), ddShopSC.SelectedValue.ToString());
            subConGridView.DataBind();
            Master.ShowMessage("Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }

    protected void btnStores_Click(object sender, EventArgs e)
    {
        if (subConGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a subcon !");
            return;
        }
        Response.Redirect("~/Home/MaterialStores.aspx?RetUrl=~/Home/SubContractors.aspx&sc_id=" + subConGridView.SelectedValue);
    }
    protected void subConGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("ADMIN"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("ADMIN"))
            {
                RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
                e.Canceled = true;
            }
        }



    }



    protected void btnPriority_Click(object sender, EventArgs e)
    {
        if (subConGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a subcon !");
            return;
        }
        Response.Redirect("~/Home/SubcontractorSelect.aspx?&sc_id=" + subConGridView.SelectedValue);
    }
}