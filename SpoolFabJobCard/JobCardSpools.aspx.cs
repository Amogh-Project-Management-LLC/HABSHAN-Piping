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
using Telerik.Web.UI;

public partial class Material_FabricationJobCardItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!WebTools.UserInRole("MM_SELECT"))
        //{
        //    Response.Redirect("~/ErrorPages/NoAccess.htm");
        //    return;
        //}
        if (!IsPostBack)
        {
            string pg_index = Request.QueryString["pg_index"];
            if (pg_index != null)
            {
                spoolsGridView.CurrentPageIndex = int.Parse(pg_index);
            }
            Master.HeadingMessage = "Job Card Spools (" +
                WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]) + ")";
        }
    }
    protected void btnJCList_Click(object sender, EventArgs e)
    {
        Response.Redirect("JobCard.aspx");
    }

    protected void spoolsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < spoolsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", spoolsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == spoolsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        spoolsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void spoolsGridView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            if (!WebTools.UserInRole("JOBCARD_DETAIL_EDIT"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("JOBCARD_DETAIL_DELETE"))
            {
                Master.ShowWarn("Access denied.");
                e.Canceled = true;
                return;
            }
        }
    }

    protected void spoolsGridView_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        string ID1 = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["WO_ID"].ToString();
        string ID2 = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["SPL_ID"].ToString();
        string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"] + "'");
        if (user_id.Length > 0)
        {

            string query = "UPDATE PIP_WORK_ORD_SPOOL SET USER_ID='" + user_id + "', USER_SOURCE='UI' WHERE WO_ID='" + ID1 + "'AND  SPL_ID='" + ID2 + "'";
            WebTools.ExeSql(query);
        }
        else
        {
            Response.Redirect("~/LoginPage.aspx");
        }
    }

    protected void spoolsGridView_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        string ID1 = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["WO_ID"].ToString();
        string ID2 = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["SPL_ID"].ToString();
        string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"] + "'");
        if (user_id.Length > 0)
        {

            string query = "UPDATE PIP_WORK_ORD_SPOOL SET USER_ID='" + user_id + "', USER_SOURCE='UI' WHERE WO_ID='" + ID1 + "' AND SPL_ID='" + ID2 + "'";
            WebTools.ExeSql(query);
        }
        else
        {
            Response.Redirect("~/LoginPage.aspx");
        }
    }

    protected void spoolsGridView_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        string ID1 = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["WO_ID"].ToString();
        string ID2 = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["SPL_ID"].ToString();
        string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME='" + Session["USER_NAME"] + "'");
        if (user_id.Length > 0)
        {

            string query = "UPDATE PIP_WORK_ORD_SPOOL SET USER_ID='"+ user_id+ "', USER_SOURCE='UI' WHERE WO_ID='"+ ID1 + "' AND SPL_ID='"+ ID2 + "'";
            WebTools.ExeSql(query);
        }
        else
        {
            Response.Redirect("~/LoginPage.aspx");
        }
    }
}