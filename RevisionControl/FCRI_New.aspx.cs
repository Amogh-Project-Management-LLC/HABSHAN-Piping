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
using dsIsomeControlBTableAdapters;

public partial class RevisionControl_FCRI_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "New FCRI";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("FCRI.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_FCRITableAdapter trans = new VIEW_FCRITableAdapter();
        try
        {
            trans.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtSerialNo.Text,
                txtCreateDate.SelectedDate,
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtRemarks.Text);
            Master.ShowMessage(txtSerialNo.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            trans.Dispose();
        }
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }
    private void set_req_no()
    {
        string sc_name = cboSubcon.SelectedItem.Text;
        txtSerialNo.Text =
            General_Functions.NextSerialNo(
            "PIP_FCRI",
            "FCRI_NO",
            "FCRI-" + sc_name + "-", 4,
            " WHERE PROJECT_ID=" + Session["PROJECT_ID"] + " AND SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());
    }
}