using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using BuildClass;

public partial class FlangeDashboard_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            string narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='FLANGE_NARRATIVE'");
            if (narrativetxt != string.Empty)
            {
                txtNarrative.Text = narrativetxt;
            }
            narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='FLANGE_NARRATIVE2'");
            if (narrativetxt != string.Empty)
            {
                txtNarrative2.Text = narrativetxt;
            }
            narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='FLANGE_NARRATIVE3'");
            if (narrativetxt != string.Empty)
            {
                txtNarrative3.Text = narrativetxt;
            }

        }
        if (!WebTools.UserInRole("DASHBOARD_NARRATIVE"))
        {
            btnShow.Visible = false;
            btnHide.Visible = false;
        }
        
    }

    

    protected void btnNarrative_Click(object sender, EventArgs e)
    {
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtNarrative.Text + "' WHERE LABEL='FLANGE_NARRATIVE'";
        WebTools.ExeSql(query);
        //Master.ShowError(query+" "+txt);
    }

   

    protected void btnShow_Click(object sender, EventArgs e)
    {
        btnNarrative.Visible = true;
        btnNarrative2.Visible = true;
        btnNarrative3.Visible = true;

    }

    protected void btnHide_Click(object sender, EventArgs e)
    {
        btnNarrative.Visible = false;
        btnNarrative2.Visible = false;
        btnNarrative3.Visible = false;



    }

    protected void btnNarrative2_Click(object sender, EventArgs e)
    {
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtNarrative2.Text + "' WHERE LABEL='FLANGE_NARRATIVE2'";
        WebTools.ExeSql(query);
    }

    protected void btnNarrative3_Click(object sender, EventArgs e)
    {
        
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtNarrative3.Text + "' WHERE LABEL='FLANGE_NARRATIVE3'";
        WebTools.ExeSql(query);
    }
}