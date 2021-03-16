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
using dsPO_ShipmentATableAdapters;

public partial class Material_MatExceptionRepItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_SELECT"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }

        if (!IsPostBack)
        {
            Master.HeadingMessage = "ESD Report";
            Master.AddModalPopup("~/Material/MatExceptionImportMIR.aspx?EXCP_ID=" + Request.QueryString["EXCP_ID"], btnImportMRIR.ClientID, 500, 750);
        }
    }
    protected void itemsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void itemsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatExceptionRep.aspx");
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        {
            PageList.Items.Clear();
            for (int i = 0; i < itemsGridView.PageCount; i++)
            {
                ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
                PageList.Items.Add(pageListItem);
                if (i == itemsGridView.CurrentPageIndex)
                    pageListItem.Selected = true;
            }
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access denied!");
            return;
        }

        if (!EntryTable.Visible)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
        if (WebTools.GetExpr("HEAT_NO", "PRC_MAT_INSP_DETAIL", " WHERE HEAT_NO='" + txtHeatNo.Text +
            "'") == "")
        {
            Master.ShowWarn("Heat number not found!");
            return;
        }
        PIP_MAT_EXCEPTION_REP_DETAILTableAdapter excp_items = new PIP_MAT_EXCEPTION_REP_DETAILTableAdapter();
        try
        {
            excp_items.InsertQuery(decimal.Parse(Request.QueryString["EXCP_ID"]),
                mat_id, cboFalg.SelectedValue.ToString(),
                decimal.Parse(txtQty.Text), txtRemarks.Text, txtHeatNo.Text, txtPOitem.Text);
            Master.ShowMessage("new exception item added.");
            itemsGridView.DataBind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            excp_items.Dispose();
        }
    }
}