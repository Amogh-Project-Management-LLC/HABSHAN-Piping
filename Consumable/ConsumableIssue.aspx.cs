using System;
using Telerik.Web.UI;

public partial class Consumable_ConsumableIssue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Cosumable Issue";

            Master.RadGridList = RadGrid1.ClientID;

            Master.AddModalPopup("~/Consumable/ConsumableIssueNew.aspx", ImageButtonAdd.ClientID, 450, 600);
        }
    }

    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        txtFilter.Text = txtFilter.Text.Trim().ToUpper();
    }

    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //HyperLinkPreview.NavigateUrl = "ReportViewer.aspx?ReportID=1&Arg1=" + RadGrid_NDE_REQ_ID();
    }

    private string RadGrid_MP_ID()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("MP_ID").ToString();
            }
        }
        return string.Empty;
    }

    protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("MANPOWER_UPDATE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
        }
    }
}