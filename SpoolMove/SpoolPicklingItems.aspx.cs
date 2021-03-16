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
using dsSpoolMoveTableAdapters;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolPaintItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string req_no = WebTools.GetExpr("PICKLING_REQ_NO", "PIP_PICKLING_SPL", " WHERE SPL_PICKLING_ID=" + Request.QueryString["SPL_PICKLING_ID"]);
            Master.HeadingMessage = "Spool Pickling (" + req_no + ")";
            HiddenSC.Value = WebTools.GetExpr("SC_ID", "PIP_PICKLING_SPL", " WHERE SPL_PICKLING_ID = '" + Request.QueryString["SPL_PICKLING_ID"] + "'");
        }
    }

    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        Decimal spl_pkl_id = decimal.Parse(Request.QueryString["SPL_PICKLING_ID"]);
        VIEW_ADAPTER_PKLNG_SPL_DETAILTableAdapter pnt_items = new VIEW_ADAPTER_PKLNG_SPL_DETAILTableAdapter();
        try
        {
            foreach (RadComboBoxItem item in cboNewSpool.CheckedItems)
            {
                pnt_items.InsertQuery(spl_pkl_id, Decimal.Parse(item.Value), null);

            }
            ItemsGridView.DataBind();
            Master.ShowMessage("Spool added.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            pnt_items.Dispose();
        }
    }
  
   
    protected void ItemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < ItemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", ItemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == ItemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        ItemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void ItemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("SPL_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnEntryMode_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("SPL_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        txtIsome.Visible = true;
        cboNewSpool.Visible = true;
        btnAddSpool.Visible = true;
    }
    protected void btnJCList_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolPickling.aspx");
    }

    protected void txtIsome_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        HiddenIsoID.Value = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", " WHERE ISO_TITLE1 = '" + txtIsome.Text + "'");
    }
}