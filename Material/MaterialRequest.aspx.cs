using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Request";
            Master.AddModalPopup("~/Material/MaterialRequestNew.aspx", btnRegisrer.ClientID, 550, 650);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            Telerik.Web.UI.GridDataItem dataitem = (Telerik.Web.UI.GridDataItem)e.Item;

            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                ((ImageButton)dataitem["EditCommandColumn"].Controls[0]).Visible = false;
            }

            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                ((ImageButton)dataitem["DeleteColumn"].Controls[0]).Visible = false;
            }
        }
    }

    protected void RadGrid1_PreRender(object sender, EventArgs e)
    {
        FilterValue.Value = RadGrid1.MasterTableView.FilterExpression;
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select Request Number to continue.");
            return;
        }
        Response.Redirect("MaterialRequestDetail.aspx?MAT_REQ_ID=" + RadGrid1.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select Request Number to continue.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=31&Arg1=" + RadGrid1.SelectedValue);
    }
}