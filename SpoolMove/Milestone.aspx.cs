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

public partial class SpoolMove_Milestone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Spool milestones";
    }
    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (statusGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire status code!");
            return;
        }
        Response.Redirect("MilestoneSpools.aspx?STATUS_ID=" + statusGridView.SelectedValue.ToString());
    }
}
