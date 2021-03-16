using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialATableAdapters;

public partial class Material_MaterialRequestDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Material (";
            heading += WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID=" + Request.QueryString["MAT_REQ_ID"]);
            heading += ")";

            Master.HeadingMessage(heading);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        decimal mat_id = WebTools.GetMatId(txtAutoCompltMatList.Entries[0].Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.show_error("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.show_error("Material Code not found!");
            return;
        }

        VIEW_MATERIAL_REQUEST_DTTableAdapter items = new VIEW_MATERIAL_REQUEST_DTTableAdapter();

        try
        {
            items.InsertQuery(decimal.Parse(Request.QueryString["MAT_REQ_ID"]), mat_id, decimal.Parse(txtReqQty.Text), 
                DateTime.Parse(txtReqDate.SelectedDate.ToString()), txtRqrdAtLocation.Text, txtRemarks.Text);
            Master.show_success(txtAutoCompltMatList.Entries[0].Text + " Saved!");

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            items.Dispose();
        }

    }
}