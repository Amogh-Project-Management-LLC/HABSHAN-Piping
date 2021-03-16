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
using dsConsumableTableAdapters;

public partial class Manpower_ManpowerNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Consumable * New");

            if (!WebTools.UserInRole("MANPOWER_UPDATE"))
            {
                btnSubmit.Enabled = false;
                txtSymbol.Enabled = false;
                return;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_CONSUMABLE_MASTERTableAdapter manpower = new VIEW_CONSUMABLE_MASTERTableAdapter();
        try
        {
            manpower.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtSymbol.Text,
                Decimal.Parse(ddCategory.SelectedValue.ToString()),
                txtDescription.Text,
                decimal.Parse(ddUOM.SelectedValue.ToString())
                );

            Master.show_success(txtSymbol.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            manpower.Dispose();
        }
    }
}