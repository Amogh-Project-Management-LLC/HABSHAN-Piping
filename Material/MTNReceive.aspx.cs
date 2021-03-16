using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MTNReceive : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["MTN_RCV_FILTER"] != null) txtSearch.Text = Session["MTN_RCV_FILTER"].ToString();
            Master.HeadingMessage = "Material Receive - MTN";
            Master.AddModalPopup("~/Material/MTNReceiveNew.aspx", btnRegister.ClientID, 500, 550);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        if(itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select a receive number to continue.");
            return;
        }

        Response.Redirect("MTNReceiveDetail.aspx?id=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select a receive number to continue.");
            return;
        }

        Response.Redirect("ReportViewer.aspx?ReportID=33&Arg1=" + itemsGrid.SelectedValue);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        Session["MTN_RCV_FILTER"] = txtSearch.Text.Trim().ToUpper();
    }
}