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

public partial class WeldingInspec_PenaltyJointsRegist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sc_id = WebTools.GetExpr("SUB_CON_ID", "VIEW_ADAPTER_JOINTS", " WHERE JOINT_ID=" +
                Request.QueryString["JOINT_ID"]);
            SC_ID_Field.Value = sc_id;
            P1_Field.Value = WebTools.GetExpr("PENALTY_JNT1", "PIP_NDE_REQUEST_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"] +
                " AND NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
            P2_Field.Value = WebTools.GetExpr("PENALTY_JNT2", "PIP_NDE_REQUEST_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"] +
                " AND NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
            if (P1_Field.Value.ToString() != "") txtIsome1.Text = WebTools.GetExpr("ISO_TITLE1", "VIEW_JOINTS_SIMPLE", " WHERE JOINT_ID=" + P1_Field.Value.ToString());
            if (P2_Field.Value.ToString() != "") txtIsome2.Text = WebTools.GetExpr("ISO_TITLE1", "VIEW_JOINTS_SIMPLE", " WHERE JOINT_ID=" + P2_Field.Value.ToString());
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        back();
    }
    private void back()
    {
        Response.Redirect("NDE_Status.aspx?pg_index=" + Request.QueryString["pg_index"]);
    }
    protected void txtIsome1_TextChanged(object sender, EventArgs e)
    {
        cboJoint1.Items.Clear();
        cboJoint1.Items.Add(new ListItem("UNSET", "-1"));
    }
    protected void txtIsome2_TextChanged(object sender, EventArgs e)
    {
        cboJoint2.Items.Clear();
        cboJoint2.Items.Add(new ListItem("UNSET", "-1"));
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql = "UPDATE PIP_NDE_REQUEST_JOINTS SET";
        if (P1_Field.Value.ToString() != "" && cboJoint1.SelectedValue.ToString() == "-1")
            General_Functions.ExeSql("UPDATE PIP_SPOOL_JOINTS SET TRACER=NULL WHERE JOINT_ID=" + P1_Field.Value.ToString());
        if (P2_Field.Value.ToString() != "" && cboJoint2.SelectedValue.ToString() == "-1")
            General_Functions.ExeSql("UPDATE PIP_SPOOL_JOINTS SET TRACER=NULL WHERE JOINT_ID=" + P2_Field.Value.ToString());

        if (cboJoint1.SelectedValue.ToString() != "-1")
        { sql += " PENALTY_JNT1=" + cboJoint1.SelectedValue.ToString() + ","; }
        else
        { sql += " PENALTY_JNT1=NULL,"; }

        if (cboJoint2.SelectedValue.ToString() != "-1")
        { sql += " PENALTY_JNT2=" + cboJoint2.SelectedValue.ToString() + ","; }
        else
        { sql += " PENALTY_JNT2=NULL,"; }
        if (sql.EndsWith(","))
        {
            try
            {
                sql = sql.Substring(0, sql.Length - 1);
                sql += " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"] +
                    " AND NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"];
                General_Functions.ExeSql(sql);
                if (cboJoint1.SelectedValue.ToString() == "-1")
                    General_Functions.ExeSql("UPDATE PIP_SPOOL_JOINTS SET TRACER='P1' WHERE JOINT_ID=" + cboJoint1.SelectedValue.ToString());
                if (cboJoint2.SelectedValue.ToString() == "-1")
                    General_Functions.ExeSql("UPDATE PIP_SPOOL_JOINTS SET TRACER='P2' WHERE JOINT_ID=" + cboJoint2.SelectedValue.ToString());
                back();
            }
            catch (Exception ex)
            {
                Master.ShowWarn(ex.Message);
            }
        }
    }
    protected void cboJoint1_DataBound(object sender, EventArgs e)
    {
        if (P1_Field.Value.ToString() == "") return;
        for (int i = 0; i < cboJoint1.Items.Count; i++)
        {
            if (cboJoint1.Items[i].Value.ToString() == P1_Field.Value.ToString())
            {
                cboJoint1.SelectedIndex = i;
                break;
            }
        }
    }
    protected void cboJoint2_DataBound(object sender, EventArgs e)
    {
        if (P2_Field.Value.ToString() == "") return;
        for (int i = 0; i < cboJoint2.Items.Count; i++)
        {
            if (cboJoint2.Items[i].Value.ToString() == P2_Field.Value.ToString())
            {
                cboJoint2.SelectedIndex = i;
                break;
            }
        }
    }
}