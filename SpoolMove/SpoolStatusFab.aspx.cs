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
using System.Drawing;

public partial class SpoolControl_SpoolStatusFab : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Status * " + WebTools.GetExpr("SPL_TITLE", "VIEW_SPOOL_TITLE", "SPL_ID=" + Request.QueryString["SPL_ID"].ToString()));
        }
    }
    protected void SpoolDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.NewMode == DetailsViewMode.Edit)
        {
            if (!WebTools.UserInRole("SPL_UPDATE"))
            {
                Master.show_error("Access denied!");
                e.Cancel = true;
            }
        }
    }
    protected void SpoolDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        string weld_date = ((DataControlFieldCell)SpoolDetailsView.Rows[4].Cells[1]).Text;
        TextBox text1 = (TextBox)SpoolDetailsView.Rows[5].Cells[1].Controls[0];
        string dim_check = text1.Text;
        string shop_id = WebTools.GetExpr("SHOP_ID", "PIP_SPOOL", "SPL_ID=" + Request.QueryString["SPL_ID"].ToString());
        if(string.IsNullOrEmpty(shop_id)) shop_id="0";

        if (string.IsNullOrEmpty(weld_date) && shop_id != "0" && !string.IsNullOrEmpty(dim_check))
        {
            text1.BackColor = Color.Yellow;
            Master.show_error("Not Welded!");
            e.Cancel = true;
            return;
        }

        if (!string.IsNullOrEmpty(weld_date) && !string.IsNullOrEmpty(dim_check))
        {
            if (DateTime.Parse(weld_date) > DateTime.Parse(dim_check))
            {
                text1.BackColor = Color.Yellow;
                Master.show_error("Weld Date is greater than dim chk date!");
                e.Cancel = true;
                return;
            }
        }
    }
}