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

public partial class SpoolMove_SpoolPaintNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Spool Pickling - Register");
        }
    }

    private void go_back()
    {
        Response.Redirect("SpoolPaint.aspx");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_PKLNG_SPLTableAdapter pkl_tbl = new VIEW_ADAPTER_PKLNG_SPLTableAdapter();
        try
        {
            pkl_tbl.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtTransNo.Text,
                txtTransDate.SelectedDate,
                txtTarget.SelectedDate,
                decimal.Parse(cboSubcon.SelectedValue),
                txtRemarks.Text);

            Master.show_success("Transmittal created.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            pkl_tbl.Dispose();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        go_back();
    }
    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        string conn_as = Session["CONNECT_AS"].ToString();
        if (conn_as != "99")
        {
            for (int i = 0; i <= cboSubcon.Items.Count; i++)
            {
                if (cboSubcon.Items[i].Value.ToString() == conn_as)
                {
                    cboSubcon.SelectedIndex = i;
                    break;
                }
            }
            cboSubcon.Enabled = false;
        }
    }

    private void set_pnt_no()
    {
        try
        {
            string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");
            string short_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID='" + cboSubcon.SelectedValue + "'");
            string prefix =job_code + "-SPL-PICKLING-" + short_name + "-";
            txtTransNo.Text =
                General_Functions.NextSerialNo("PIP_PICKLING_SPL", "PICKLING_REQ_NO", prefix, 4,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND SC_ID = '" + cboSubcon.SelectedValue + "'");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
    protected void btnUpdateSeqNo_Click(object sender, EventArgs e)
    {
        set_pnt_no();
    }

    protected void cboSubcon_DataBinding(object sender, EventArgs e)
    {
        cboSubcon.Items.Clear();
        cboSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void cboSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        set_pnt_no();
    }
}