using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MaterialReserveBOMAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string heading = "Add Reserve Items (";
        heading += WebTools.GetExpr("MAT_RES_NO", "MAT_RESERVE", " MAT_RES_ID = '" + Request.QueryString["REQ_ID"] + "'");
        heading += ")";
        Master.HeadingMessage(heading);
    }

    protected void txtAutoIsome_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        HiddenIsoID.Value = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", " WHERE ISO_TITLE1='" + txtAutoIsome.Text + "'");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string net_qty = string.Empty;
            dsMaterialDTableAdapters.VIEW_ADAPTER_RES_BOMTableAdapter bom = new dsMaterialDTableAdapters.VIEW_ADAPTER_RES_BOMTableAdapter();
            foreach (RadComboBoxItem item in cboBOMItems.CheckedItems)
            {
                net_qty = WebTools.GetExpr("NET_QTY", "PIP_BOM", " WHERE BOM_ID=" + item.Value);
                bom.InsertQuery(decimal.Parse(Request.QueryString["REQ_ID"].ToString()), decimal.Parse(item.Value), decimal.Parse(net_qty), "Y", txtRemarks.Text);
            }

            Master.show_success("BOM Items Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}