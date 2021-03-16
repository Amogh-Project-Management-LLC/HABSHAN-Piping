using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsWeldingATableAdapters;
using Telerik.Web.UI;

public partial class WeldingInspec_PipingDFWR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Master.HeadingMessage = "Daily Fitup & Welding Report";
        }
    }


    protected void btnDFR_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=17&RetUrl=~/WeldingInspec/PipingDFWR.aspx");
    }

    protected void btnDWR_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=16&RetUrl=~/WeldingInspec/PipingDFWR.aspx");
    }

    protected void rblReportType_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (rblReportType.SelectedValue)
        {
            case "1":
                Fitup_Entry.Visible = true;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = false;
                break;
            case "2":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = true;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = false;
                // ddlwpsList.DataBind();
                break;
            case "3":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = true;
                Bonding.Visible = false;

                break;
            case "4":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = true;
                break;

        }

    }


    protected void rcbFitupJoint_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {

            string joint = rcbFitupJoint.SelectedValue.ToString();

            if (joint != string.Empty && joint != "-1" && joint != "")
            {
                rcbHeatNo1.Enabled = true;
                rcbHeatNo2.Enabled = true;
                rcbHeatNo1.Items.Clear();
                rcbHeatNo2.Items.Clear();
                rcbHeatNo1.DataBind();
                rcbHeatNo2.DataBind();
                rcbHeatNo1.Text = "";
                rcbHeatNo2.Text = "";

                //IsoIdField.Value = WebTools.GetExpr("ISO_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + ddlJointNo.SelectedValue.ToString());
                string bom1 = WebTools.GetExpr("ITEM_1", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
                string bom2 = WebTools.GetExpr("ITEM_2", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);

                if (string.IsNullOrEmpty(bom1) || string.IsNullOrEmpty(bom2))
                {
                    Master.ShowError("Set Items are not defined for this Joint, Update in Joints page.!");
                    return;
                }
                string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
                int swn_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_SWN_SPOOL WHERE SPL_ID=" + spl_id));
                int rel_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_REL_REQ_SPL WHERE SPL_ID=" + spl_id));

                if (swn_cnt > rel_cnt)
                {
                    Master.ShowError("Spool Under SWN!");

                    return;
                }
                string jnt_type = WebTools.GetExpr("JOINT_TYPE", "PIP_SPOOL_JOINTS", "  WHERE JOINT_ID=" + rcbFitupJoint.SelectedValue.ToString());

                string mat_id1 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom1);
                string mat_id2 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom2);
                rcbHeatNo1.DataBind();
                rcbHeatNo2.DataBind();
                string item_id1 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id1);
                string item_id2 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id2);

                string item_group1 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id1);
                string item_group2 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id2);
                string heat_no1 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", " WHERE BOM_ID=" + bom1);

                if (item_group1 == "SUPPORT")
                {
                    txtSuppHeatNo1.Visible = true;
                    rcbHeatNo1.Visible = false;
                    if (heat_no1 != string.Empty)
                    {
                        txtSuppHeatNo1.Text = heat_no1;
                        //txtSuppHeatNo2.Enabled = false;
                    }
                }
                else
                {
                    if (heat_no1 != "")
                    {
                        string hn1 = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_HN", " WHERE MAT_ID =" + mat_id1);
                        if (hn1 == string.Empty)
                        {
                            rcbHeatNo1.Items.Insert(0, new RadComboBoxItem(heat_no1, heat_no1));
                            rcbHeatNo1.SelectedIndex = 0;
                            //rcbHeatNo1.Enabled = false;
                        }
                        else
                        {
                          
                            rcbHeatNo1.SelectedValue = heat_no1;
                            rcbHeatNo1.SelectedIndex = 0;
                            //rcbHeatNo1.Enabled = false;
                        }
                    }
                }
                string heat_no2 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", " WHERE BOM_ID=" + bom2);
                if (item_group2 == "SUPPORT")
                {
                    txtSuppHeatNo2.Visible = true;
                    rcbHeatNo2.Visible = false;
                    if (heat_no2 != string.Empty)
                    {
                        txtSuppHeatNo2.Text = heat_no2;
                        //txtSuppHeatNo2.Enabled = false;
                    }
                }
                else
                {
                    if (heat_no2 != "")
                    {

                        string hn2 = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_HN", " WHERE MAT_ID =" + mat_id2);
                        if (hn2 == string.Empty)
                        {
                            rcbHeatNo2.Items.Insert(0, new RadComboBoxItem(heat_no2, heat_no2));
                            rcbHeatNo2.SelectedIndex = 0;
                            //rcbHeatNo2.Enabled = false;

                        }
                        else
                        {
                            rcbHeatNo2.SelectedValue = heat_no2;
                            rcbHeatNo2.SelectedIndex = 0;
                            //rcbHeatNo2.Enabled = false;
                        }
                    }
                }
                string sql = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK, " +
               "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER, " +
                "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, mat_code1 AS COMMODITY1, mat_code2 AS COMMODITY2,TW_FLG,  mat_class AS LINE_CLASS, MAT_TYPE,SPL_SWN_DT,SPL_REL_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME " +
                " FROM  view_adapter_joints WHERE(JOINT_ID = :JOINT_ID)";



                jointDetailsDataSource1.SelectCommand = sql;
                jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, joint);
                jointDetailsView.DataBind();

            }
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }


    protected void rcbWeldIsoJnt_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            string joint = rcbWeldIsoJnt.SelectedValue.ToString();
            if (joint != "")
            {
                string weld_wps = WebTools.GetExpr("WPS_NO", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);

                if (weld_wps != string.Empty || weld_wps != "")
                {
                    string wps_id = WebTools.GetExpr("WPS_ID", "PIP_WPS_NO", " WHERE WPS_NO1='" + weld_wps + "'");                 
                    ddlWelder.Items.Clear();
                    ddlWelder.DataBind();
                    ddlWeldWps.SelectedValue = wps_id;
                }
                else
                {
                    wpsDataSource.DataBind();
                    ddlWeldWps.Items.Clear();
                    ddlWeldWps.DataBind();
                }
                string joint_size = WebTools.GetExpr("JOINT_SIZE_DEC", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
                string joint_thk = WebTools.GetExpr("JOINT_THK", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);

                txtJoint_size.Text = joint_size;
                txtJoint_thk.Text = joint_thk;

                string sql = "SELECT JOINT_ID, ISO_TITLE1,  ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK, " +
               "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER, " +
                "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, mat_code1 AS COMMODITY1, mat_code2 AS COMMODITY2,TW_FLG,  mat_class AS LINE_CLASS, MAT_TYPE, SPL_SWN_DT,SPL_REL_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME " +
                " FROM  view_adapter_joints WHERE(JOINT_ID = :JOINT_ID)";
                jointDetailsDataSource1.SelectCommand = sql;
                jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, joint);
                jointDetailsView.DataBind();


            }
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void ddlCrew_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        // txtfornam.Text = WebTools.GetExpr("WELDER_NO", "VIEW_CREW", " WHERE CREW_ID = " + ddlCrew.SelectedValue);
    }


    protected void btnAddWelderAll_Click(object sender, EventArgs e)
    {
        try
        {
            //weldersListBox.Items.Clear();
            if (ddlWelder.SelectedValue.ToString() == "-1")
            {
                Master.ShowError("Select a welder !");
                return;
            }

            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "ROOT PASS", ddlWelder.SelectedItem.Value.ToString() + "-" + "1")
                );
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "HOT PASS", ddlWelder.SelectedItem.Value.ToString() + "-" + "2")
                );
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "FILL", ddlWelder.SelectedItem.Value.ToString() + "-" + "3")
                );
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "CAP", ddlWelder.SelectedItem.Value.ToString() + "-" + "4")
                );
        }
        catch (Exception ex)
        {
            Master.ShowError("Select a welder !");
            return;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlWelder.SelectedValue.ToString() == "-1")
            {
                Master.ShowWarn("Select the weld!");
                return;
            }
            if (ddlWelderPass.SelectedValue.ToString() == "-1")
            {
                Master.ShowWarn("Select the welder category!");
                return;
            }
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + ddlWelderPass.SelectedItem.Text,
                ddlWelder.SelectedItem.Value.ToString() + "-" + ddlWelderPass.SelectedValue.ToString()));
        }

        catch (Exception ex)
        {
            Master.ShowError("Select a welder !");
            return;
        }
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        try
        {
            if (weldersListBox.SelectedIndex == -1)
            {
                Master.ShowError("Select the weld!");
                return;
            }
            weldersListBox.Items.Remove(weldersListBox.Items[weldersListBox.SelectedIndex]);
        }

        catch (Exception ex)
        {
            Master.ShowError("Select a row from the box !");
            return;
        }
    }

    protected void btnRemoveAll_Click(object sender, EventArgs e)
    {
        weldersListBox.Items.Clear();
    }


    protected void FitupSave_Click(object sender, EventArgs e)
    {
        string bom1 = WebTools.GetExpr("ITEM_1", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + rcbFitupJoint.SelectedValue.ToString());
        string bom2 = WebTools.GetExpr("ITEM_2", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + rcbFitupJoint.SelectedValue.ToString());
        if (bom1 == "" || bom2 == "")
        {
            return;
        }
        string mat_id1 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom1);
        string mat_id2 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom2);
        string item_id1 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id1);
        string item_id2 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id2);

        if(item_id1=="" || item_id2=="")
        {
            Master.ShowError("Update Item name for BOM");
            return;
        }

        string item_group1 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id1);
        string item_group2 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id2);
        string hn1 = "";
        string hn2 = "";
        if (item_group1 == "SUPPORT")
        {
            hn1 = txtSuppHeatNo1.Text;
            if (hn1 == "")
            {
                Master.ShowError("Selected Valid Heat No1");
                return;
            }
        }
        else
        {
            if (rcbHeatNo1.SelectedIndex < 0)
            {
                Master.ShowError("Selected Valid Heat No1");
                return;
            }
            hn1 = rcbHeatNo1.SelectedValue.ToString();
        }

        if (item_group2 == "SUPPORT")
        {
            hn2 = txtSuppHeatNo2.Text;
            if (hn2 == "")
            {
                Master.ShowError("Selected Valid Heat No2");
                return;
            }
        }
        else
        {
            if (rcbHeatNo2.SelectedIndex < 0 && rcbHeatNo2.SelectedValue.ToString() == string.Empty)
            {
                Master.ShowError("Selected Valid Heat No2");
                return;
            }
            hn2 = rcbHeatNo2.SelectedValue.ToString();
        }

        DateTime Date3 = System.DateTime.Now;
        string fitup_entry_date = Date3.ToString("dd-MMM-yyyy");

        PIP_SPOOL_JOINTSTableAdapter joint_fitup = new PIP_SPOOL_JOINTSTableAdapter();
        joint_fitup.UpdateJointFitup(txtFitupRep.Text, DateTime.Parse(txtFitupDate.SelectedDate.ToString()), ddlFitupInspCode.SelectedValue.ToString(), hn1, hn2, DateTime.Parse(fitup_entry_date), txtFitupForeman.Text, int.Parse(rcbFitupJoint.SelectedValue));

        string sql_heat_no = "UPDATE PIP_BOM SET HEAT_NO = '" + hn1 + "' WHERE BOM_ID = " + bom1 + " and HEAT_NO IS NULL";
        WebTools.ExeSql(sql_heat_no);
        sql_heat_no = "UPDATE PIP_BOM SET HEAT_NO = '" + hn2 + "' WHERE BOM_ID = " + bom2 + " AND HEAT_NO IS NULL";
        WebTools.ExeSql(sql_heat_no);

        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
          "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
           "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
           " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
           "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, rcbWeldIsoJnt.SelectedValue.ToString());
        jointDetailsView.DataBind();
        rcbHeatNo1.Text = "";
        rcbHeatNo2.Text = "";
        Master.ShowSuccess("Fitup Details Updated Successfully");

    }

    protected void WeldSave_Click(object sender, EventArgs e)
    {
        string sql, wps_no;
        string welder = string.Empty;
        wps_no = string.Empty;
        // string joint_id = ddlJointNo.SelectedValue.ToString();
        string joint_id = rcbWeldIsoJnt.SelectedValue.ToString();
        DateTime DATE = (DateTime)txtWeldDate.SelectedDate;
        string date_ = DATE.ToString("dd-MMM-yyyy");
        DateTime DATE2 = (DateTime)txtInspDate.SelectedDate;
        string insp_date = DATE2.ToString("dd-MMM-yyyy");
        DateTime Date3 = System.DateTime.Now;
        string weld_entry_date = Date3.ToString("dd-MMM-yyyy");
        string rep_no = "'" + txtWeldRepNo.Text + "'";
        string insp = "'" + rcbWeldInsp.Text + "'";

        DateTime fitup_date;
        try
        {
            fitup_date = DateTime.Parse(WebTools.GetExpr("FITUP_DATE", "PIP_SPOOL_JOINTS", "JOINT_ID=" + rcbWeldIsoJnt.SelectedValue.ToString()));
            if (DateTime.Parse(txtWeldDate.SelectedDate.ToString()) < (DateTime)(fitup_date))
            {
                Master.ShowError("Weld Date cannot be before fitup date!");
                return;
            }
        }
        catch (Exception ex)
        {
            Master.ShowError("Weld date is less than fitup date !" + ex.Message);
            return;
        }

        if (DATE > DateTime.Parse(System.DateTime.Now.ToString()))
        {
            Master.ShowError("Weld Date cannot be updated greater than Today Date");
            return;
        }

        //swn check
        string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + rcbWeldIsoJnt.SelectedValue);
        int swn_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_SWN_SPOOL WHERE SPL_ID=" + spl_id));
        int rel_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_REL_REQ_SPL WHERE SPL_ID=" + spl_id));

        if (swn_cnt > rel_cnt)
        {
            Master.ShowError("Spool Under SWN!");

            return;
        }

        if (weldersListBox.Items.Count <= 0)
        {
            Master.ShowError("Select Welder");
            return;
        }
        if (ddlWeldWps.SelectedIndex < 0)
        {
            Master.ShowError("Select WPS No");
            return;
        }
        //   string wps_entry = WebTools.GetExpr("DAILY_WLD_WPS", "PROJECT_INFORMATION"," WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());

        wps_no = ddlWeldWps.SelectedItem.Text.ToString();


      //  sql = "UPDATE PIP_SPOOL_JOINTS SET  WELD_DATE = '" + date_ + "'" + ",WELD_MACHINE = '" + txtWeldMachine.Text + "', SHIFT_TIME = '" + ddlSiftTime.SelectedValue + "', WELD_REP_NO=" + rep_no + ",WELD_INSP=" + insp + ",WELD_INSP_DATE='" + insp_date + "'" + ",WELD_ENTRY_DATE='" + weld_entry_date + "'";
        sql = "UPDATE PIP_SPOOL_JOINTS SET  WELD_DATE = '" + date_ + "'" + ",WELD_INSP_RESULT='" + txtInspResult.Text + "',WELD_MACHINE = null, SHIFT_TIME = 'null', WELD_REP_NO=" + rep_no + ",WELD_INSP=" + insp + ",WELD_INSP_DATE='" + insp_date + "'" + ",WELD_ENTRY_DATE='" + weld_entry_date + "'" + ",WELD_FOREMAN='" + txtWeldForeman.Text + "'";
        if (wps_no != "") sql += ",WPS_NO='" + wps_no + "'";
       // if (txtConsumable.Text != "") sql += ",CNS_BATCH='" + txtConsumable.Text + "'";
        sql += " WHERE JOINT_ID=" + joint_id;

        try
        {
            WebTools.ExeSql(sql);


            //Add Welders
            if (weldersListBox.Items.Count > 0)
            {
                for (int i = 0; i < weldersListBox.Items.Count; i++)
                {
                    welder = weldersListBox.Items[i].Value.ToString();
                    string welder_exist = WebTools.GetExpr("WELDER_ID", "PIP_SPOOL_WELDING", " WHERE JOINT_ID=" + joint_id + " AND WELDER_ID=" + welder.Substring(0, welder.IndexOf("-")) + " AND PASS_ID=" + welder.Substring(welder.IndexOf("-") + 1));
                    if (welder_exist == "")
                        WebTools.ExeSql("INSERT INTO PIP_SPOOL_WELDING(JOINT_ID, WELDER_ID, PASS_ID) VALUES(" + joint_id + "," +
                            welder.Substring(0, welder.IndexOf("-")) + "," + welder.Substring(welder.IndexOf("-") + 1) + ")");

                }
                string root_hot = WebTools.GetExpr("ROOT_HOT", "VIEW_JNT_WELDER_UPDATE", " WHERE JOINT_ID=" + joint_id);
                string fill_cap = WebTools.GetExpr("FILL_CAP", "VIEW_JNT_WELDER_UPDATE", " WHERE JOINT_ID=" + joint_id); ;

                string weld_jnt_sql = "UPDATE PIP_SPOOL_JOINTS SET ROOT_HOT_WELDER='" + root_hot + "',FILL_CAP_WELDER='" + fill_cap + "' where joint_id=" + joint_id;
                WebTools.ExeSql(weld_jnt_sql);
            }

            string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
         "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
          "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
          " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
          "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";

            Master.ShowMessage("Joint welding updated successfully for : " + rcbWeldIsoJnt.SelectedItem.Text);
            jointDetailsDataSource1.SelectCommand = sql_1;
            jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, rcbWeldIsoJnt.SelectedValue.ToString());

            jointDetailsView.DataBind();
            rcbWeldIsoJnt.ClearSelection();
            rcbWeldIsoJnt.DataBind();
            ddlWeldWps.ClearSelection();
            ddlWeldWps.Items.Clear();
            ddlWelder.ClearSelection();
            // ddlWeldWps.DataBind();

        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
            return;
        }
    }

    protected void btnRepairDWR_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WeldingInspec/RepairWeldingEntry.aspx");
    }
    protected void btnTWEntry_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WeldingInspec/TackWeldEntry.aspx");
    }



    protected void ddlSubcon_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {

        switch (rblReportType.SelectedValue)
        {
            case "1":
                //  rcbFitupJoint.Text = "";
                rcbFitupJoint.Items.Clear();
                rcbFitupJoint.DataBind();


                ddlFitupInspCode.Items.Clear();
                ddlFitupInspCode.Items.Insert(0, new DropDownListItem("Fitup Inspector", "Fitup Inspector"));
                ddlFitupInspCode.DataBind();
                break;
            case "2":
                //  rcbWeldIsoJnt.Text = "";
                rcbWeldIsoJnt.Items.Clear();
                rcbWeldIsoJnt.DataBind();

                rcbWeldInsp.Items.Clear();
                rcbWeldInsp.Items.Insert(0, new RadComboBoxItem("Weld Inspector", "Weld Inspector"));

                rcbWeldInsp.DataBind();
                break;
            case "3":
                //  rcbWeldIsoJnt.Text = "";
                rcbLamJoint.Items.Clear();
                rcbLamJoint.DataBind();

                break;
        }

    }

    protected void ddlWeldWps_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddlWelder.Items.Clear();
        ddlWelder.DataBind();
    }

    protected void btnWeldRep_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/WeldingInspec/WeldingReports.aspx");
    }

    protected void rcbLamJoint_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }

    protected void btnLamination_Click(object sender, EventArgs e)
    {


        PIP_SPOOL_JOINTSTableAdapter joint_lam = new PIP_SPOOL_JOINTSTableAdapter();
        joint_lam.UpdateLaminate(txtLamRep.Text, DateTime.Parse(txtLamDate.SelectedDate.ToString()), txtLamHeatNo1.Text, txtLamHeatNo2.Text, txtLamTHK.Text , int.Parse(rcbLamJoint.SelectedValue));


        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
         "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
          "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
          " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
          "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, rcbLamJoint.SelectedValue.ToString());
        jointDetailsView.DataBind();
        rcbHeatNo1.Text = "";
        rcbHeatNo2.Text = "";
        Master.ShowSuccess("Lamination Details Updated Successfully");
    }

    protected void rcbBondingJoint_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }

    protected void btnBonding_Click(object sender, EventArgs e)
    {

        PIP_SPOOL_JOINTSTableAdapter joint_Bonding = new PIP_SPOOL_JOINTSTableAdapter();
        joint_Bonding.UpdateBonding(txtBondingRep.Text, DateTime.Parse(txtBondingDate.SelectedDate.ToString()), txtBondingName.Text, DateTime.Parse(txtCuringDate.SelectedDate.ToString()), int.Parse(rcbBondingJoint.SelectedValue));


        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
          "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
           "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
           " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
           "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, rcbBondingJoint.SelectedValue.ToString());
        jointDetailsView.DataBind();
        rcbHeatNo1.Text = "";
        rcbHeatNo2.Text = "";
        Master.ShowSuccess("Bonding Details Updated Successfully");

    }

    protected void btnWPS_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("WPS_JOINT_UPDATE"))
        {
            RadWindowManager1.RadAlert("Access denied.", 300, 150, "Warning", "");
            return;
        }
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=33&RetUrl=~/WeldingInspec/PipingDFWR.aspx");
    }
}