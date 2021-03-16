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
using dsErectionATableAdapters;

public partial class Erection_RemainWorkPunch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Remaining Work";
        }
    }
    protected void welderGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Response.Redirect("~/ErrorPages/NoAccess.htm");
            e.Cancel = true;
        }
    }
    protected void welderGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < welderGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", welderGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == welderGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        welderGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            //welderGridView.DeleteRow(welderGridView.SelectedIndex);
            //welderGridView.SelectedIndex = -1;
            //Master.ShowMessage("welder deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (welderGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the entire welder!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("Proceed delete the welder?");
    }

    protected void btnNew_Click(object sender, EventArgs e)
    {
        if (EntryTable.Visible == false)
        {
            EntryTable.Visible = true;
            btnSave.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnSave.Visible = false;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string SQL = "INSERT INTO SITE_REMAINING_WORK(PROJECT_ID, JC_ID, SUB_CON_ID, ISO_ID, SHEET, PUNCH_CODE,";
        SQL += "ITEM_DESC, PUNCH_CAT, BOM_ID, SPOOL, REMARKS) VALUES(" + Session["PROJECT_ID"].ToString();

        SQL += "," + ddJC_NO.SelectedValue.ToString() + "," + ddSubcon.SelectedValue.ToString();
        SQL += "," + cboIsome.SelectedValue.ToString();
        SQL += ",'" + ddSheetNo.SelectedValue.ToString() + "'";
        SQL += ",'" + ddPunchCode.SelectedItem.Text + "'";
        SQL += ",'" + txtDesc.Text + "'";
        SQL += ",'" + ddPunchCat.SelectedValue.ToString() + "'";
        SQL += "," + (cboBOM.SelectedValue.ToString() != "-1" ? cboBOM.SelectedValue.ToString() : "NULL");
        SQL += ",'" + ddSpool.SelectedValue.ToString() + "'";
        SQL += ",'" + txtRemarks.Text + "'";
        SQL += ")";

        try
        {
            WebTools.ExecNonQuery(SQL);
            welderGridView.DataBind();
            Master.ShowMessage("Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ErectionHome.aspx");
    }
    protected void ddSheetNo_DataBinding(object sender, EventArgs e)
    {
        ddSheetNo.Items.Clear();
        ddSheetNo.Items.Add(new ListItem("Sheet", "-1"));
    }
    protected void ddJC_NO_DataBinding(object sender, EventArgs e)
    {
        ddJC_NO.Items.Clear();
        ddJC_NO.Items.Add(new ListItem("JC No", "-1"));
    }
    protected void ddSubcon_DataBinding(object sender, EventArgs e)
    {
        ddSubcon.Items.Clear();
        ddSubcon.Items.Add(new ListItem("Subcon", "-1"));
    }
    protected void txtIsomeFilter_TextChanged(object sender, EventArgs e)
    {

    }
    protected void cboIsome_DataBinding(object sender, EventArgs e)
    {
        cboIsome.Items.Clear();
        cboIsome.Items.Add(new ListItem("Isometric", "-1"));
    }
    protected void cboMM_SELECTedIndexChanged(object sender, EventArgs e)
    {
        if (cboBOM.SelectedValue.ToString() != "-1")
        {
            string net_qty = WebTools.GetExpr("NET_QTY", "PIP_BOM", " WHERE BOM_ID=" +
                cboBOM.SelectedValue.ToString());
            //txtIssuedQty.Text = net_qty;
        }
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void ddPunchCode_DataBinding(object sender, EventArgs e)
    {
        ddPunchCode.Items.Clear();
        ddPunchCode.Items.Add(new ListItem("Punch Code", "-1"));
    }
    protected void ddPunchCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtDesc.Text = ddPunchCode.SelectedValue.ToString();
    }
    protected void ddSpool_DataBinding(object sender, EventArgs e)
    {
        ddSpool.Items.Clear();
        ddSpool.Items.Add(new ListItem("Spool", "-1"));
    }
}