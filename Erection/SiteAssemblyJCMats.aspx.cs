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
using dsErectionTableAdapters;
using Telerik.Web.UI;

public partial class SiteAssemblyJCItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string issue_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ASSEMBLY", "JC_ID=" +
                Request.QueryString["JC_ID"]);
            Master.HeadingMessage = "Site Assembly Job Card (" + issue_no + ")";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SiteAssemblyJC.aspx");
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (itemsGridView.CurrentPageIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            GridDataItem item = (GridDataItem)itemsGridView.SelectedItems[0];
            //JC_ID,BOM_ID
            string jc_id = item.GetDataKeyValue("JC_ID").ToString();
            string bom_id = item.GetDataKeyValue("BOM_ID").ToString();

            dsErectionTableAdapters.VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter r = new VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter();
            r.DeleteQuery(decimal.Parse(jc_id), decimal.Parse(bom_id));
            Master.ShowMessage("Selected row deleted.");
            itemsGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //string ADD_SPL = InsertSpoolsCheckBox.Checked == true ? "Y" : "N";
        //if (ddEntryType.SelectedValue.ToString() == "1")
        //{
        //    try
        //    {
        //        string RET_CODE = WebTools.GetExpr(
        //            "FNC_SITE_JC_SAVE_ALL(" +
        //                Request.QueryString["JC_ID"] + ",'" + txtIsome.Text +
        //                "','" + ddSheetNo.SelectedValue.ToString() + "','" +
        //                ADD_SPL + "','" + ddAvailable.SelectedValue.ToString() + "')", "DUAL", "");
        //        itemsGridView.DataBind();
        //        Master.ShowMessage("Saved!");
        //    }
        //    catch (Exception ex)
        //    {
        //        Master.ShowWarn(ex.Message);
        //    }
        //    return;
        //}
        VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter loose = new VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter();
        try
        {
            foreach (RadComboBoxItem item in cboBOM.Items)
            {
                if (item.Checked)
                {
                    string MAT_ID = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID='" + item.Value.ToString() + "'");
                    //string ISO_ID = WebTools.GetExpr("ISO_ID", "VIEW_SITE_ASSEMBLY_REQUIRED", " WHERE BOM_ID='" + item.Value.ToString() + "'");
                    
                    string net_qty = WebTools.GetExpr("NET_QTY", "PIP_MAT_ISSUE_ASSEMBLY_JOINT", " WHERE JC_ID='" + Request.QueryString["JC_ID"] + "'");

                    loose.InsertQuery(Decimal.Parse(Request.QueryString["JC_ID"]),
                        Decimal.Parse(item.Value.ToString()),
                        Decimal.Parse(net_qty), txtRemarks.Text);                   
                }
            }
            Master.ShowMessage("Saved.");
            loose.Dispose();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
            loose.Dispose();
        }
    }
    protected void cboMM_SELECTedIndexChanged(object sender, EventArgs e)
    {
        //if (cboBOM.SelectedValue.ToString() != "-1")
        //{
        //    string net_qty = WebTools.GetExpr("NET_QTY", "PIP_BOM", " WHERE BOM_ID=" +
        //        cboBOM.SelectedValue.ToString());
        //    //txtIssuedQty.Text = net_qty;
        //}
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (EntryTable.Visible == false)
        {
            EntryTable.Visible = true;
            btnSubmit.Visible = true;
            //Enable_Controls();
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
    protected void ddEntryType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Enable_Controls();
    }
    //private void Enable_Controls()
    //{
    //    if (ddEntryType.SelectedValue.ToString() == "1")
    //    {
    //        cboBOM.Enabled = false;
    //        itemValidator.Enabled = false;
    //        txtIssuedQty.Enabled = false;
    //        issuedQtyValidator.Enabled = false;
    //    }
    //    else
    //    {
    //        cboBOM.Enabled = true;
    //        itemValidator.Enabled = true;
    //        txtIssuedQty.Enabled = true;
    //        issuedQtyValidator.Enabled = true;
    //    }
    //}
    protected void ddSheetNo_DataBinding(object sender, EventArgs e)
    {
        //ddSheetNo.Items.Clear();
        //ddSheetNo.Items.Add(new ListItem("ALL", "ALL"));
    }

    protected void cboBOM_DataBinding(object sender, EventArgs e)
    {

    }
}