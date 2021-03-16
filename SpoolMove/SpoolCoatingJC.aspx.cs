using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolCoatingJC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Coating Job Card";
            Master.AddModalPopup("~/SpoolMove/SpoolCoatingJCNew.aspx", btnNew.ClientID, 450, 500);
            Master.AddModalPopup("~/SpoolMove/SpoolCoatingTypes.aspx", btnCoatingType.ClientID, 450, 500);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnSpools_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Job Card to Continue.");
            return;
        }
        Response.Redirect("SpoolCoatingJCDetail.aspx?JC_ID=" + itemsGrid.SelectedValue);
    }

    protected void ddlCoatingTypeList_DataBinding(object sender, EventArgs e)
    {
        ddlCoatingTypeList.Items.Clear();
        ddlCoatingTypeList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Coating Type Request)", "-1"));
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select Job Card to Continue.");
            return;
        }
        if (ddlReportType.SelectedValue == "53")
        {
            string coating_no = WebTools.GetExpr("COAT_JC_NO", "PIP_COATING_JC", " WHERE JC_ID = '" + itemsGrid.SelectedValue + "'");
            string doc_id = WebTools.GetExpr("TRANS_ID", "PIP_SPL_TRANSFER_DOC", " WHERE DOC_REF_NO='" + coating_no + "'");
            if (doc_id.Length == 0)
            {
                Master.ShowError("No Transfer Request Found for Job Card No " + coating_no + ".");
                return;
            }
            Response.Redirect("ReportViewer.aspx?ReportID=3.1&Arg1=" + doc_id);
        }
        Response.Redirect("ReportViewer.aspx?ReportID=" + ddlReportType.SelectedValue + "&Arg1=" + itemsGrid.SelectedValue);
    }

    protected void btnUpdateTransfer_Click(object sender, EventArgs e)
    {
        if(itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Please Select a Job Card to Continue.");
            return;
        }
        Response.Redirect("SpoolCoatingJCTrans.aspx?JC_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=28&RetUrl=~/SpoolMove/SpoolCoatingJC.aspx");
    }
}