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

public partial class Erection_Erected : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string title = WebTools.GetExpr("ISO_TITLE1 || ' - ' || SHEET || ' - ' || SPOOL || ' - ' || 'P#' || PT_NO || ' - ' || MAT_CODE1",
                "VIEW_BOM_TOTAL", "BOM_ID=" + Request.QueryString["BOM_ID"]);
            Master.HeadingMessage = title + " Status";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("LooseMatStatus.aspx?Isome=" + Request.QueryString["Isome"] +
            "&Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            rowsGridView.DeleteRow(rowsGridView.SelectedIndex);
            Master.ShowMessage("Row deleted successfully!");
            rowsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Proceed delete the selected row?");
    }
}