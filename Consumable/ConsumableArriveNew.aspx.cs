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

public partial class Consumable_ConsumableArriveNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Consumable * New");

            if (!WebTools.UserInRole("MANPOWER_UPDATE"))
            {
                btnSubmit.Enabled = false;
                return;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_CONSUMABLE_ARRIVETableAdapter consumable = new VIEW_CONSUMABLE_ARRIVETableAdapter();
        try
        {
            consumable.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtArrivedDate.SelectedDate.Value,
                decimal.Parse(ddItemCode.SelectedValue.ToString()),
                decimal.Parse(txtQty.Text)
                );

            Master.show_success(ddItemCode.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            consumable.Dispose();
        }
    }
    protected void ddItemCode_DataBinding(object sender, EventArgs e)
    {
        ddItemCode.Items.Clear();
        ddItemCode.Items.Add(new ListItem("", "-1"));
    }
}