using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsMaterialATableAdapters;

public partial class Material_MaterialRequestNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Register Material Request");
            txtReqDate.SelectedDate = System.DateTime.Now;
            txtReqBy.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //string mat_req_id;
        
        VIEW_MATERIAL_REQUESTTableAdapter mrir = new VIEW_MATERIAL_REQUESTTableAdapter();
        try
        {
            mrir.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtRequestNo.Text, txtReqDate.SelectedDate,
                decimal.Parse(ddFrom.SelectedValue), decimal.Parse(ddTo.SelectedValue), txtRemarks.Text, txtReqBy.Text);
            Master.show_success(txtRequestNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            mrir.Dispose();
        }

    }

    private void set_req_no()
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        string sc_id = ddFrom.SelectedValue;
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + sc_id + "'");
        prefix += "-MAT-REQ-";
        txtRequestNo.Text = WebTools.NextSerialNo("MATERIAL_REQUEST", "MAT_REQ_NO", prefix, 4, " PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND REQ_FROM='" + ddFrom.SelectedValue + "'");
    }

    protected void ddFrom_DataBinding(object sender, EventArgs e)
    {
        ddFrom.Items.Clear();
        ddFrom.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

 
    protected void ddTo_DataBinding(object sender, EventArgs e)
    {
        ddTo.Items.Clear();
        ddTo.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddFrom_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        set_req_no();
    }
}