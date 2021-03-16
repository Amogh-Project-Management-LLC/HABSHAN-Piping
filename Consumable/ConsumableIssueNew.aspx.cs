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

public partial class Consumable_ConsumableIssueNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Consumable Issue * New");

            if (!WebTools.UserInRole("MANPOWER_UPDATE"))
            {
                btnSubmit.Enabled = false;
                return;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string EMP_CODE = string.Empty;

        if (ManpowerRadAutoCompleteBox.Entries.Count > 0)
        {
            EMP_CODE = ManpowerRadAutoCompleteBox.Entries[0].Text;
        }

        string MP_ID = WebTools.GetExpr("MP_ID", "MANPOWER_MASTER", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND EMPLOYEE_CODE='" + EMP_CODE + "'");

        VIEW_CONSUMABLE_ISSUETableAdapter consumable = new VIEW_CONSUMABLE_ISSUETableAdapter();
        try
        {
            consumable.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(MP_ID),
                decimal.Parse(ddItemCode.SelectedValue.ToString()),
                txtIssueDate.SelectedDate.Value,
                decimal.Parse(txtQty.Text)
                );

            Master.show_success(EMP_CODE + "/ " + ddItemCode.SelectedItem.Text + " Saved!");
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