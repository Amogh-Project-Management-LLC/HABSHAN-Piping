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
using dsTestPkg_BTableAdapters;

public partial class TestPkg_TransRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string type_id = Request.QueryString["TYPE_ID"];
            string trans = WebTools.GetExpr("TRANS_TYPE", "TPK_TRANS_TYPE", " WHERE TYPE_ID=" + type_id);
            Master.HeadingMessage(trans);
            set_trans_no();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        TPK_TRANSTableAdapter trans = new TPK_TRANSTableAdapter();
        try
        {
            trans.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(Request.QueryString["TYPE_ID"]),
                txtTransNo.Text, DateTime.Parse(txtTransDate.Text), txtRemarks.Text);
            Master.show_success("Transmittal created successfully!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            trans.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("TestPkg_Trans.aspx?TYPE_ID=" + Request.QueryString["TYPE_ID"]);
    }
    private void set_trans_no()
    {
        if (Request.QueryString["CAT_ID"] == "3") return;
        string type_id = Request.QueryString["TYPE_ID"];
        string prefix = WebTools.GetExpr("PREFIX", "TPK_TRANS_TYPE", " WHERE TYPE_ID=" + type_id);
        string trans = WebTools.GetExpr("TRANS_TYPE", "TPK_TRANS_TYPE", " WHERE TYPE_ID=" + type_id);
        string new_trans = General_Functions.NextSerialNo("TPK_TRANS", "TRANS_NO", prefix
            , 4, " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND TYPE_ID=" + type_id);
        txtTransNo.Text = new_trans;
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_trans_no();
    }
}