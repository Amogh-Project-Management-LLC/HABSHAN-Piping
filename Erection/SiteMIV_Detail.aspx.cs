using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Erection_SiteMIV_Detail : System.Web.UI.Page
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
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_SITE_MIV", " WHERE ISSUE_ID=" +
                    Request.QueryString["ID"]);
            //string wo = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);
            Master.HeadingMessage = "MIV Materials (" + miv_no + ")";
            Master.AddModalPopup("~/Erection/SiteMIV_DetailAdd.aspx?id=" + Request.QueryString["id"].ToString() + "&rev_id=" + Request.QueryString["rev_id"], btnAddMat.ClientID, 600, 650);
            //"&WO_ID=" + Request.QueryString["WO_ID"] + "&ISSUE_REV_ID=" + Request.QueryString["ISSUE_REV_ID"].ToString(), btnAddMat.ClientID, 600, 650);
            Master.RadGridList = itemsGridView.ClientID;
        }
    }

    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnAddMat_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_MatsRegister.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"].ToString() +
            "&WO_ID=" + Request.QueryString["WO_ID"] + "&ISSUE_REV_ID=" + Request.QueryString["ISSUE_REV_ID"].ToString());
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SiteMIVR.aspx?ID=" + Request.QueryString["ID"]);
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
}