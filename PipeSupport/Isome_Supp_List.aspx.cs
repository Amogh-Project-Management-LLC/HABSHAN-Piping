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

public partial class Isome_Supp_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string filter_ = Request.QueryString["Filter"];
            if (filter_ != "") txtSearch.Text = filter_;

            WebTools.Check_Session_Variable("popup_SUPP_ISO_BOM_ID");
            Master.RadGridList = string.Empty;

            if (Session["Search"] != null)
            {
                txtSearch.Text = Session["Search"].ToString();
            }
        
            //Master.AddModalPopup("~/PipeSupport/Isome_SuppView.aspx", btnDetails.ClientID, 500, 650);

            if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
            {
                btnUpdateFab.Enabled = false;
            }
            else
            {
                //Master.AddModalPopup("~/PipeSupport/Isome_SuppFab.aspx", btnUpdateFab.ClientID, 500, 650);
            }
            
            Master.HeadingMessage = "Isometric Support List";
        }
    }
    private bool if_selected()
    {
        if (tpGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire row!");
            return false;
        }
        else
        {
            return true;
        }
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["Search"] = txtSearch.Text.Trim().ToUpper();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/Supp_Home.aspx");
    }
    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (tpGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a row!");
            return;
        }
        Response.Redirect("Isome_Supp_BOM.aspx?BOM_ID=" + tpGridView.SelectedValue.ToString() +
            "&Filter=" + txtSearch.Text);
    }
    protected void tpGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popup_SUPP_ISO_BOM_ID"] = tpGridView.SelectedValue.ToString();
    }

    protected void btnDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("Isome_SuppView.aspx?BOM_ID=" + tpGridView.SelectedValue);
    }

    protected void btnUpdateFab_Click(object sender, EventArgs e)
    {
        Response.Redirect("Isome_SuppFab.aspx?BOM_ID=" + tpGridView.SelectedValue);
    }
}