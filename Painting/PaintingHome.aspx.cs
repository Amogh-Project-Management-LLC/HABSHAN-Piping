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

public partial class Painting_PaintingHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Painting";
    }
    protected void btnPaintingRepA_Click(object sender, EventArgs e)
    {
        Response.Redirect("SelectDateFromTo.aspx");
    }
}