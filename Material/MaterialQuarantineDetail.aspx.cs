using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialQuarantineDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Quarantine Details";
            Master.HeadingMessage += "<br/>";
            Master.HeadingMessage += WebTools.GetExpr("QRNTINE_NO", "PIP_QUARANTINE", " WHERE QRNTINE_ID='" + Request.QueryString["id"].ToString() + "'");
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void ddlMatItem_OnDataBinding(object sender, EventArgs e)
    {
        ddlMatItem.Items.Clear();
        ddlMatItem.Items.Add(new ListItem("(Select Material)", ""));        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsMaterialDTableAdapters.VIEW_QUARANTINE_DETAILTableAdapter q = new dsMaterialDTableAdapters.VIEW_QUARANTINE_DETAILTableAdapter();
        try
        {
            q.InsertQuery(Decimal.Parse(ddlMatItem.SelectedValue), decimal.Parse(txtQty.Text), decimal.Parse(ddlQuaranCat.SelectedValue),
                txtRemarks.Text, decimal.Parse(Request.QueryString["id"].ToString()));
            RadGrid1.Rebind();
            Master.ShowMessage(ddlMatItem.SelectedItem.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally {
            q.Dispose();
        }
    }

    protected void btnHide_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = false;
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialQuarantine.aspx");
    }
}