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
using dsPaintingMatTableAdapters;

public partial class Painting_PaintBulkRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Paint Request");

            txtCreateDate.SelectedDate = System.DateTime.Now;
            txtTargetDate.SelectedDate = System.DateTime.Now.AddDays(7);
            txtIssueBy.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_PAINTING_MATTableAdapter issue = new VIEW_PAINTING_MATTableAdapter();
        try
        {
            issue.InsertQuery(
                Decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtIssueNumber.Text,
                txtCreateDate.SelectedDate.Value,
                decimal.Parse(cboToSubcon.SelectedValue.ToString()),
                txtRemarks.Text,
                null,
                ddScope.SelectedItem.Value.ToString(),
                decimal.Parse(cboSubcon.SelectedValue.ToString()),
                txtIssueBy.Text, txtTargetDate.SelectedDate.Value
                );
            
            Master.show_success(txtIssueNumber.Text + " Saved.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaintBulk.aspx");
    }
    protected void cboSubcon_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cboSubcon.SelectedValue.ToString() == "-1") return;
        set_paint_no();
    }
    private void set_paint_no()
    {
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID=" +
            cboSubcon.SelectedValue.ToString());
        string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());
        try
        {
            string prefix = job_code + "-" + sc_name + "-BULK-PAINT-";
            txtIssueNumber.Text = General_Functions.NextSerialNo(
                "PIP_PAINTING_MAT", "PAINT_REQ_NO", prefix,
                4, " WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString() +
                " AND TO_SC=" + cboSubcon.SelectedValue.ToString());
        }
        catch
        {
            txtIssueNumber.Text = string.Empty;
        }
    }

    protected void ddlPaintCode_DataBinding(object sender, EventArgs e)
    {
        //ddlPaintCode.Items.Clear();
        //ddlPaintCode.Items.Add(new ListItem("(Select)", ""));
    }
}