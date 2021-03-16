using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialQuarantine : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Quarantine";
            Master.AddModalPopup("~/Material/MaterialQuarantineAdd.aspx", btnRegister.ClientID, 350, 550);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select a row to conitnue.");
            return;
        }
        Response.Redirect("MaterialQuarantineDetail.aspx?id=" + RadGrid1.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select a row to conitnue.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=32&Arg1=" + RadGrid1.SelectedValue);
    }
}