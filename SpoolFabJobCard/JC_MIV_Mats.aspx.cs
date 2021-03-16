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

public partial class Material_FabricationJobCardMatList : System.Web.UI.Page
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
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
                    Request.QueryString["ISSUE_ID"]);
            string wo = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);
            Master.HeadingMessage = "MIV Materials (" + wo + "/ " + miv_no + ")";
            Master.AddModalPopup("~/SpoolFabJobCard/JC_MIV_MatsRegister.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"].ToString() +
            "&WO_ID=" + Request.QueryString["WO_ID"] +"&ISSUE_REV_ID=" + Request.QueryString["ISSUE_REV_ID"].ToString(), btnAddMat.ClientID, 600, 650);
            Master.RadGridList = itemsGridView.ClientID;
        }
    }
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel=true;
        }
    }
    protected void btnAddMat_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_MatsRegister.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"].ToString() + 
            "&WO_ID=" + Request.QueryString["WO_ID"] + "&ISSUE_REV_ID=" + Request.QueryString["ISSUE_REV_ID"].ToString());
    }
  
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_Rev.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]+"&WO_ID=" + Request.QueryString["WO_ID"]);
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
