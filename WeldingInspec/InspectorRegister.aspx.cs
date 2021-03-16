using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsWeldersTableAdapters;
public partial class WeldingInspec_InspectorRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            VIEW_INSPECTORTableAdapter inspector = new VIEW_INSPECTORTableAdapter();
            inspector.InsertQuery(int.Parse(Session["PROJECT_ID"].ToString()), txtInspCode.Text, txtInspName.Text, int.Parse(ddlSubCon.SelectedValue.ToString()), int.Parse(ddlType.SelectedValue.ToString()), txtRemarks.Text);
            Master.show_success("Inspector Register Successfully");
        }
        catch(Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}