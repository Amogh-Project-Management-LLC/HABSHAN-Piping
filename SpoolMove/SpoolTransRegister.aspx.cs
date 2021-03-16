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
using dsSpoolMoveTableAdapters;

public partial class SpoolMove_SpoolTransRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string cat_id = Request.QueryString["CAT_ID"];
            string prefix = WebTools.GetExpr("SER_PREFIX", "PIP_SPOOL_TRANS_CAT", " WHERE CAT_ID=" + cat_id);
            string trans = WebTools.GetExpr("TRANS_CAT", "PIP_SPOOL_TRANS_CAT", " WHERE CAT_ID=" + cat_id);
            Master.HeadingMessage ( trans);
            txtTransNo.Text = "-Select the subcon-";
            string user_name = WebTools.GetExpr("USER_NAME", "USERS",
                                "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            txtUserName.Text = user_name;
            txtTransDate.SelectedDate = System.DateTime.Today;
            if (Request.QueryString["CAT_ID"].Equals("10"))//Before Painting
            {
                SubconDataSource.SelectCommand = "SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID AND FAB_SC='Y' ORDER BY SUB_CON_NAME";
                SubconDataSource.DataBind();
            }
            else
            if (Request.QueryString["CAT_ID"].Equals("16"))//After Painting
            {
                SubconDataSource.SelectCommand = "SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID AND (FAB_SC='Y' OR PAINT_SC='Y') ORDER BY SUB_CON_NAME";
                SubconDataSource.DataBind();
            }

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_SPL_TRANSTableAdapter spl_trans = new VIEW_ADAPTER_SPL_TRANSTableAdapter();
        try
        {
            spl_trans.InsertQuery(txtTransNo.Text,
                txtTransDate.SelectedDate,
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(Request.QueryString["CAT_ID"]),
                Decimal.Parse(cboSubcon.SelectedValue),
                txtShipNo.Text,
                txtRemarks.Text,
                txtArea.Text,
                "",
                txtUserName.Text);

            Master.show_success(txtTransNo.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            spl_trans.Dispose();
        }
    }

  
    private void set_req_no()

    {

        try

        {

            string new_trans;

            string cat_id = Request.QueryString["CAT_ID"];

            string prefix = WebTools.GetExpr("SER_PREFIX", "PIP_SPOOL_TRANS_CAT", "CAT_ID=" + cat_id);

            string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR",

                "SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());

            if ((sc_name == "EPIC-1") && cat_id == "10")

            {

                new_trans = General_Functions.NextSerialNo("PIP_SPOOL_TRANS", "SER_NO", "6200299-ARN-", 4,

                   " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +

                   " AND CAT_ID=" + cat_id + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());

            }

            else if (sc_name == "EPIC-7" && cat_id == "10")

            {

                new_trans = General_Functions.NextSerialNo("PIP_SPOOL_TRANS", "SER_NO", "6200398-ARN-", 4,

                   " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +

                   " AND CAT_ID=" + cat_id + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());



            }

            else

            {

                new_trans = General_Functions.NextSerialNo("PIP_SPOOL_TRANS", "SER_NO", prefix + sc_name + "-", 4,

                       " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +

                       " AND CAT_ID=" + cat_id + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());

            }

            txtTransNo.Text = new_trans;

        }

        catch (Exception ex)

        {

            Master.show_error(ex.Message);

        }

    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }
    
}