using System;
using System.Web.UI.WebControls;

public partial class HeatNo_TC_Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Test Certificates";

            string _filter = Session["TC_FILTER"].ToString();

            if (_filter != "")
            {
                txtFilter.Text = _filter;
            }

            Master.RadGridList = "";

            Master.AddModalPopup("~/HeatNo/ShowMTC_PDF.aspx", btnShowPDF.ClientID, 20, 500);

            WebTools.Check_Session_Variable("popup_TC_ID");
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (tcGridView.SelectedIndexes.Count > 0)
        {
            Master.ShowWarn("Proceed delete test certificate?");
            btnYes.Visible = true;
            btnNo.Visible = true;
        }
        else
        {
            Master.ShowWarn("Select the test certificate to delete!");
        }
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        if (tcGridView.SelectedIndexes.Count == 0) return;
        try
        {
            dsGeneralTableAdapters.PIP_TEST_CARDSTableAdapter mtc = new dsGeneralTableAdapters.PIP_TEST_CARDSTableAdapter();
            mtc.DeleteQuery(decimal.Parse(tcGridView.SelectedValue.ToString()));
            Master.ShowSuccess("Item Deleted.");
            tcGridView.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnAddTC_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("TC_New.aspx");
    }

    protected void btnViewPDF_Click(object sender, EventArgs e)
    {
    }

    protected void tcGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }

    protected void tcGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < tcGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", tcGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == tcGridView.CurrentPageIndex)
                pageListItem.Selected = true;
        }
        Session["TC_PG_INDEX"] = tcGridView.CurrentPageIndex;
        Session["TC_FILTER"] = txtFilter.Text;
    }

    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        tcGridView.CurrentPageIndex = Convert.ToInt32(PageList.SelectedValue);
    }

    protected void tcGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popup_TC_ID"] = tcGridView.SelectedValue.ToString();
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (tcGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the test certificate number!");
            return;
        }
        Response.Redirect("TC_Upload.aspx?TC_ID=" + tcGridView.SelectedValue.ToString() +
            "&Filter=" + txtFilter.Text + "&grdIndex=" + tcGridView.SelectedIndexes[0].ToString());
    }

    protected void btnHeatNos_Click(object sender, EventArgs e)
    {
        if (tcGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the test certificate number!");
            return;
        }
        Response.Redirect("TC_Details.aspx?Filter=" + txtFilter.Text +
            "&TC_ID=" + tcGridView.SelectedValue.ToString() +
            "&PageIndex=" + tcGridView.CurrentPageIndex.ToString() +
            "&SelIndex=" + tcGridView.SelectedIndexes[0].ToString());


        
    }

    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        txtFilter.Text = txtFilter.Text.Trim().ToUpper();
    }
}