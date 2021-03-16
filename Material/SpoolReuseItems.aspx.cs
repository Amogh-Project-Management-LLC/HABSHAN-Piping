using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_SpoolReuseItems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Reuse<br/>";
            Master.HeadingMessage += WebTools.GetExpr("MRN_NO", "PIP_MAT_REUSE", " MRN_ID=" + Request.QueryString["REQ_ID"]);
        }
    }

    protected void txtSeachIsome_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        HiddenISOID.Value = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", " WHERE ISO_TITLE1='" + txtSeachIsome.Text + "'");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsMaterialCTableAdapters.VIEW_MAT_REUSE_SPLTableAdapter spl = new dsMaterialCTableAdapters.VIEW_MAT_REUSE_SPLTableAdapter();
            foreach (RadComboBoxItem item in ddlSpoolList.CheckedItems)
            {
                spl.InsertQuery(decimal.Parse(Request.QueryString["REQ_ID"]), decimal.Parse(item.Value), txtRemarks.Text);
            }

            Master.ShowMessage("Item Added.");
            RadGrid1.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnAddSpool_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
        btnSave.Visible = btnSave.Visible ? false : true;
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialReuse.aspx");
    }
}