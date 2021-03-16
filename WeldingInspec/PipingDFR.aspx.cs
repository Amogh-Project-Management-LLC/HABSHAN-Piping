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


public partial class WeldingInspec_DailyFitupEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Daily Fitup Report";

        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            NotificationBox.show_error("Access Denied!");
            btnSubmit.Enabled = false;
            return;
        }

        if (!IsPostBack)
        {
            unqPartField.Value = WebTools.GetExpr("NVL(UNIQUE_PART,'N')", "PROJECT_SETTING", "PROJECT_ID=" + Session["PROJECT_ID"].ToString());
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string joint_id = cboJoints.SelectedValue.ToString();
        string date_ = "TO_DATE('" + txtFitupDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "')";
        string rep_no = "'" + txtReportNo.Text + "'";

        string insp = "'" + txtInsp.Text + "'";
        string sql;

        try
        {
            sql = "UPDATE PIP_SPOOL_JOINTS SET FITUP_DATE=" + date_ + ",FITUP_REP_NO=" + rep_no +
                ",FITUP_INSP=" + insp;
            sql += (" WHERE JOINT_ID=" + joint_id);
            WebTools.ExeSql(sql);

            if (ddHeatNo1.SelectedValue.ToString().Length > 0 && ddHeatNo1.Enabled == true)
            {
                if (unqPartField.Value.ToString() == "Y")
                {
                    WebTools.ExeSql("UPDATE PIP_BOM SET HEAT_NO='" + ddHeatNo1.SelectedValue.ToString() + "' WHERE BOM_ID=" + bomId1Field.Value.ToString());
                }
                else
                {
                    WebTools.ExeSql("UPDATE PIP_SPOOL_JOINTS SET HEAT_NO1='" + ddHeatNo1.SelectedValue.ToString() + "' WHERE JOINT_ID=" + joint_id);
                }
            }
            if (ddHeatNo2.SelectedValue.ToString().Length > 0 && ddHeatNo2.Enabled == true)
            {
                if (unqPartField.Value.ToString() == "Y")
                {
                    WebTools.ExeSql("UPDATE PIP_BOM SET HEAT_NO='" + ddHeatNo2.SelectedValue.ToString() + "' WHERE BOM_ID=" + bomId2Field.Value.ToString());
                }
                else
                {
                    WebTools.ExeSql("UPDATE PIP_SPOOL_JOINTS SET HEAT_NO2='" + ddHeatNo2.SelectedValue.ToString() + "' WHERE JOINT_ID=" + joint_id);
                }
            }
            jointDetailsView.DataBind();

            NotificationBox.show_success(cboJoints.SelectedItem.Text + " fitup saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void cboJoints_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            IsoIdField.Value = WebTools.GetExpr("ISO_ID", "PIP_SPOOL_JOINTS", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            matId1Field.Value = WebTools.GetExpr("MAT_ID1", "VIEW_JOINT_ITEM", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            matId2Field.Value = WebTools.GetExpr("MAT_ID2", "VIEW_JOINT_ITEM", "JOINT_ID=" + cboJoints.SelectedValue.ToString());

            bomId1Field.Value = WebTools.GetExpr("ITEM_1", "VIEW_JOINT_ITEM", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            bomId2Field.Value = WebTools.GetExpr("ITEM_2", "VIEW_JOINT_ITEM", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            ddHeatNo1.Enabled = true;
            ddHeatNo2.Enabled = true;
            ddHeatNo1.DataBind();
            ddHeatNo2.DataBind();
        }
    }

    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
        ddHeatNo1.Enabled = true;
        ddHeatNo2.Enabled = true;
    }

    protected void ddHeatNo1_DataBound(object sender, EventArgs e)
    {
        string heat_no1 = string.Empty;

        if (unqPartField.Value.ToString() == "N")
        {
            heat_no1 = WebTools.GetExpr("HEAT_NO1", "PIP_SPOOL_JOINTS", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            return;
        }
        if (bomId1Field.Value.ToString().Length > 0)
        {
            heat_no1 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", "BOM_ID=" + bomId1Field.Value.ToString());
            if (heat_no1.Trim().Length == 0) return;
            for (int i = 0; i < ddHeatNo1.Items.Count; i++)
            {
                if (ddHeatNo1.Items[i].Value.ToString() == heat_no1)
                {
                    ddHeatNo1.SelectedIndex = i;
                    ddHeatNo1.Enabled = false;
                    break;
                }
            }
        }
    }
    protected void ddHeatNo2_DataBound(object sender, EventArgs e)
    {
        string heat_no2 = string.Empty;

        if (unqPartField.Value.ToString() == "N")
        {
            heat_no2 = WebTools.GetExpr("HEAT_NO2", "PIP_SPOOL_JOINTS", "JOINT_ID=" + cboJoints.SelectedValue.ToString());
            return;
        }
        if (bomId2Field.Value.ToString().Length > 0)
        {
            heat_no2 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", "BOM_ID=" + bomId2Field.Value.ToString());
            if (heat_no2.Trim().Length == 0) return;
            for (int i = 0; i < ddHeatNo2.Items.Count; i++)
            {
                if (ddHeatNo2.Items[i].Value.ToString() == heat_no2)
                {
                    ddHeatNo2.SelectedIndex = i;
                    ddHeatNo2.Enabled = false;
                    break;
                }
            }
        }
    }
    protected void cboJoints_DataBinding(object sender, EventArgs e)
    {
        cboJoints.Items.Clear();
        cboJoints.Items.Add(new ListItem("(Select Joint)", "-1"));
    }
    protected void ddHeatNo2_DataBinding(object sender, EventArgs e)
    {
        ddHeatNo2.Items.Clear();
        ddHeatNo2.Items.Add(new ListItem("", ""));
    }
    protected void ddHeatNo1_DataBinding(object sender, EventArgs e)
    {
        ddHeatNo1.Items.Clear();
        ddHeatNo1.Items.Add(new ListItem("", ""));
    }
}