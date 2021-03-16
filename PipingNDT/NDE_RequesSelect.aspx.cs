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

public partial class Isome_IsomeTransSelect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "NDT";
            txtDate.Text = Session["NDE_AUTO_DATE"].ToString();
            txtRepNo.Text = Session["NDE_AUTO_REP"].ToString();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/SpoolMoveHome.aspx");
    }
    protected void btnContinue_Click(object sender, EventArgs e)
    {
        if (NdeList.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the NDE type!");
            return;
        }
        Session["NDE_AUTO_DATE"] = txtDate.Text;
        Session["NDE_AUTO_REP"] = txtRepNo.Text;
        Response.Redirect("~/WeldingInspec/NDE_Request.aspx?NDE_TYPE_ID=" + NdeList.SelectedValue.ToString());
    }
    protected void btnStatus_Click(object sender, EventArgs e)
    {
        Session["NDE_AUTO_DATE"] = txtDate.Text;
        Session["NDE_AUTO_REP"] = txtRepNo.Text;

        Session["NDE_STATUS_TYPE"] = NdeList.SelectedValue.ToString();
        Response.Redirect("NDE_StatusFilter.aspx");
    }
    protected void btnBack_Click1(object sender, EventArgs e)
    {
        Response.Redirect("~/Home/WeldingInspHome.aspx");
    }
    protected void NdeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            if (NdeList.SelectedValue.ToString() == "1")
            {
                btnPenalty.Enabled = true;
            }
            else
            {
                btnPenalty.Enabled = false;
            }
        }
    }
    protected void btnPenalty_Click(object sender, EventArgs e)
    {
        Response.Redirect("PenaltyJoints_Selection.aspx");
    }
}