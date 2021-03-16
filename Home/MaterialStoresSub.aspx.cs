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

public partial class Material_StoresSub : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string store = WebTools.GetExpr("STORE_NAME", "STORES_DEF", " WHERE STORE_ID=" +
                Request.QueryString["STORE_ID"]);
            Master.HeadingMessage = "Stores for " + Session["JOB_CODE"].ToString() + "/ " + store;
        }
    }
    protected void storeGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["RetUrl"] != null)
        {
            string url = Request.QueryString["RetUrl"].ToString();
            Response.Redirect("MaterialStores.aspx?RetUrl=" + url + "&sc_id=" + Request.QueryString["SC_ID"].ToString());
        }
        else
            Response.Redirect("MaterialStores.aspx");
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtStore.Text == "")
        {
            Master.ShowMessage("Enter some thing in textbox!!");
            return;
        }
        try
        {
            General_Functions.ExeSql("INSERT INTO STORES_SUB(STORE_ID,STORE_L1)VALUES(" +
                Request.QueryString["STORE_ID"] + ",'" + txtStore.Text + "')");
            storeGridView.Rebind();
            txtStore.Text = "";
            Master.ShowMessage("Substore created successfully. Use refresh button to see the new substore.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}