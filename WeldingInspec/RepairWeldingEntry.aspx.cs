using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WeldingInspec_RepairWeldingEntry : System.Web.UI.Page
{
    private static string pwht_type = string.Empty;
    private static string repair_cnt_nde_req = string.Empty;
    private static string repair_cnt_entry = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Repair Welding";
            drpRepairCode.Items.Clear();
            cboWps.Visible = true;
        }
    }
    
    //////////////////////////////////////////////////////////////////////////////////////// 
    //                                 HEADER MENU                                        //
    //////////////////////////////////////////////////////////////////////////////////////// 
    protected void HeaderMenu_ItemClick(object sender, EventArgs e)
    {
        string myMenu = HeaderMenu.SelectedValue.ToString();
        switch (myMenu)
        {
            case "repaired":
                {
                    Response.Redirect("RepairWeldingHistory.aspx");
                }
                break;
            case "entry":
                {
                    if (entryPanel.Visible)
                        entryPanel.Visible = false;
                    else
                        entryPanel.Visible = true;
                }
                break;
            case "back":
                Response.Redirect("~/WeldingInspec/PipingDFWR.aspx");
                break;
        }
    }

    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        string conn_as = Session["CONNECT_AS"].ToString();
        if (conn_as != "99")
        {
            for (int i = 0; i < cboSubcon.Items.Count; i++)
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string pwht_type = string.Empty;
        string repair_cnt_nde_req = string.Empty;
        string repair_cnt_entry = string.Empty;

        string repair_cnt_nde_req_ut = string.Empty;
        string repair_cnt_entry_ut = string.Empty;


        pwht_type = WebTools.GetExpr("NVL(PWHT,'N')", "PIP_SPOOL_JOINTS", " JOINT_ID=" + Decimal.Parse(cboJoints.SelectedValue));

        repair_cnt_nde_req = WebTools.CountExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", " PASS_FLG_ID=2  AND  NDE_TYPE_ID IN (1,9,12,15)  AND  JOINT_ID=" + Decimal.Parse(cboJoints.SelectedValue) + "  GROUP BY JOINT_ID");
        repair_cnt_entry = WebTools.CountExpr("JOINT_ID", "PIP_JOINTS_REPAIR_DWR", " JOINT_ID=" + Decimal.Parse(cboJoints.SelectedValue) + "  GROUP  BY JOINT_ID");
      

        if ((decimal.Parse(repair_cnt_nde_req.ToString()) > 0 && decimal.Parse(repair_cnt_entry.ToString()) > 0))
        {
            if ((decimal.Parse(repair_cnt_nde_req.ToString()) == decimal.Parse(repair_cnt_entry.ToString())))
            {
                Master.ShowError("Repair Information already exists, cannot be updated!");
                return;
            }
        }
        if (drpWelder1.SelectedValue == "-1" && drpWelder2.SelectedValue == "-1" && drpWelder3.SelectedValue == "-1" && drpWelder4.SelectedValue == "-1")
        {
            Master.ShowError("No Repair Welder Selected.");
            return;
        }

        if (drpRepairCode.SelectedIndex==-1)
        {
            Master.ShowError("Select Repair Code");
            return;
        }
        if(cboWps.SelectedIndex==-1)
        {
            Master.ShowError("Select WPS No.");
            return;
        }





        //    VIEW_ADAPTER_NDE_STATUSTableAdapter adpt = new VIEW_ADAPTER_NDE_STATUSTableAdapter();
        try
        {
            string wps_no = string.Empty;
            DateTime REP_DATE;
            REP_DATE = DateTime.Parse(txtRepDate.SelectedDate.ToString());
            string REP_DATE_STRING;
            REP_DATE_STRING = REP_DATE.ToString("dd-MMM-yyyy");
            //DAILY_WLD_WPS in PROJECT_INFORMATION
            //A-->Dropdown
            //B-->Textbox
          //  string wps_entry = WebTools.GetExpr("DAILY_WLD_WPS", "PROJECT_INFORMATION"," WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());
      
                wps_no = cboWps.SelectedItem.Text.ToString();
          
            string sql;
            sql = "INSERT INTO PIP_JOINTS_REPAIR_DWR (JOINT_ID,REPAIR_CODE, REPAIR_DATE, WELD_REPORT_NO, WPS_NO) VALUES (";
            sql += Decimal.Parse(cboJoints.SelectedValue) + ",";
            sql += "'" + drpRepairCode.SelectedValue + "'" + ",";
            sql += "'" + REP_DATE_STRING + "'" + ",";
            sql += "'" + txtWeldRepNo.Text + "'" + ",";
            if (wps_no != "null")
            { sql += "'" + wps_no + "'" + ")"; }
            else
            { sql += "''" + ")"; }


            string weldersql = "";

            if (drpWelder1.SelectedValue != "null")
            {
                weldersql = "INSERT INTO PIP_SPOOL_WELDING(JOINT_ID,WELDER_ID,REPAIR_CODE,PASS_ID) VALUES(" + Decimal.Parse(cboJoints.SelectedValue) + "," + drpWelder1.SelectedValue+ ",'" + drpRepairCode.SelectedValue.ToString() + "',1)";
                WebTools.ExeSql(weldersql);
            }
            if (drpWelder2.SelectedValue != "null")
            {
                weldersql = "INSERT INTO PIP_SPOOL_WELDING(JOINT_ID,WELDER_ID,REPAIR_CODE,PASS_ID) VALUES(" + Decimal.Parse(cboJoints.SelectedValue) + "," + drpWelder2.SelectedValue + ",'" + drpRepairCode.SelectedValue.ToString() + "',2)";
                WebTools.ExeSql(weldersql);
            }
            if (drpWelder3.SelectedValue != "null")
            {
                weldersql = "INSERT INTO PIP_SPOOL_WELDING(JOINT_ID,WELDER_ID,REPAIR_CODE,PASS_ID) VALUES(" + Decimal.Parse(cboJoints.SelectedValue) + "," + drpWelder3.SelectedValue + ",'" + drpRepairCode.SelectedValue.ToString() + "',3)";
                WebTools.ExeSql(weldersql);
            }
            if (drpWelder4.SelectedValue != "null")
            {
                weldersql = "INSERT INTO PIP_SPOOL_WELDING(JOINT_ID,WELDER_ID,REPAIR_CODE,PASS_ID) VALUES(" + Decimal.Parse(cboJoints.SelectedValue) + "," + drpWelder4.SelectedValue + ",'" + drpRepairCode.SelectedValue.ToString() + "',4)";
                WebTools.ExeSql(weldersql);
            }


            string rep_date_sql = "UPDATE PIP_SPOOL_JOINTS SET REPAIR_DATE=" + "'" + REP_DATE_STRING + "'" + " WHERE JOINT_ID=" + Decimal.Parse(cboJoints.SelectedValue);

            try
            {
                WebTools.ExeSql(sql);
                WebTools.ExeSql(rep_date_sql);
                RadGrid1.DataBind();
                Master.ShowSuccess("Saved Successfully!!");
                cboJoints.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                Master.ShowMessage(ex.Message);
                return;
            }
         //   adpt.Dispose();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Repair Information Updated successfully!')", true);
        }
        catch (Exception ex)
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "show alert", "alert('Error!!!')", true);
            Master.ShowMessage(ex.Message);
            return;
        }
        finally
        {
          //  adpt.Dispose();
        }
    }

    protected void cboJoints_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
      

      
            drpRepairCode.Items.Clear();
            //string rep_code;
            string sql = "select NEXT_DWR_REPAIR_CODE from view_repair_dwr_bal where joint_id=" + cboJoints.SelectedValue.ToString();
            RepairCodeDataSource.SelectCommand = sql;
            RepairCodeDataSource.DataBind();

            //rep_code = WebTools.GetExpr("NEXT_DWR_REPAIR_CODE", "VIEW_REPAIR_DWR_BAL", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            //if (rep_code == "")
            //{
            //    drpRepairCode.Items.Add(new Telerik.Web.UI.RadComboBoxItem("R1", "R1"));
            //}
            //if (rep_code == "R1")
            //{
            //    drpRepairCode.Items.Add(new Telerik.Web.UI.RadComboBoxItem("R2", "R2"));
            //}
            //if (rep_code == "R2")
            //{
            //    drpRepairCode.Items.Add(new Telerik.Web.UI.RadComboBoxItem("R3", "R3"));
            //}
            //if (rep_code == "R3")
            //{
            //    drpRepairCode.Items.Add(new Telerik.Web.UI.RadComboBoxItem("R4", "R4"));
            //}
            //if (rep_code == "R4")
            //{
            //    drpRepairCode.Items.Add(new Telerik.Web.UI.RadComboBoxItem("R5", "R5"));
            //}
        

        //new addition
        if (IsPostBack)
        {
            string wps_no;
            string joint_size, joint_thk;
            string joint_id = cboJoints.SelectedValue.ToString();
            wps_no = WebTools.GetExpr("WPS_NO", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint_id);
            joint_size = WebTools.GetExpr("JOINT_SIZE_DEC", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint_id);
            joint_thk = WebTools.GetExpr("JOINT_THK", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint_id);
          //  txtWPS_No.Text = wps_no;
            txtJoint_size.Text = joint_size;
            txtJoint_thk.Text = joint_thk;
        }
        //end
    }
    protected void cboWps_DataBinding1(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            cboWps.Items.Clear();
            cboWps.Items.Add(new Telerik.Web.UI.RadComboBoxItem(string.Empty, string.Empty));
        }
    }
    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Delete")
            {
                int index = e.Item.RowIndex;
                var item = RadGrid1.Items[index - 2] as Telerik.Web.UI.GridDataItem;
                var joint_id = item.GetDataKeyValue("JOINT_ID");
                var repair_code = item.GetDataKeyValue("REPAIR_CODE");
                string count = WebTools.CountExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", " REPAIR_CODE IS NOT NULL AND JOINT_ID=" + joint_id + " AND REPAIR_CODE='" + repair_code + "'");
                if (count.ToString() != "0")
                {
                    e.Canceled = true;
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('This Joint exists in other modules.It cannot be deleted!')", true);
                    return;
                }
                else
                {
                    e.Canceled = false;
                }
            }

            if (e.CommandName == "Edit")
            {
                int index = e.Item.RowIndex;
                var item = RadGrid1.Items[index - 2] as Telerik.Web.UI.GridDataItem;
                var joint_id = item.GetDataKeyValue("JOINT_ID");
                //  HiddenField1.Value = WebTools.GetExpr("WPS_NO", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint_id);
                HiddenField2.Value = WebTools.GetExpr("JOINT_SIZE_DEC", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint_id);
                HiddenField3.Value = WebTools.GetExpr("JOINT_THK", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint_id);
                string cat_id = WebTools.GetExpr("CAT_ID", "PIP_SPOOL_JOINTS", " WHERE  JOINT_ID=" + joint_id);
                if (cat_id == "1" || cat_id == "3")
                {
                    HiddenField1.Value = "1";
                }
                else
                {
                    HiddenField1.Value = "2";
                }
            }
        }
        catch (Exception exc)
        {
            Master.ShowError( exc.Message);
        }
    }
    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            Telerik.Web.UI.GridDataItem dataitem = (Telerik.Web.UI.GridDataItem)e.Item;
            if (!WebTools.UserInRole("PIP_REPAIR_UPDATE"))
            {
                ((ImageButton)dataitem["EditCommandColumn"].Controls[0]).Visible = false;
            }
            if (!WebTools.UserInRole("PIP_REPAIR_DELETE"))
            {
                ((ImageButton)dataitem["DeleteColumn"].Controls[0]).Visible = false;
            }
        }
    }


    protected void Entry_Click(object sender, EventArgs e)
    {
        if (entryPanel.Visible)
            entryPanel.Visible = false;
        else
            entryPanel.Visible = true;
    }
}





