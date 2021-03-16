using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInspDetailAdd : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Items (";
            heading += WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'") + ")";
            Master.HeadingMessage(heading);

            HiddenPO.Value = WebTools.GetExpr("PO_ID", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
        }
    }

    protected void ddlPOItems_DataBinding(object sender, EventArgs e)
    {
        ddlPOItems.Items.Clear();
        ddlPOItems.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlMTCList_DataBinding(object sender, EventArgs e)
    {
        //ddlMTCList.Items.Clear();
        //ddlMTCList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlSubStorList_DataBinding(object sender, EventArgs e)
    {
        ddlSubStorList.Items.Clear();
        ddlSubStorList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        //ddlMTCList.Visible = true;
        //txtMTCCode.Visible = false;
        //btnNew.Visible = true;
        //btnSelect.Visible = false;
       
    }

    protected void btnNew_Click(object sender, EventArgs e)
    {
        //ddlMTCList.Visible = false;
        //txtMTCCode.Visible = true;
        //btnNew.Visible = false;
        //btnSelect.Visible = true;
      
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string tc_id = "";

            if (txtAutoMTCCode.Entries.Count > 0)
            {
                string po_id = WebTools.GetExpr("PO_ID", "PRC_MAT_INSP", " MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
                tc_id = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", " UPPER(TC_CODE) = '" + txtAutoMTCCode.Entries[0].Text.ToUpper() + "' and PO_ID = '" + po_id + "'");

                if (tc_id.Trim().Length == 0)
                {

                    //Register New MTC Code.
                    string sql = "INSERT INTO PIP_TEST_CARDS (PROJECT_ID, TC_CODE, PO_ID) VALUES ('" + Session["PROJECT_ID"].ToString() + "', '" +
                        txtAutoMTCCode.Entries[0].Text.Trim() + "','" + po_id + "')";
                    WebTools.ExeSql(sql);

                    //Get TC_ID for New MTC Code
                    tc_id = WebTools.GetExpr("TC_ID", "PIP_TEST_CARDS", " UPPER(TC_CODE) = '" + txtAutoMTCCode.Entries[0].Text.ToUpper() + "'");
                }
            }
            else
            {
                Master.show_error("MTC Number cannot be blank.");
                return;
            }
            string mat_id = WebTools.GetExpr("MAT_ID", "PIP_MAT_STOCK", " MAT_CODE1='" + txtMatCode.Text + "'");


            string itemid = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " MAT_ID= " + mat_id);

            if (itemid != "19")
            {
                if (txtAcptQty.Text.ToString().IndexOf('.') > 0 || txtRcvQty.Text.ToString().IndexOf('.') > 0)
                {
                    Master.show_error("Selected Item cannot be in received in decimal Qty. <br/>Please Enter Integer Value.");
                    return;
                }               
            }
            
            if (decimal.Parse(txtAcptQty.Text.ToString()) > decimal.Parse(txtRcvQty.Text.ToString()))
            {
                Master.show_error("Accepted quantity cannot be more than received qty. <br/>Please re-check and enter valid value.");
                return;
            }
            
            decimal? substore_id = null;
            if (ddlSubStorList.SelectedIndex > 0)
                substore_id = decimal.Parse(ddlSubStorList.SelectedValue);

            string heat_no = string.Empty;
            if (txtAutoHeatNo.Entries.Count == 0)
                heat_no = "";
            else
                heat_no = txtAutoHeatNo.Entries[0].Text;


            string sql1 = "";
            sql1 = "INSERT INTO PRC_MAT_INSP_DETAIL(MIR_ID, PO_ITEM, MIR_ITEM, MAT_ID, RCV_QTY, ACPT_QTY, HEAT_NO, PAINT_SYS, TC_ID, SUBSTORE_ID, REMARKS,CEVALUE, AS_PER_PL_QTY, EXC_QTY, SH_QTY, DAMAG_QTY) ";
            sql1 += "VALUES('" + Session["popUp_MIR_ID"].ToString() + "', '" + txtPOItemNO.Text + "','" + txtMIRItemNo.Text + "','" + mat_id + "','";
            sql1 += txtRcvQty.Text + "','" + txtAcptQty.Text + "','" + heat_no + "','" + txtPS.Text + "','" + tc_id + "','" + substore_id + "','";
            sql1 += txtRemarks.Text + "','', '', '" + txtExcessQty.Text + "','" + txtShortage.Text + "','" + txtDamage.Text + "')";
           // Master.show_success(sql1);
            WebTools.ExeSql(sql1);
            string query = string.Empty;
            try
            {
                //Update SRN No
                string srn_no = WebTools.GetExpr("SRN_NO", "PRC_MAT_INSP", " WHERE MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
                string srn_no1 = string.Empty;
                string[] srn;
                
                if (srn_no.Contains(','))
                {
                    srn = srn_no.Split(',');
                    string po_id = WebTools.GetExpr("PO_ID", "PRC_MAT_INSP", " WHERE MIR_ID='" + Session["popUp_MIR_ID"].ToString() + "'");
                    string count = WebTools.CountExpr("DISTINCT SRN_NO", "PIP_PO_SPLIT_DETAIL", " WHERE PO_ID = '" + po_id + "' AND PO_ITEM = '" + txtPOItemNO.Text + "'");
                    if (decimal.Parse(count) == 1)
                    {
                        srn_no1 = WebTools.DMaxText("SRN_NO", "PIP_PO_SPLIT_DETAIL", " WHERE PO_ID = '" + po_id + "' AND PO_ITEM = '" + txtPOItemNO.Text + "'");
                    }
                    else
                    {
                        for (int i = 0; i < srn.Length; i++)
                        {
                            srn_no1 = WebTools.DMaxText("SRN_NO", "PIP_PO_SPLIT_DETAIL", " WHERE PO_ID = '" + po_id + "' AND PO_ITEM = '" + txtPOItemNO.Text + "' AND SRN_NO='" + srn[i] + "'");
                            if (srn_no1.Length > 0)
                                break;
                        }
                    }
                }
                else {
                    srn_no1 = srn_no;
                }

                query = "UPDATE PRC_MAT_INSP_DETAIL SET SRN_NO = '" + srn_no1 + "' WHERE MIR_ID = '" + Session["popUp_MIR_ID"].ToString() + "' " +
                      "  AND MIR_ITEM='" + txtMIRItemNo.Text + "'";

                WebTools.ExeSql(query);
            }
            catch (Exception ex)
            {
                //Don't do anything
            }
            Master.show_success(txtMatCode.Text + " Added Successfully.");
            //Master.show_success(query);
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void ddlPOItems_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if(ddlPOItems.SelectedItem.Text.Contains('-'))
            txtMatCode.Text = (ddlPOItems.SelectedItem.Text.Split('-'))[1].Trim();

        txtPOItemNO.Text = WebTools.GetExpr("PO_ITEM", "VIEW_ADAPTER_PO_DETAIL", " PO_ITEM_ID='" + ddlPOItems.SelectedValue + "'");
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        //if (ddlPOItems.SelectedItem.Text.Contains('-'))
        //    txtMatCode.Text = (ddlPOItems.SelectedItem.Text.Split('-'))[1].Trim();
        //txtPOItemNO.Text = WebTools.GetExpr("PO_ITEM", "VIEW_ADAPTER_PO_DETAIL", " PO_ITEM_ID='" + ddlPOItems.SelectedValue + "'");

    }

    protected void ddlPOItems_DataBound(object sender, EventArgs e)
    {
        ddlPOItems.SelectedIndex = 0;
        txtMatCode.Text = "";
        txtPOItemNO.Text = "";
    }
}