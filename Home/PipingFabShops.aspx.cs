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
using dsGeneralBTableAdapters;

public partial class Home_PipingFabShops : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Fabrication Shops";
        }
    }
 
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjectBasicData.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
     
        Master.ShowWarn("Proceed delete selected row?");
    }
  
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("ADMIN"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!EntryTable.Visible)
        {
            btnSave.Visible = true;
            EntryTable.Visible = true;
        }
        else
        {
            btnSave.Visible = false;
            EntryTable.Visible = false;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_PIP_FAB_SHOPTableAdapter items = new VIEW_PIP_FAB_SHOPTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(txtSubconID.Text),
                txtShopNo.Text, txtSubconName.Text, decimal.Parse(ddSubcon.SelectedValue.ToString()));
            PipingSpecGridView.DataBind();
            Master.ShowMessage("Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
    }
}