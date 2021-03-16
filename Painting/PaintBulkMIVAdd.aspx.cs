using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Painting_PaintBulkMIVAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("REGISTER MIV FOR BULK PAINTNG");
            txtIssueDate.SelectedDate = System.DateTime.Now;
            txtIssueBy.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void ddlSubContractor_DataBinding(object sender, EventArgs e)
    {
        ddlSubContractor.Items.Clear();
        ddlSubContractor.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlSubContractor_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID='" + ddlSubContractor.SelectedValue + "'");
        prefix += "-";
        prefix += "PAINT-MIV-";

        txtIssueNo.Text = WebTools.NextSerialNo("PIP_MAT_ISSUE_BULK", "ISSUE_NO", prefix,4, " WHERE SC_ID = '" + ddlSubContractor.SelectedValue + "'");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtAutoBulkPaint.Entries.Count == 0)
        {
            Master.show_info("Select Bulk Paint Request to Continue.");
            return;
        }

        dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUETableAdapter miv = new dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUETableAdapter();        
        try
        {
            string jc_id = WebTools.GetExpr("PAINT_ID", "PIP_PAINTING_MAT", " WHERE PAINT_REQ_NO='" + txtAutoBulkPaint.Entries[0].Text + "'");
            if (string.IsNullOrEmpty(jc_id))
            {
                Master.show_error("Invalid Bulk Paint Request Number. Please Enter Valid Request Number.");
                return;
            }
            miv.InsertQuery(txtIssueNo.Text, txtIssueDate.SelectedDate, txtIssueBy.Text, decimal.Parse(ddlSubContractor.SelectedValue), decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(ddlStoreList.SelectedValue), decimal.Parse(jc_id), txtRemarks.Text);

            Master.show_success(txtIssueNo.Text + " Added Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}