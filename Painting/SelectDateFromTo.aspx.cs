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

public partial class Painting_SelectDateFromTo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Painting Reports";
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        DateTime date_from, date_to;
        date_from = DateTime.Parse(txtDateFrom.Text);
        date_to = DateTime.Parse(txtDateTo.Text);
        Response.Redirect("PaintISO_ReportViewer.aspx?ReportID=6&DateFrom=" +
            date_from.ToString("dd-MMM-yyyy") +
            "&DateTo=" + date_to.ToString("dd-MMM-yyyy"));
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaintingHome.aspx");
    }
}