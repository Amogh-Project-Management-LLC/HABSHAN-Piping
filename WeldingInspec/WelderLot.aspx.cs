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
using dsWeldersTableAdapters;

public partial class WeldingInspec_WelderLot : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Welder Lots";
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

    private void NextLotNo()
    {
        if (ddWelderNos.SelectedValue.ToString() == "-1")
        {
            txtLotNo.Text = string.Empty;
            return;
        }
        string LOT_NO = Convert.ToString(
            WebTools.DMax("LOT_NO", "PIP_WELDER_LOT", " WHERE WELDER_ID=" + ddWelderNos.SelectedValue.ToString()) + 1);
        txtLotNo.Text = LOT_NO;
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
        VIEW_WELDER_LOTTableAdapter items = new VIEW_WELDER_LOTTableAdapter();
        try
        {
            items.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(ddWelderNos.SelectedValue.ToString()),
                decimal.Parse(txtLotNo.Text),
                string.Empty);
            welderGridView.DataBind();
            Master.ShowMessage("Saved!");
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
    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (welderGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select a Lot No!");
            return;
        }
        Response.Redirect("WelderLotJoints.aspx?LOT_ID=" + welderGridView.SelectedValue.ToString());
    }
    protected void ddWelderNos_DataBinding(object sender, EventArgs e)
    {
        ddWelderNos.Items.Clear();
        ddWelderNos.Items.Add(new ListItem("Welder", "-1"));
    }
    protected void ddWelderNos_SelectedIndexChanged(object sender, EventArgs e)
    {
        NextLotNo();
    }
}