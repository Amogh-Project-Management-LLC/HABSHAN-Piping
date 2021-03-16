using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsHydroTestTableAdapters;
public partial class HydroTest_HydroTestSpools : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       hiddenSC.Value= WebTools.GetExpr("SC_ID", "PIP_HYDRO_TEST", " WHERE TEST_ID=" + Request.QueryString["TEST_ID"]);
        if (!IsPostBack)
        {
            string trans_no = WebTools.GetExpr("TEST_NO", "PIP_HYDRO_TEST",
                "TEST_ID=" + Request.QueryString["TEST_ID"]);
            Master.HeadingMessage = "Hydro Test Spools<br/>" + trans_no;
        }
    }

    protected void btnAddJoint_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        VIEW_PIP_HYDRO_TEST_DTTableAdapter items = new VIEW_PIP_HYDRO_TEST_DTTableAdapter();
        try
        {
            //items.InsertQuery(Decimal.Parse(Request.QueryString["TEST_ID"]), Decimal.Parse(cboNewJoint.SelectedValue), string.Empty);
            //jointsGridView.DataBind();
            //Master.ShowMessage(cboNewJoint.SelectedItem.Text + " joint Saced.");
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
    protected void jointsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowError("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("HydroTest.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void jointsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowMessage("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        EntryTable.Visible = EntryTable.Visible ? false : true;      
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        VIEW_HYDRO_TEST_SPLTableAdapter hydro_spl = new VIEW_HYDRO_TEST_SPLTableAdapter();
        try
        {
            if (decimal.Parse(Session["PROJECT_ID"].ToString()) > 0)
            {
                var collection = ddlSpoolList.CheckedItems;

                foreach (var item in collection)
                {
                    hydro_spl.InsertQuery(Convert.ToDecimal(Request.QueryString["TEST_ID"]), Convert.ToDecimal(item.Value), txtRemarks.Text);
                }
                EntryTable.Visible = EntryTable.Visible ? false : true;
                spoolsGridView.Rebind();
             
                ddlSpoolList.ClearSelection();
                ddlSpoolList.ClearCheckedItems();
                ddlSpoolList.DataBind();
                txtRemarks.Text = string.Empty;
            }
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnJnts_Click(object sender, EventArgs e)
    {
        if (spoolsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select any spool");
            return;
        }
        Response.Redirect("HydroTestItems.aspx?TEST_ID="+Request.QueryString["TEST_ID"]+"&SPL_ID=" + spoolsGridView.SelectedValue.ToString());
    }
}