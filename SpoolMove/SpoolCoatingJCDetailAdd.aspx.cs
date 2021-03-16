using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolCoatingJCDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Spools (";
            heading += WebTools.GetExpr("COAT_JC_NO", "PIP_COATING_JC", " WHERE JC_ID = '" + Request.QueryString["JC_ID"].ToString() + "'");
            heading += ")";
            Master.HeadingMessage(heading);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            dsGalvJobcardTableAdapters.VIEW_COATING_JC_SPLTableAdapter spl = new dsGalvJobcardTableAdapters.VIEW_COATING_JC_SPLTableAdapter();
            spl.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"].ToString()), decimal.Parse(ddlSpoolList.SelectedValue), txtRemarks.Text, txtCoatRepNo.Text
                , txtCoatingDate.SelectedDate , txtIntBlastRepNo.Text, txtIntBlastDate.SelectedDate.Value);
            Master.show_success("Spool Added Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}