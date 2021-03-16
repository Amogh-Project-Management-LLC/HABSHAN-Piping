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

public partial class Material_Stores : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["SC_ID"] != null)
            {
                hiddenSubConName.Value = WebTools.GetExpr("SUB_CON_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + Request.QueryString["SC_ID"].ToString());
            }
            Master.HeadingMessage = "Stores for " + Session["JOB_CODE"].ToString();
        }
    }
    protected void storeGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
    protected void storeGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnSubstore_Click(object sender, EventArgs e)
    {
        if (storeGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire store!");
            return;
        }
        if (Request.QueryString["RetUrl"] != null)
        {
            string url = Request.QueryString["RetUrl"].ToString();
            Response.Redirect("MaterialStoresSub.aspx?STORE_ID=" + storeGridView.SelectedValue.ToString() + "&RetUrl=" + url + "&sc_id=" + Request.QueryString["SC_ID"].ToString());
        }
        else
            Response.Redirect("MaterialStoresSub.aspx?STORE_ID=" + storeGridView.SelectedValue.ToString());
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStoresRegister.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (storeGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the entire row!");
            return;
        }

    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["RetUrl"] != null)
        {
            string url = Request.QueryString["RetUrl"].ToString();
            Response.Redirect(url);
        }
        else
            Response.Redirect("ProjectBasicData.aspx");
    }
}