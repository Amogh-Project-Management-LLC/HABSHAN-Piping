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

public partial class TestPkg_Systems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "System Definition";
            Master.AddModalPopup("~/TestPackage/SystemDef_Register.aspx", btnRegister.ClientID, 550, 650);
            Master.RadGridList = sysGridView.ClientID;
        }
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Response.Redirect("SystemDef_Register.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (sysGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //sysGridView.DeleteRow(sysGridView.SelectedIndex);
            //Master.ShowMessage("Row deleted successfully!");
            //sysGridView.SelectedIndex = -1;
            string sys_id = WebTools.GetExpr("SYS_ID", "TPK_SYSTEM_DEFINITION", "  WHERE  SYS_ID=" + sysGridView.SelectedValues["SYS_ID"].ToString());
            string query = "DELETE FROM TPK_SYSTEM_DEFINITION WHERE SYS_ID=" + sys_id;
            WebTools.exec_non_qry(query);
            sysGridView.DataBind();
            Master.ShowMessage("System Definiton Deleted!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
}