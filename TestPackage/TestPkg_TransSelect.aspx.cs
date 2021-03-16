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

public partial class TestPkg_TransSelect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Test Package Transmittals";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Home.aspx");
    }
    protected void btnContinue_Click(object sender, EventArgs e)
    {
        if (transCatList.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the transmittal.");
            return;
        }
        Response.Redirect("TestPkg_Trans.aspx?TYPE_ID=" + transCatList.SelectedValue.ToString());
    }
    protected void transCatList_DataBound(object sender, EventArgs e)
    {
        if (transCatList.Items.Count > 0)
        {
            transCatList.Items[0].Selected = true;
        }
    }
}