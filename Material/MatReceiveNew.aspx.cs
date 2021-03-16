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

public partial class Material_MatReceiveNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "MRV - New";

            txtRecvby.Text = Session["USER_NAME"].ToString();
            txtCreateDate.SelectedDate = System.DateTime.Today;

            if (!WebTools.UserInRole("MM_INSERT"))
            {
                btnSubmit.Enabled = false;
                txtReportNo.Text = "Access Denied!";
                return;
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (cboStore.SelectedValue.ToString().Equals("-1"))
        {
            txtReportNo.Text = "";
            Master.ShowWarn("Please select a store !");
            return;
        }
        string sql = string.Empty;
        string po_id = ddlPOList.SelectedValue;
        if (ddlPOList.SelectedValue == "-11")
        {
            sql = "INSERT INTO PIP_PO (PROJECT_ID, PO_NO, PO_TITLE, PO_DATE, PO_REV, MANUFACTURE, CREATE_BY) VALUES ";
            sql += " ('" + Session["PROJECT_ID"].ToString() + "', '" + txtPO.Text + "', '" + txtItemDescr.Text + "','" + System.DateTime.Today.ToString("dd-MMM-yyyy") + "',";
            sql += " '0', '" + txtSupplier.Text + "', '" + Session["USER_NAME"] + "')";

            WebTools.ExeSql(sql);

            po_id = WebTools.GetExpr("PO_ID", "PIP_PO", " WHERE PO_NO='" + txtPO.Text + "'");
        }

        sql = "INSERT INTO PIP_MAT_RECEIVE (PROJECT_ID,MAT_RCV_NO,RECV_DATE,RECV_BY,SHIP_NO,STORE_ID, PO_ID, ITEM_DESCR, SUPPLIER)" +
            " VALUES (" + Session["PROJECT_ID"].ToString() + ",'" +
            txtReportNo.Text + "','" + txtCreateDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "','" +
            txtRecvby.Text + "','" + txtShipNo.Text + "'," + cboStore.SelectedValue.ToString() + 
            ",'" + po_id + "', '" + txtItemDescr.Text +"', '" + txtSupplier.Text+"')";
        try
        {
            General_Functions.ExeSql(sql);
            string mrv_id = WebTools.GetExpr("MAT_RCV_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_NO = '" + txtReportNo.Text + "'");
            if (!string.IsNullOrEmpty(mrv_id.Trim()))
            {
                for (int i = 0; i < txtAutoSRNNo.Entries.Count; i++)
                {
                    sql = "INSERT INTO PIP_MAT_RECEIVE_SRN (MRV_ID, SRN_NO) VALUES ('" + mrv_id + "', '" + txtAutoSRNNo.Entries[i].Text + "')";
                    WebTools.ExeSql(sql);
                }
            }
            Master.ShowMessage("MRV created successfully.");
        }
        catch (Exception ex)
        {
            string mrv_id = WebTools.GetExpr("MAT_RCV_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_NO = '" + txtReportNo.Text + "'");
            //string sql = string.Empty;
            if (!string.IsNullOrEmpty(mrv_id.Trim()))
            {
                //reset ---- in case of any error
                sql = "DELETE FROM PIP_MAT_RECEIVE_SRN WHERE MRV_ID = '" + mrv_id + "'";
                WebTools.ExeSql(sql);
                sql = "DELETE FROM PIP_MAT_RECEIVE WHERE MAT_RCV_ID = '" + mrv_id + "'";
                WebTools.ExeSql(sql);
            }
            Master.ShowWarn(ex.Message);
        }
    }

    protected void txtShipNo_TextChanged(object sender, EventArgs e)
    {

    }
    protected void cboMM_SELECTedIndexChanged(object sender, EventArgs e)
    {
        if (cboStore.SelectedValue.ToString().Equals("-1"))
        {
            txtReportNo.Text = "";
            return;
        }
        try
        {
            string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" +
                cboStore.SelectedValue.ToString());
            string short_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" + sc_id);
            string proj_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");

            string prefix = proj_code + "-" + short_name + "-MRV-ST-";
            txtReportNo.Text = General_Functions.NextSerialNo("PIP_MAT_RECEIVE", "MAT_RCV_NO",
                prefix, 3, " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID=" + sc_id + ")");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatReceive.aspx");
    }

    protected void cboSubcon_DataBinding(object sender, EventArgs e)
    {
        cboSubcon.Items.Clear();
        cboSubcon.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select Subcon)", ""));
    }

    protected void cboStore_DataBinding(object sender, EventArgs e)
    {
        cboStore.Items.Clear();
        cboStore.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select Store)", "-1"));
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        btnSubmit_Click(sender, e);

        //Import Detail

        string mrv_id = WebTools.GetExpr("MAT_RCV_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_NO = '" + txtReportNo.Text + "'");

        if (string.IsNullOrEmpty(mrv_id.Trim()))
            return;

        Response.Redirect("MatReceiveNewImport.aspx?MAT_RCV_ID=" + mrv_id);
        
    }

    protected void ddlPOList_DataBinding(object sender, EventArgs e)
    {
        ddlPOList.Items.Clear();
        ddlPOList.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select PO)", ""));
        ddlPOList.Items.Add(new Telerik.Web.UI.RadComboBoxItem("Add New PO..", "-11"));
    }
}