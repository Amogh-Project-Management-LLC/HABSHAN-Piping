using dsGalvJobcardTableAdapters;
using System;

public partial class SpoolMove_GalvJobcardNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Galvanising Jobcard";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("GalvJobcard.aspx");
    }

    protected void cboSubcon_DataBound(object sender, EventArgs e)
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_GALV_JCTableAdapter trans = new VIEW_GALV_JCTableAdapter();
        try
        {
            trans.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtSerialNo.Text,
                txtCreateDate.SelectedDate,
                Decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtRemarks.Text);
            Master.ShowMessage(txtSerialNo.Text + " Saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            trans.Dispose();
        }
    }

    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        set_req_no();
    }

    private void set_req_no()
    {
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
            cboSubcon.SelectedValue.ToString());
        txtSerialNo.Text = General_Functions.NextSerialNo("PIP_GALV_JC", "GALV_JC_NO", "GALV-JC-" + sc_name + "-",
            4, " WHERE PROJECT_ID=" + Session["PROJECT_ID"] + " AND SC_ID=" + cboSubcon.SelectedValue.ToString());
    }
}