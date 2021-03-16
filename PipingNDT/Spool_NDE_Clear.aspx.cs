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

public partial class Spool_NDE_Clear : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool NDE Clearance";
        }
    }
    protected void btnAutoNDE_Click(object sender, EventArgs e)
    {
        string nde_sql = "DECLARE outMSG VARCHAR2(100); BEGIN outMSG := FNC_SET_NDE_CMPLT_SPL(" +
            Session["PROJECT_ID"].ToString() + "); END;";
        try
        {
            WebTools.ExecNonQuery(nde_sql);
            Master.ShowMessage("NDE Update Done Successfully!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void ddSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (SPL_ListBoxDestination.Items.Count == 0)
        {
            Master.ShowMessage("No Spools selected!");
            return;
        }
        try
        {
            for (int i = 0; i < SPL_ListBoxDestination.Items.Count; i++)
            {
                WebTools.ExeSql("UPDATE PIP_SPOOL SET NDE_CMPLT='" + txtClearDate.SelectedDate.Value.ToString("dd-MMM-yyyy") +
                    "', NDE_CMPLT_BY='" + Session["USER_NAME"].ToString() +
                    "' WHERE SPL_ID=" + SPL_ListBoxDestination.Items[i].Value.ToString());
            }

            Master.ShowMessage("NDE Date updated for selected spools!");
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
        }
        finally
        {

        }
    }

    protected void btnBulk_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=19&RetUrl=~/PipingNDT/Spool_NDE_Clear.aspx");
    }
}