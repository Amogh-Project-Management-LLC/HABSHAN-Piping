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

public partial class WeldingInspec_WelderLotJoints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Welder Lots";
        }
    }
    protected void welderGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            e.Cancel = true;
        }
    }
    protected void welderGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < welderGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", welderGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == welderGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        welderGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //welderGridView.DeleteRow(welderGridView.SelectedIndex);
            //welderGridView.SelectedIndex = -1;
            //Master.ShowMessage("welder deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (welderGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire welder!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the welder?");
    }
    protected void btnAuto_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowError("Access Denied!");
            return;
        }
        string WELDER_NO = WebTools.GetExpr("WELDER_NO", "VIEW_WELDER_LOT", "LOT_ID=" + Request.QueryString["LOT_ID"]);
        try
        {
            string RET_VAL = WebTools.GetExpr("FNC_LOT_JOINTS(" + Session["PROJECT_ID"].ToString() + "," +
                Request.QueryString["LOT_ID"] + ",'" + WELDER_NO + "')", "DUAL", string.Empty);
            welderGridView.DataBind();
            Master.ShowMessage("Updated!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("WelderLot.aspx?Filter=" + Request.QueryString["Filter"]);
    }
}