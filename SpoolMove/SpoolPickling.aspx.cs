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
using Microsoft.Reporting.WebForms;
using Ionic.Zip;
using System.IO;
using dsSpoolMoveTableAdapters;
using dsSpoolReportsATableAdapters;
using dsWeldingReportsBTableAdapters;
using dsSpoolReportsCTableAdapters;

public partial class SpoolMove_SpoolPaint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Pickling";
            Master.AddModalPopup("~/SpoolMove/SpoolPicklingNew.aspx", btnNewTrans.ClientID, 550, 650);
            Master.RadGridList = TransGridView.ClientID;
        }
    }
    protected void btnNewTrans_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolPicklingNew.aspx");
    }
    protected void btnViewSpls_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the Pickling request no!");
            return;
        }
        Response.Redirect("SpoolPicklingItems.aspx?SPL_PICKLING_ID=" + TransGridView.SelectedValue.ToString());
    }
    protected void TransGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < TransGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", TransGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == TransGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TransGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("SPL_DELETE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            return;
        }
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the transmittal.");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Proceed delete the transmittal?");
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //TransGridView.DeleteRow(TransGridView.SelectedIndex);
            //Master.ShowMessage("Transmittal deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void TransGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("SPL_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (TransGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Selected the Pickling Request number!");
            return;
        }

        Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() + "&Arg1=" +
             TransGridView.SelectedValue.ToString());
    }
    
   
    protected void ReportPreview_SubreportProcessing(Object sender, SubreportProcessingEventArgs e)
    {
        PIP_JOINT_REVTableAdapter jnt_rev = new PIP_JOINT_REVTableAdapter();
        e.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
            "dsWeldingReportsB_PIP_JOINT_REV",
            (DataTable)jnt_rev.GetData()));
    }



    protected void btnRepImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=20&RetUrl=~/SpoolMove/SpoolPickling.aspx");
    }
}