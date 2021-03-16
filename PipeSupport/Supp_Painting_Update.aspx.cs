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

public partial class SpoolMove_SpoolStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Support Painting Update";
            string filter = Request.QueryString["Filter"];
            if (filter != null) txtIsomeNo.Text = filter;
        }
    }
    protected void txtIsomeNo_TextChanged(object sender, EventArgs e)
    {
        txtIsomeNo.Text = txtIsomeNo.Text.ToUpper().Trim();
    }
    protected void btnSavePaint_Click(object sender, EventArgs e)
    {
        if (spoolGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the support!");
            return;
        }
        if (txtPaintDate.Text == string.Empty || txtPaintReportNo.Text == string.Empty)
        {
            Master.ShowWarn("Enter Paint report no and date!");
            return;
        }
        try
        {
            WebTools.ExeSql("UPDATE PIP_SUPP_JC_DETAIL SET PAINT_REP_NO='" +
                txtPaintReportNo.Text +
                "', PAINT_DATE='" + txtPaintDate.Text +
                "' WHERE BOM_ID=" + spoolGridView.SelectedValue.ToString());

            spoolGridView.DataBind();

            Master.ShowMessage("Paint Report No Updated!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/Supp_Home.aspx");
    }
}