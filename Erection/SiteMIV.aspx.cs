using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Erection_SiteMIV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Site Job Card MIV";
            Master.AddModalPopup("~/Erection/SiteMIVCreate.aspx", btnCreateMIV.ClientID, 500, 700);
            Master.RadGridList = itemsGridView.ClientID;
            if(Session["SITE_MIV_FILTER"]!=null)
                txtSearch.Text = Session["SITE_MIV_FILTER"].ToString();
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["SITE_MIV_FILTER"] = txtSearch.Text;
    }
    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        Response.Redirect("SiteMIVR.aspx?id=" + itemsGridView.SelectedValue.ToString());
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (is_selected() == true)
        {
            Response.Redirect("ReportViewer.aspx?ReportID=18&SITE_MIV_ID=" + itemsGridView.SelectedValue.ToString());
        }
    }
    private bool is_selected()
    {
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the Site MIV number!");
            return false;
        }
        else
        {
            return true;
        }
    }
}