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

public partial class WeldingInspec_FieldJointsPaint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Joint Painting";
            Master.RadGridList = "";
            Master.AspGridList = TransGridView.ClientID;

            Master.AddModalPopup("~/WeldingInspec/JointsPaintNew.aspx", btnNew.ClientID, 400, 600);
        }
    }
    protected void btnViewJoints_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count== 0) return;
        Response.Redirect("JointsPaintItems.aspx?JNT_PNT_ID=" + TransGridView.SelectedValue.ToString());
    }
    protected void TransGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
        }
    }
    protected void TransGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < TransGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", TransGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == TransGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TransGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }



    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count > 0)
            Response.Redirect("ReportViewer.aspx?ReportID=1&Arg1=" + TransGridView.SelectedValue);
        else
            Master.ShowWarn("Select Paint Transmittal");
    }
}