using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Add New MRIR");

            txtInspDate.SelectedDate = System.DateTime.Now;
            txtRecvdDate.SelectedDate = System.DateTime.Now;
            txtRcvBy.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void ddlSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID ='" + Session["PROJECT_ID"].ToString() + "'");
        string prefix = job_code + "-MRIR-" + WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + ddlSubcon.SelectedValue + "'");
        prefix = prefix + "-";
        txtMIRNo.Text = WebTools.NextSerialNo("PRC_MAT_INSP", "MIR_NO", prefix, 4, " WHERE MRIR_SC_ID='" + ddlSubcon.SelectedValue + "'");

        ddlMRVList.DataBind();
    }

    protected void ddlSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlSubcon.Items.Clear();
        ddlSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select Subcon)", "-1"));
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            decimal? po_no = null;
            decimal? mrv = null;
            if (ddlPOList.SelectedIndex > 0)
                po_no = decimal.Parse(ddlPOList.SelectedValue);

            if (ddlPOList.SelectedValue == "-11")
            {
                //Create PO in PO Table
                string sql = "INSERT INTO PIP_PO (PROJECT_ID, PO_NO, PO_DATE, PO_REV, MANUFACTURE, CREATE_BY) VALUES ('1', '";
                sql += txtPOSearch.Text + "', '" + System.DateTime.Now.ToString("dd-MMM-yyyy") + "','0', '";
                sql += txtSupplier.Text + "', '" + Session["USER_NAME"].ToString() + "')";

                //Master.show_info(sql);
                //return;
                WebTools.ExeSql(sql);

                po_no = decimal.Parse(WebTools.GetExpr("PO_ID", "PIP_PO", " WHERE PO_NO='" + txtPOSearch.Text + "'"));
            }

            if (ddlMRVList.SelectedIndex > 0)
                mrv = decimal.Parse(ddlMRVList.SelectedValue);

            string srn_no = "";
            for (int i = 0; i < txtAutoSRNNo.Entries.Count; i++)
            {
                if (i == 0)
                    srn_no = txtAutoSRNNo.Entries[i].Text;
                else
                    srn_no += "," + txtAutoSRNNo.Entries[i].Text;
            }
            string ship_mode;
            if (rdbShipMode.SelectedIndex >= 0)
                ship_mode = rdbShipMode.SelectedItem.Text;
            else
                ship_mode = "";

                dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter mir = new dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter();
            mir.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtMIRNo.Text, txtInspDate.SelectedDate, txtRecvdDate.SelectedDate,
                txtRcvBy.Text, po_no, mrv, decimal.Parse(ddlStoreList.SelectedValue), "N", txtRemarks.Text,
                srn_no, txtShipNumber.Text, ship_mode, txtInvoiceNo.Text, txtPackingList.Text, txtAWBBLTWB.Text,
                decimal.Parse(ddlSubcon.SelectedValue));

            Master.show_success("New MIR Number " + txtMIRNo.Text + " Created Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlPOList_DataBinding(object sender, EventArgs e)
    {
        ddlPOList.Items.Clear();
        ddlPOList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
        ddlPOList.Items.Add(new Telerik.Web.UI.DropDownListItem("Add New PO..", "-11"));
    }

    protected void ddlMRVList_DataBinding(object sender, EventArgs e)
    {
        ddlMRVList.Items.Clear();
        ddlMRVList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select MRV)", ""));
    }

    protected void ddlMRVList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        try
        {
            string po_id = WebTools.GetExpr("PO_ID", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");            
            string srn_no = WebTools.GetExpr("SRN_NO", "VIEW_ADAPTER_MAT_RCV", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
            string store_id = WebTools.GetExpr("STORE_ID", "VIEW_ADAPTER_MAT_RCV", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
            string ship_no = WebTools.GetExpr("SHIP_NO", "VIEW_ADAPTER_MAT_RCV", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");
            string supplier = WebTools.GetExpr("MANUFACTURE", "PIP_PO", " WHERE PO_ID='" + po_id + "'");
            
            
            //cboSRNNo.Text = srn_no;
            txtShipNumber.Text = ship_no;
            txtSupplier.Text = supplier;
            ddlStoreList.SelectedValue = store_id;
            ddlPOList.SelectedValue = po_id;
            SetSRN();

            //Set MIR Number
            string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID ='" + Session["PROJECT_ID"].ToString() + "'");
            string prefix = job_code + "-MRIR-" + WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + ddlSubcon.SelectedValue + "'");
            prefix = prefix + "-";
            txtMIRNo.Text = WebTools.NextSerialNo("PRC_MAT_INSP", "MIR_NO", prefix, 4, " WHERE MRIR_SC_ID='" + ddlSubcon.SelectedValue + "'");

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlPOList_DataBound(object sender, EventArgs e)
    {        
        SetSRN();
    }

    protected void cboSRNNo_DataBound(object sender, EventArgs e)
    {
        //SetSRN();
    }

    protected void SetSRN()
    {
        string srn_no = WebTools.GetExpr("SRN_NO", "VIEW_ADAPTER_MAT_RCV", " WHERE MAT_RCV_ID='" + ddlMRVList.SelectedValue + "'");        
        string[] srn = srn_no.Split('/');
        //string idx;
        bool flag = false;
        Telerik.Web.UI.AutoCompleteBoxEntry item;
        txtAutoSRNNo.Entries.Clear();
        foreach (string s in srn)
        {
            flag = false;
            for(int i = 0; i < txtAutoSRNNo.Entries.Count; i++)
            {
                if (txtAutoSRNNo.Entries[i].Text == s)
                    flag = true;
            }

            if (!flag && s.Length > 0)
            {
                item = new Telerik.Web.UI.AutoCompleteBoxEntry();
                item.Text = s;
                item.Value = s;
                txtAutoSRNNo.Entries.Add(item);
            }
        }
    }

    protected void ddlPOList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        txtAutoSRNNo.Entries.Clear();
        txtSupplier.Text = WebTools.GetExpr("MANUFACTURE", "PIP_PO", " WHERE PO_ID='" + ddlPOList.SelectedValue + "'");
    }
}