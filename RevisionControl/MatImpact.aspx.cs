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
using dsIsomeControlATableAdapters;

public partial class Material_Reports_JC_MIV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Impact";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("");
    }

 
    protected void btnBack_Click1(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/IsomeRevision.aspx?ISO_ID=" + Request.QueryString["ISO_ID"]);
    }
    protected void btnBack_Click2(object sender, EventArgs e)
    {
        string BackUrl = Request.QueryString["BackUrl"];
        Response.Redirect(BackUrl);
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!EntryDiv.Visible)
        {
            EntryDiv.Visible = true;
            btnSave.Visible = true;
            rowsGridView.PageSize = 10;
        }
        else
        {
            EntryDiv.Visible = false;
            btnSave.Visible = false;
            rowsGridView.PageSize = 18;
        }
    }

    protected void rowsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            e.Cancel = true;
        }
    }
    protected void RadSearchBoxISO_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        ISO_HiddenField.Value = RadSearchBoxISO.Text;
        cboSpool.DataBind();
    }
    protected void cboSpool_DataBinding(object sender, EventArgs e)
    {
        cboSpool.Items.Clear();
        cboSpool.Items.Add(new Telerik.Web.UI.DropDownListItem("", "-1"));
    }
    protected void ddMatCode_DataBinding(object sender, EventArgs e)
    {
        ddMatCode.Items.Clear();
        ddMatCode.Items.Add(new Telerik.Web.UI.DropDownListItem("", "-1"));
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_MAT_IMPACTTableAdapter m_impact = new VIEW_MAT_IMPACTTableAdapter();
        try
        {
            m_impact.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                decimal.Parse(cboSpool.SelectedValue.ToString()),
                txtRevNo.Text, txtSCR.Text, txtFCR.Text,
                decimal.Parse(ddMatCode.SelectedValue.ToString()),
                decimal.Parse(cboImpact.SelectedValue.ToString()),
                decimal.Parse(cboSF.SelectedValue.ToString()),
                decimal.Parse(txtQty.Text),
                txtRemarks.Text);
            rowsGridView.DataBind();
            Master.ShowMessage(ddMatCode.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            m_impact.Dispose();
        }
    }
}