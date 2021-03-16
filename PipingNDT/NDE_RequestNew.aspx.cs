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
using dsNDETableAdapters;

public partial class WeldingInspec_NDE_RequestNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New NDT Request");

            if (!WebTools.UserInRole("PIP_WIC_INSERT"))
            {
                btnSubmit.Enabled = false;
                cboSubcon.Enabled = false;
                txtReqNo.Enabled = false;
                return;
            }
        }
    }
    private void set_req_no()
    {
        string nde_type = WebTools.GetExpr("NDE_PREFIX", "PIP_NDE_TYPE", " WHERE NDE_TYPE_ID=" + cboNdeType.SelectedValue.ToString());

        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + cboSubcon.SelectedValue.ToString());

        try
        {
            txtReqNo.Text = WebTools.NextSerialNo("PIP_NDE_REQUEST", "NDE_REQ_NO", "NDT-"+nde_type + sc_name + "-",
                4,
                " WHERE PROJECT_ID=" + Session["PROJECT_ID"] +
                " AND NDE_TYPE_ID=" + cboNdeType.SelectedValue.ToString() +
                " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
        }
        catch (Exception ex)
        {
            txtReqNo.Text = "NDE-" + nde_type + "-" + sc_name + "-";
            Master.show_error(ex.Message);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        VIEW_ADAPTER_NDETableAdapter nde = new VIEW_ADAPTER_NDETableAdapter();
        try
        {
            if(txtIssueDate.SelectedDate>System.DateTime.Today)
            {
                Master.show_error("Issue Date is greater than Today!");
                return;
            }

            nde.InsertQuery(txtReqNo.Text,
                Decimal.Parse(cboNdeType.SelectedValue.ToString()),
                txtIssueDate.SelectedDate,
                Decimal.Parse(cboSubcon.SelectedValue.ToString()),
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtRemarks.Text);

            Master.show_success(txtReqNo.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            nde.Dispose();
        }
    }
    protected void cboNdeType_DataBound(object sender, EventArgs e)
    {
        string nde_type = Request.QueryString["NDE_TYPE_ID"];
        for (int i = 0; i <= cboNdeType.Items.Count; i++)
        {
            if (cboNdeType.Items[i].Value.ToString() == nde_type)
            {
                cboNdeType.SelectedIndex = i;
                break;
            }
        }
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }
    protected void cboSubcon_DataBinding(object sender, EventArgs e)
    {
        cboSubcon.Items.Clear();
       
    }

    protected void cboNdeType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if(cboSubcon.SelectedValue!="-1")
        set_req_no();
    }
}