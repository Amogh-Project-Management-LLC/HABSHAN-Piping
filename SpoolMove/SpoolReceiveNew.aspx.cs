using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolReceiveNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("SPOOL RECEIVE NOTE - New");

            txtReceiveBy.Text = Session["USER_NAME"].ToString();
            txtReceiveDate.SelectedDate = System.DateTime.Today;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsSpoolReportsDTableAdapters.VIEW_SPOOL_RECEIVETableAdapter item = new dsSpoolReportsDTableAdapters.VIEW_SPOOL_RECEIVETableAdapter();
        try
        {
            item.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtRCVNo.Text,
                txtShipNo.Text,
                txtReceiveDate.SelectedDate,
                txtReceiveBy.Text,
                decimal.Parse(cboTransfer.SelectedValue), txtRemarks.Text,
                txtContainerNo.Text, decimal.Parse(ddlStoreList.SelectedValue), decimal.Parse(ddlSubconList.SelectedValue.ToString()));

            Master.show_success(txtRCVNo.Text + " Added.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlSubconList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        ddlStoreList.Items.Clear();
        ddlStoreList.Items.Add(new Telerik.Web.UI.DropDownListItem("Select Store", "-1"));
        storeDataSource.DataBind();
        cboTransfer.Text = "";
        transferDataSource.DataBind();
        cboTransfer.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select Transfer)", "-1"));
        txtTransReason.Text = "";
    }


    protected void cboTransfer_DataBinding(object sender, EventArgs e)
    {
        cboTransfer.Items.Clear();
        cboTransfer.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select Transfer)", "-1"));
    }


    protected void ddlStoreList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + ddlSubconList.SelectedValue + "'");
        prefix += "-SPL-RCV-";
        txtRCVNo.Text = WebTools.NextSerialNo("PIP_SPL_RECEIVE", "RCV_NO", prefix, 4, " WHERE SC_ID = '" + ddlSubconList.SelectedValue + "'");
    }

    protected void cboTransfer_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        txtTransReason.Text = WebTools.GetExpr("TRANSFER_REASON", "PIP_SPL_TRANSFER", " WHERE TRANS_ID = '" + cboTransfer.SelectedValue.ToString() + "'");
    }
}