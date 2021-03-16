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

public partial class Material_MatExceptionRep : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["ESD_FILTER"] != null)
                txtSearch.Text = Session["ESD_FILTER"].ToString();
            Master.HeadingMessage = "ESD Report";
        }
    }
    protected void btnNewReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatExceptionRepNew.aspx");
    }
    protected void btnViewItems_Click(object sender, EventArgs e)
    {
        if (ReportsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the report number!");
            return;
        }
        Response.Redirect("MatExceptionRepItems.aspx?EXCP_ID=" + ReportsGridView.SelectedValue.ToString());
    }

    //protected void btnAddItems_Click(object sender, EventArgs e)
    //{
    //    if (!WebTools.UserInRole("MM_INSERT"))
    //    {
    //        Master.ShowWarn("Access Denied.");
    //        return;
    //    }
    //    if (ReportsGridView.SelectedIndex < 0)
    //    {
    //        Master.ShowMessage("Select the report number!");
    //        return;
    //    }
    //    Response.Redirect("MatExceptionRepNewItem.aspx?EXCP_ID=" + ReportsGridView.SelectedValue.ToString());
    //}

    protected void ReportsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }

    protected void ReportsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied.");
            e.Cancel = true;
        }
    }

    protected void ReportsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied.");
            e.Cancel = true;
        }
        if (Session["CONNECT_AS"].ToString() != "99")
        {

        }
        else
        {

        }
    }
    protected void ReportsGridView_DataBound(object sender, EventArgs e)
    {
    }

    protected void ReportsGridView_EditCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied.");
            e.Canceled = true;

        }
        if (Session["CONNECT_AS"].ToString() != "99")
        {

        }
        else
        {

        }
        string sub_con_id = WebTools.GetExpr("SC_ID", "PIP_MAT_EXCEPTION_REP", "EXCP_ID="+ ReportsGridView.SelectedValue.ToString());
        hiddenScID.Value = sub_con_id;
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (ReportsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the report number.");
            return;
        }
        Response.Redirect("~/Material/ReportViewer.aspx?ReportID=34&Arg1=" + ReportsGridView.SelectedValue);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
        Session["ESD_FILTER"] = txtSearch.Text;
    }
}