using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsWeldingATableAdapters;

public partial class WeldingInspec_TackWeldEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Tack Weld Entry";
        }
    }

    protected void rcbTWJoint_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string joint = rcbTWJoint.SelectedValue.ToString();
        rcbHeatNo1.Enabled = true;
        rcbHeatNo2.Enabled = true;
        if (joint != string.Empty || joint != "-1")
        {

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
            string jnt_type = WebTools.GetExpr("JOINT_TYPE", "PIP_SPOOL_JOINTS", "  WHERE JOINT_ID=" + rcbTWJoint.SelectedValue.ToString());

            string mat_id1 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom1);
            string mat_id2 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom2);

            hiddenMat1.Value = mat_id1;
            hiddenMat2.Value = mat_id2;
            rcbHeatNo1.DataBind();
            rcbHeatNo2.DataBind();
            string item_id1 = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id1);
            string item_id2 = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id2);

            string item_group1 = WebTools.GetExpr("SG_GROUP", "PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id1);
            string item_group2 = WebTools.GetExpr("SG_GROUP", "PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id2);
            string heat_no1 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", " WHERE BOM_ID=" + bom1);

            if (item_group1 == "SUPPORT")
            {
                txtSuppHeatNo1.Visible = true;
                rcbHeatNo1.Visible = false;
                if (heat_no1 != string.Empty)
                {
                    txtSuppHeatNo1.Text = heat_no1;
                    txtSuppHeatNo2.Enabled = false;
                }
            }
            else
            {
                if (heat_no1 != string.Empty)
                {
                    string hn1 = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_HN", " WHERE MAT_ID =" + mat_id1);
                    if (hn1 == string.Empty)
                    {
                        rcbHeatNo1.Items.Insert(0, new RadComboBoxItem(heat_no1, heat_no1));
                        rcbHeatNo1.SelectedIndex = 0;
                        rcbHeatNo1.Enabled = false;

                    }
                    else
                    {
                        rcbHeatNo1.SelectedValue = heat_no1;
                        rcbHeatNo1.Enabled = false;
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
                    txtSuppHeatNo2.Enabled = false;
                }
            }
            else
            {
                if (heat_no2 != string.Empty)
                {

                    string hn2 = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_HN", " WHERE MAT_ID =" + mat_id2);
                    if (hn2 == string.Empty)
                    {
                        rcbHeatNo2.Items.Insert(0, new RadComboBoxItem(heat_no2, heat_no2));
                        rcbHeatNo2.SelectedIndex = 0;
                        rcbHeatNo2.Enabled = false;

                    }
                    else
                    {
                        rcbHeatNo2.SelectedValue = heat_no2;
                        rcbHeatNo2.Enabled = false;
                    }
                }
            }

        }
    }
    protected void TWSave_Click(object sender, EventArgs e)
    {
        string bom1 = WebTools.GetExpr("ITEM_1", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + rcbTWJoint.SelectedValue.ToString());
        string bom2 = WebTools.GetExpr("ITEM_2", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + rcbTWJoint.SelectedValue.ToString());

        string mat_id1 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom1);
        string mat_id2 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom2);
        string item_id1 = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id1);
        string item_id2 = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id2);

        string item_group1 = WebTools.GetExpr("SG_GROUP", "PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id1);
        string item_group2 = WebTools.GetExpr("SG_GROUP", "PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id2);
        string hn1 = "";
        string hn2 = "";
        if (item_group1 == "SUPPORT")
        {
            hn1 = txtSuppHeatNo1.Text;
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
        }
        else
        {
            if (rcbHeatNo2.SelectedIndex < 0)
            {
                Master.ShowError("Selected Valid Heat No2");
                return;
            }
            hn2 = rcbHeatNo2.SelectedValue.ToString();
        }


        PIP_SPOOL_JOINTSTableAdapter joint_update = new PIP_SPOOL_JOINTSTableAdapter();
        joint_update.UpdateJointTW(txtTWRep.Text, DateTime.Parse(txTWDate.SelectedDate.ToString()), hn1, hn2, int.Parse(rcbTWJoint.SelectedValue));

        string sql_heat_no = "UPDATE PIP_BOM SET HEAT_NO = '" + hn1 + "' WHERE HEAT_NO IS NOT NULL AND  BOM_ID = " + bom1;
        WebTools.ExeSql(sql_heat_no);
        sql_heat_no = "UPDATE PIP_BOM SET HEAT_NO = '" + hn2 + "' WHERE HEAT_NO IS NOT NULL AND  BOM_ID = " + bom2;
        WebTools.ExeSql(sql_heat_no);
        Master.ShowSuccess("Tack Weld Details Updated Successfully");

    }



   
}