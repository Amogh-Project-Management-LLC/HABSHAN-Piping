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

public partial class SpoolStatusPaint : System.Web.UI.Page
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

    }
}