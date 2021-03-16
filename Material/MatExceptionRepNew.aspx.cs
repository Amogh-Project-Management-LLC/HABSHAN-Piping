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
using dsPO_ShipmentATableAdapters;

public partial class Material_MatExceptionRepNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
            Master.HeadingMessage = "Material Exception";
            txtReportNo.Text = "-Select Subcon-";
            txtReportDate.SelectedDate = System.DateTime.Today;
            txtCreatedBy.Text = Session["USER_NAME"].ToString();
        }
    }
    private void go_abck()
    {
        Response.Redirect("MatExceptionRep.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_EXCEPTION_REPTableAdapter mat_excp = new PIP_MAT_EXCEPTION_REPTableAdapter();
        try
        {
            decimal mir_id, rcv_id;
            bool IsMR_Source = decimal.TryParse(cboMR.SelectedValue, out mir_id);
            bool IsTrans_Source = decimal.TryParse(ddlTransRecive.SelectedValue, out rcv_id);
            mat_excp.InsertQuery(txtReportNo.Text, txtReportDate.SelectedDate,
                Decimal.Parse(Session["PROJECT_ID"].ToString()), mir_id,
                txtRemarks.Text, rcv_id, decimal.Parse(ddlSubconList.SelectedValue), txtCreatedBy.Text);
            Master.ShowMessage("Report created.");
            mat_excp.Dispose();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
            mat_excp.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        go_abck();
    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (RadioButtonList1.SelectedValue)
        {
            case "MRIR":
                cboMR.Items.Clear();
                cboMR.Enabled = true;
                txtSearchMIR.Enabled = true;
                ddlTransRecive.Enabled = false;
                txtSearchReceive.Enabled = false;

                break;
            case "MRV":
                ddlTransRecive.Items.Clear();
                cboMR.Enabled = false;
                txtSearchMIR.Enabled = false;
                ddlTransRecive.Enabled = true;
                txtSearchReceive.Enabled = true;
                break;
        }
    }

    protected void ddlSubconList_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtReportNo.Text = "";
        //string sc_id = WebTools.GetExpr("MRIR_SC_ID", "PRC_MAT_INSP", " MIR_ID='" + cboMR.SelectedValue + "'");
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-ESD-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + ddlSubconList.SelectedValue + "'") +"-";
        txtReportNo.Text = WebTools.NextSerialNo("PIP_MAT_EXCEPTION_REP", "REP_NO", prefix, 4, " SC_ID = '" + ddlSubconList.SelectedValue + "'");
    }

    protected void ddlSubconList_DataBinding(object sender, EventArgs e)
    {
        ddlSubconList.Items.Clear();
        ddlSubconList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void txtSearchReceive_TextChanged(object sender, EventArgs e)
    {
        mrvDataSource.DataBind();
    }

    protected void txtSearchMIR_TextChanged(object sender, EventArgs e)
    {
        cboMR.Items.Clear();
        cboMR.DataBind();
    }
}