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
using System.Data.OracleClient;

public partial class WeldingInspec_DailyFitupEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Daily Welding Report";
            if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
            {
                btnSubmit.Enabled = false;
                return;
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string WPS_NO = string.Empty;
        if (WPS_NO_RadAutoCompleteBox.Entries.Count > 0)
        {
            WPS_NO = WPS_NO_RadAutoCompleteBox.Entries[0].Text.ToString();
        }

        string WELD_PROCESS = string.Empty;
        if (WeldProcess_RadAutoCompleteBox.Entries.Count > 0)
        {
            WELD_PROCESS = WeldProcess_RadAutoCompleteBox.Entries[0].Text.ToString();
        }

        string date_ = txtWeldDate.SelectedDate.Value.ToString("dd-MMM-yyyy");

        VIEW_SPOOL_WELDINGTableAdapter spool_welding = new VIEW_SPOOL_WELDINGTableAdapter();

        try
        {
            spool_welding.InsertQuery(decimal.Parse(cboJoints.SelectedValue.ToString()),
                ddReworkCode.SelectedItem.Text,
                txtReportNo.Text,
                txtWeldDate.SelectedDate,
                txtInsp.Text,
                decimal.Parse(ddWelder.SelectedValue.ToString()),
                decimal.Parse(ddWelderPass.SelectedValue.ToString()),
                WELD_PROCESS
                );

            if (WPS_NO_RadAutoCompleteBox.Enabled == true && WPS_NO.Length > 0)
            {
                WebTools.ExeSql("UPDATE PIP_SPOOL_JOINTS SET WPS_NO='" + WPS_NO + "' WHERE JOINT_ID=" + cboJoints.SelectedValue.ToString());
                WPS_NO_RadAutoCompleteBox.Enabled = false;
            }

            RadGrid1.DataBind();

            NotificationBox.show_success(cboJoints.SelectedItem.Text + " Welding Saved");
        }
        catch (Exception ex)
        {
            NotificationBox.show_error(ex.Message);
        }
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        txtIsome.Text = txtIsome.Text.Trim().ToUpper();
    }
    protected void cboJoints_DataBinding(object sender, EventArgs e)
    {
        cboJoints.Items.Clear();
        cboJoints.Items.Add(new ListItem("(Select Joint)", "-1"));
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void cboJoints_SelectedIndexChanged(object sender, EventArgs e)
    {
        WPS_NO_RadAutoCompleteBox.Enabled = true;
        WPS_NO_RadAutoCompleteBox.Entries.Clear();

        if (IsPostBack)
        {
            OracleConnection conn = WebTools.GetIpmsConnection();
            if (conn.State != ConnectionState.Open)
            {
                conn.Open();
            }

            OracleCommand cmd = new OracleCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = conn;

            
            cmd.CommandText = "SELECT * FROM PIP_SPOOL_JOINTS WHERE JOINT_ID=" + cboJoints.SelectedValue.ToString();
            using (OracleDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    txtReportNo.Text = dr["WELD_REP_NO"].ToString();
                    txtInsp.Text = dr["WELD_INSP"].ToString();

                    if (!string.IsNullOrEmpty(dr["WPS_NO"].ToString()))
                    {
                        string wps_no = dr["WPS_NO"].ToString();
                        WPS_NO_RadAutoCompleteBox.Entries.Add(new Telerik.Web.UI.AutoCompleteBoxEntry(wps_no, wps_no));
                    }

                    if (!string.IsNullOrEmpty(dr["WELD_DATE"].ToString()))
                    {
                        txtWeldDate.SelectedDate = DateTime.Parse(dr["WELD_DATE"].ToString());
                    }
                }
            }

            //Finally
            cmd.Dispose();
            conn.Close();
            conn.Dispose();
        }
    }

    protected void btnUpdateWelders_Click(object sender, EventArgs e)
    {
        //New
        OracleConnection conn = WebTools.GetIpmsConnection();
        if (conn.State != ConnectionState.Open)
        {
            conn.Open();
        }
        OracleCommand cmd = new OracleCommand();
        cmd.CommandType = CommandType.Text;
        cmd.Connection = conn;
        OracleCommand cmd2 = new OracleCommand();
        cmd2.CommandType = CommandType.Text;
        cmd2.Connection = conn;

        //Root & Hot
        cmd.CommandText = "SELECT * FROM VIEW_JOINT_WELDERS_UPDATE WHERE ROOT_HOT_WELDER_UPDATE='Y'";
        OracleDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            cmd2.CommandText =
                "UPDATE PIP_SPOOL_JOINTS SET ROOT_HOT_WELDER='" + dr["ROOT_HOT_WELDER_NEW"] + "' WHERE JOINT_ID=" + dr["JOINT_ID"];
            cmd2.ExecuteNonQuery();
        }

        //Fill & Cap
        cmd.CommandText = "SELECT * FROM VIEW_JOINT_WELDERS_UPDATE WHERE FILL_CAP_WELDER_UPDATE='Y'";
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            cmd2.CommandText =
                "UPDATE PIP_SPOOL_JOINTS SET FILL_CAP_WELDER='" + dr["FILL_CAP_WELDER_NEW"] + "' WHERE JOINT_ID=" + dr["JOINT_ID"];
            cmd2.ExecuteNonQuery();
        }

        //Finally
        cmd.Dispose();
        cmd2.Dispose();
        conn.Close();
        conn.Dispose();

        NotificationBox.show_success("Joint Welders Updated!");
    }

    protected void ddWelder_DataBinding(object sender, EventArgs e)
    {
        if(IsPostBack)
        {
            ddWelder.Items.Clear();
        }
    }
}