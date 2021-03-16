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

public partial class WeldingInspec_WelderRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Welder Registration";
            //WebTools.Check_Session_Variable("isometric_index_filter");
            Master.RadGridList = "";
            if (Session["WELDER_GRID_SEARCH"] != null)
                txtSearch.Text = Session["WELDER_GRID_SEARCH"].ToString();
            Master.AddModalPopup("~/WeldingInspec/NewWelder.aspx", btnNewWelder.ClientID, 400, 600);
        }
    }

    protected void welderGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            e.Cancel = true;
        }
    }

    protected void btnWelderQualify_Click(object sender, EventArgs e)
    {
        if (welderGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a welder!");
            return;
        }
        Response.Redirect("WelderQualify.aspx?WELDER_ID=" + welderGridView.SelectedValue.ToString());
    }
    protected void btnProducJoints_Click(object sender, EventArgs e)
    {
        if (welderGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a welder!");
            return;
        }

        Response.Redirect("WelderProducJoints.aspx?WELDER_ID=" + welderGridView.SelectedValue.ToString());
    }

    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (welderGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a welder!");
            return;
        }

        Response.Redirect("JointsWeldedByWelder.aspx?WELDER_ID=" + welderGridView.SelectedValue.ToString());
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.ToString().Trim().ToUpper();
        Session["WELDER_GRID_SEARCH"] = txtSearch.Text;
    }
}