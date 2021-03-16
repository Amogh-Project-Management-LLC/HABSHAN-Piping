using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MaterialRequestDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Request";
            Master.HeadingMessage += "<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + Request.QueryString["MAT_REQ_ID"] + "'");

            Master.AddModalPopup("~/Material/MaterialRequestDetailAdd.aspx?MAT_REQ_ID=" + Request.QueryString["MAT_REQ_ID"], btnAdd.ClientID, 550, 650);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialRequest.aspx");
    }

    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            Telerik.Web.UI.GridDataItem dataitem = (Telerik.Web.UI.GridDataItem)e.Item;
            //if (!WebTools.UserInRole("MM_UPDATE"))
            //{

            //    ((ImageButton)dataitem["EditCommandColumn"].Controls[0]).Visible = false;
            //}


            if (!WebTools.UserInRole("MM_DELETE"))
            {
                ((ImageButton)dataitem["DeleteColumn"].Controls[0]).Visible = false;
            }
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        RadGrid1.DataBind();
    }
}