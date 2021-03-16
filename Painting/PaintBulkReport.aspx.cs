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
using dsPaintingRepsTableAdapters;

public partial class Painting_PaintBulkReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Paint Reports";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaintingHome.aspx");
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
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the row!");
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
            //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            //Master.ShowMessage("Selected row deleted.");
            //itemsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADP_PAINTING_REPORTTableAdapter items = new VIEW_ADP_PAINTING_REPORTTableAdapter();
        try
        {
            items.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtPaintRepNo.Text,
                DateTime.Parse(txtPaintDate.SelectedDate.ToString()),
                Decimal.Parse(ddJobcardNo.SelectedValue.ToString()),
                ddPaintCode.SelectedItem.Text,
                Decimal.Parse(ddCoatLayer.SelectedValue.ToString()),
                Decimal.Parse(ddItemCode.SelectedValue.ToString()),
                Decimal.Parse(txtPaintQty.Text),
                txtPaintArea.Text);

            itemsGridView.DataBind();
            Master.ShowMessage("Saved.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            items.Dispose();
        }
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
        }
        else
        {
            EntryTable.Visible = false;
            btnSubmit.Visible = false;
        }
    }
    protected void ddJobcardNo_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddItemCode_DataBinding(object sender, EventArgs e)
    {
        ddItemCode.Items.Clear();
        ddItemCode.Items.Add(new ListItem("<Item Code>", "-1"));
    }
    protected void ddPaintCode_DataBinding(object sender, EventArgs e)
    {
        ddPaintCode.Items.Clear();
        ddPaintCode.Items.Add(new ListItem("<Paint Code>", "-1"));
    }
}