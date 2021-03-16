using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MTNReceiveDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Material Receive Detail<br/>";
            heading += WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID ='" + Request.QueryString["id"] + "'");
            Master.HeadingMessage = heading;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MTNReceive.aspx");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //Response.Redirect("MTNReceiveDetailImport.aspx?id=" + Request.QueryString["id"]);
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void cboMatCode_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        HiddenMatID.Value = WebTools.GetExpr("MAT_ID", "VIEW_STOCK", " WHERE MAT_CODE1='" + cboMatCode.Text + "'");

        txtReceiveQty.Text = WebTools.GetExpr("BAL_QTY", "VIEW_MAT_TRANSFER_RCV_BAL", " WHERE TRANSF_ID = (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID = '" + Request.QueryString["id"] + "') and MAT_ID = '" + HiddenMatID.Value + "'");

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            decimal excess = 0, shortage = 0, damage = 0;
            bool ex = decimal.TryParse(txtExcess.Text, out excess);
            bool sh = decimal.TryParse(txtShort.Text, out shortage);
            bool dm = decimal.TryParse(txtDamage.Text, out damage);

            dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter receive = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter();
            receive.InsertQuery(decimal.Parse(Request.QueryString["id"]), decimal.Parse(HiddenMatID.Value), decimal.Parse(txtReceiveQty.Text), txtAutoHeatNo.Entries[0].Text,
                txtAutoPS.Text, "", decimal.Parse(Session["PROJECT_ID"].ToString()), sh?excess:0, dm?damage:0, ex?excess:0);
            Master.ShowMessage("Item Added.");
            itemsGrid.Rebind();
        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
       
        try
        {
            dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter receive = new dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter();
            receive.DeleteQuery(decimal.Parse(itemsGrid.SelectedValue.ToString()));
            Master.ShowMessage("Item Deleted.");
            itemsGrid.Rebind();
            btnYes.Visible = false;
            btnNo.Visible = false;
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Selen a row to delete.");
            return;
        }

        btnYes.Visible = btnYes.Visible ? false : true;
        btnNo.Visible = btnNo.Visible ? false : true;
    }

    protected void btnNo_Click(object sender, EventArgs e)
    {
        btnYes.Visible = false;
        btnNo.Visible = false ;
    }
}