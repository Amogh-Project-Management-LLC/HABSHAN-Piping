using System;
using System.Web.UI.WebControls;

public partial class HeatNo_HeatNoIndex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Heat Numbers";

            string heat_no = Session["HN_FILTER"].ToString();

            if (heat_no != "")
            {
                txtFilter.Text = heat_no;
            }
        }
    }
    protected void HeatNoGridView_DataBound(object sender, EventArgs e)
    {
        //set the pager
        PageList.Items.Clear();
        for (int i = 0; i < HeatNoGridView.PageCount; i++)
        {
            Telerik.Web.UI.DropDownListItem pageListItem =
                new Telerik.Web.UI.DropDownListItem(String.Concat("Page ", i + 1, " of ", HeatNoGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == HeatNoGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
        save_filter();
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        HeatNoGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    private bool selected()
    {
        if (HeatNoGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select the heat number.");
            return false;
        }
        else
        {
            return true;
        }
    }

    protected void HeatNoGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }

    protected void btnRecvd_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_Received.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnESD_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_ESD.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_Joints.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_BOM.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        if (!selected()) return;
        Response.Redirect("HeatNo_MTC.aspx?HEAT_NO=" + HeatNoGridView.SelectedValue.ToString());
    }

    private void save_filter()
    {
        Session["HN_FILTER"] = txtFilter.Text;
    }

    protected void HeatNoGridView_PageIndexChanged(object sender, EventArgs e)
    {
        //Session["HN_INDEX"] = HeatNoGridView.Selected;
    }

    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
    }
}