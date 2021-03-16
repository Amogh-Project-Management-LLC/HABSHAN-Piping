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
using dsWeldingBTableAdapters;

public partial class WeldingInspec_WPS_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "WPS Register";
        }
    }
    protected void cboSubcon_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string conn_as = Session["CONNECT_AS"].ToString();
            if (conn_as != "99")
            {
                for (int i = 0; i <= cboSubcon.Items.Count; i++)
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
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_WPS_NOTableAdapter wps = new PIP_WPS_NOTableAdapter();
        string wps_id = string.Empty;
        string sql = string.Empty;
        try
        {
            wps.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtWPS1.Text, txtWPS2.Text, txtRevision.Text, cboMatList.SelectedValue, cboProcessList.SelectedValue, radPWHTList.SelectedValue,
                decimal.Parse(txtSizeFrom.Text), decimal.Parse(txtSizeTo.Text), decimal.Parse(txtThkFrom.Text),
                decimal.Parse(txtThkTo.Text), cboConnA.SelectedValue.ToString(), cboConnB.SelectedValue.ToString(),
                "", txtRemarks.Text, AllsubconRadioButton.SelectedValue);

            wps_id = WebTools.GetExpr("WPS_ID", "PIP_WPS_NO", " WHERE WPS_NO1 = '" + txtWPS1.Text + "'");
            for (int i = 0; i < cboPipeClass.Items.Count; i++)
            {
                if (cboPipeClass.Items[i].Checked)
                {
                    sql = "INSERT INTO PIP_WPS_SPEC (WPS_ID, CLASS) VALUES ('" + wps_id + "', '" + cboPipeClass.Items[i].Text+ "')";
                    WebTools.ExeSql(sql);
                }
            }

            Master.ShowMessage("WPS Created successfully!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("WPS_Numbers.aspx");
    }
}