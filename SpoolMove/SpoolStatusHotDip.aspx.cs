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

public partial class SpoolMove_SpoolStatusHotDip : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Status";
            string pg_index = Request.QueryString["PageIndex"];
            string filter = Request.QueryString["Filter"];
            if (filter != null) txtIsomeNo.Text = filter;
            if (pg_index != "" && pg_index != null) spoolGridView.PageIndex = int.Parse(pg_index);
        }
    }
    protected void txtIsomeNo_TextChanged(object sender, EventArgs e)
    {
        txtIsomeNo.Text = txtIsomeNo.Text.ToUpper().Trim();
    }

    protected void btnSavePaint_Click(object sender, EventArgs e)
    {
        if (spoolGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the spool!");
            return;
        }
        if (txtPaintDate.IsEmpty)
        {
            Master.ShowWarn("Select Hot Dip Date!");
            txtPaintDate.Focus();
            return;
        }
        try
        {
            WebTools.ExeSql("UPDATE PIP_SPOOL SET HOT_DIP_DATE='" + txtPaintDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "' WHERE SPL_ID=" + spoolGridView.SelectedValue.ToString());

            spoolGridView.DataBind();

            Master.ShowMessage("Hot Dip Updated!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void SpoolDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        spoolGridView.DataBind();
    }
}