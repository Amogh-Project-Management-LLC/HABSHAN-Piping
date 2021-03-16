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
using dsWeldingATableAdapters;
using Telerik.Web.UI;

public partial class Welding_PipingDWR_Popup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage(WebTools.GetExpr("ISO_TITLE1 || ' * ' || JOINT_TITLE", "VIEW_JOINT_TITLE", "JOINT_ID=" + Request.QueryString["JOINT_ID"].ToString()));

            string joint_size = WebTools.GetExpr("JOINT_SIZE_DEC", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"].ToString());
            string joint_thk = WebTools.GetExpr("JOINT_THK", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"].ToString());
            string joint_wps= WebTools.GetExpr("WPS_NO", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"].ToString());
            string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"].ToString());
            string subcon = WebTools.GetExpr("FAB_SC", "PIP_SPOOL", " WHERE SPL_ID=" + spl_id);

            txtJoint_size.Text = joint_size;
            txtJoint_thk.Text = joint_thk;
            txtWPS_ID.Text = joint_wps;
            txtSC_ID.Text = subcon;

        }
    }

    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Update")
        {
            try
            {
                GridDataItem item = e.Item as GridDataItem;

                string JOINT_ID, WELDER_ID, PASS_ID, new_welder_id;
                object REWORK_CODE;

                JOINT_ID = item.GetDataKeyValue("JOINT_ID").ToString();
                REWORK_CODE = item.GetDataKeyValue("REWORK_CODE");
                WELDER_ID = item.GetDataKeyValue("WELDER_ID").ToString();
                PASS_ID = item.GetDataKeyValue("PASS_ID").ToString();

                new_welder_id = (item["WELDER_NO"].FindControl("ddlWelderEdit") as RadDropDownList).SelectedValue;

                string sql = "UPDATE PIP_SPOOL_WELDING SET WELDER_ID = '" + new_welder_id + "'";
                sql += " WHERE JOINT_ID = " + JOINT_ID + " AND REPAIR_CODE = '" + REWORK_CODE + "'";
                sql += " AND WELDER_ID = '" + WELDER_ID + "' AND PASS_ID = '" + PASS_ID + "'";
                WebTools.ExecNonQuery(sql);
                Master.show_success("Updated.");
            }
            catch (Exception ex)
            {
                Master.show_error(ex.Message);
            }
            finally {
                RadGrid1.Rebind();
            }
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
       
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            if (!WebTools.UserInRole("WELDER_ADMIN") && !WebTools.UserInRole("ADMIN"))
            {
                ImageButton btnEdit = (ImageButton)dataItem["EditCommandColumn"].Controls[0];
                btnEdit.Visible = false;
                ImageButton btnDelete = (ImageButton)dataItem["DeleteColumn"].Controls[0];
                btnDelete.Visible = false;

            }
        }
    }


    protected void btnAddWelderAll_Click(object sender, EventArgs e)
    {
        try
        {
            //weldersListBox.Items.Clear();
            if (ddlWelder.SelectedValue.ToString() == "-1")
            {
                Master.show_error("Select a welder !");
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
            Master.show_error("Select a welder !");
            return;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlWelder.SelectedValue.ToString() == "-1")
            {
                Master.show_error("Select the weld!");
                return;
            }
            if (ddlWelderPass.SelectedValue.ToString() == "-1")
            {
                Master.show_error("Select the welder category!");
                return;
            }
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + ddlWelderPass.SelectedItem.Text,
                ddlWelder.SelectedItem.Value.ToString() + "-" + ddlWelderPass.SelectedValue.ToString()));
        }

        catch (Exception ex)
        {
            Master.show_error("Select a welder !");
            return;
        }
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        try
        {
            if (weldersListBox.SelectedIndex == -1)
            {
                Master.show_error("Select the weld!");
                return;
            }
            weldersListBox.Items.Remove(weldersListBox.Items[weldersListBox.SelectedIndex]);
        }

        catch (Exception ex)
        {
            Master.show_error("Select a row from the box !");
            return;
        }
    }

    protected void btnRemoveAll_Click(object sender, EventArgs e)
    {
        weldersListBox.Items.Clear();
    }


    protected void WeldSave_Click(object sender, EventArgs e)
    {
        string welder = string.Empty;
        string joint_id = Request.QueryString["JOINT_ID"].ToString();
        if (weldersListBox.Items.Count <= 0)
        {
            Master.show_error("Select Welder");
            return;
        }
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
            SpoolWeldingObjectDataSource.DataBind();
            Master.show_success("Welders Updated");

        }
    }
}