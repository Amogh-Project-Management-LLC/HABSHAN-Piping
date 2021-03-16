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

public partial class Material_MatReceiveItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string mrir = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID=" +
                Request.QueryString["MAT_RCV_ID"]);
            Master.HeadingMessage = "MRV Materials (" + mrir + ")";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceive.aspx");
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
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
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void itemsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }

    protected void itemsGridView_PageIndexChanged(object sender, EventArgs e)
    {

    }
    protected void itemsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        string mat_descr = WebTools.GetExpr("MAT_DESCR", "VIEW_ADAPTER_MAT_RCV_DETAIL",
            " WHERE RCV_ITEM_ID=" + itemsGridView.SelectedValue.ToString());
        Master.ShowMessage(mat_descr);
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceiveNewImport.aspx?MAT_RCV_ID=" + Request.QueryString["MAT_RCV_ID"]);
    }

    protected void btnAddItems_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        //if (MatReceiveGridView.SelectedIndexes.Count == 0)
        //{
        //    Master.ShowMessage("Select the report number first.");
        //    return;
        //}
        Response.Redirect("MatReceiveNewItem.aspx?MAT_RCV_ID=" + Request.QueryString["MAT_RCV_ID"]);
    }
}