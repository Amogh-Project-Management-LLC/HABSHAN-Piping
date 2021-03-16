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
using dsCuttingPlanATableAdapters;

public partial class Material_CuttingPlanMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            WO_IDHiddenField.Value =
                WebTools.GetExpr("WO_ID", "PIP_MAT_ISSUE_WO", "ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            string miv_no =
                WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", "ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            Master.HeadingMessage = "Cutting Plan <br/>" + miv_no;
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
    protected void btnAddMat_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!EntryDiv.Visible)
        {
            EntryDiv.Visible = true;
            btnSave.Visible = true;
        }
        else
        {
            EntryDiv.Visible = false;
            btnSave.Visible = false;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the material.");
            return;
        }
        Master.ShowWarn("Proceed deletd material?");
        btnYes.Visible = true;
        btnNo.Visible = true;
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
            Master.ShowMessage("Material deleted.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_CutPlan.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }
    protected void itemsGridView_DataBound(object sender, EventArgs e)
    {
        PageList.Items.Clear();
        for (int i = 0; i < itemsGridView.PageCount; i++)
        {
            ListItem pageListItem = new ListItem(String.Concat("Page ", i + 1, " of ", itemsGridView.PageCount), i.ToString());
            PageList.Items.Add(pageListItem);
            if (i == itemsGridView.PageIndex)
                pageListItem.Selected = true;
        }
    }
    protected void PageList_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemsGridView.PageIndex = Convert.ToInt32(PageList.SelectedValue);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        VIEW_WORK_ORD_CUTLENTableAdapter cp = new VIEW_WORK_ORD_CUTLENTableAdapter();
        try
        {
            cp.InsertQuery(decimal.Parse(Request.QueryString["ISSUE_ID"]),
                decimal.Parse(txtPieceNo.Text),
                decimal.Parse(txtLength.Text),
                txtHN.Text,
                txtPaintCode.Text,
                decimal.Parse(cboMat.SelectedValue.ToString())
                );
            itemsGridView.DataBind();
            Master.ShowMessage(cboMat.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            cp.Dispose();
        }
    }
    protected void btnAlloc_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the material.");
            return;
        }
        Response.Redirect("CuttingPlanAlloc.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"] +
            "&PIECE_ID=" + itemsGridView.SelectedValue.ToString());
    }

    protected void btnUpdateRemainSerial_Click(object sender, EventArgs e)
    {
        if (itemsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select a row.");
            return;
        }
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (!RemainSerialDiv.Visible)
        {
            RemainSerialDiv.Visible = true;
            UpdateRemSerial();
        }
        else
        {
            RemainSerialDiv.Visible = false;
        }
    }

    protected void itemsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RemainSerialDiv.Visible)
            UpdateRemSerial();
    }

    private void UpdateRemSerial()
    {
        string rem_serial = WebTools.GetExpr("REM_SERIAL", "VIEW_WORK_ORD_CUTLEN", "PIECE_ID=" + itemsGridView.SelectedValue.ToString());
        txtRemainSerialNo.Text = rem_serial;
    }

    protected void btnSaveRemainSerial_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtRemainSerialNo.Text.Trim()))
        {
            WebTools.ExecNonQuery("UPDATE PIP_WORK_ORD_CUTLEN SET REM_ID=NULL WHERE PIECE_ID=" + itemsGridView.SelectedValue.ToString());
            itemsGridView.DataBind();
            return;
        }

        string sc_id = WebTools.GetExpr("SC_ID", "VIEW_JC_MIV", "ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
        string rem_id = WebTools.GetExpr("REM_ID", "PIP_PIPE_REMAIN",
            string.Format("SC_ID={0} AND REM_SERIAL={1}", sc_id, txtRemainSerialNo.Text.Trim()));
        if (!string.IsNullOrEmpty(rem_id))
        {
            WebTools.ExecNonQuery("UPDATE PIP_WORK_ORD_CUTLEN SET REM_ID=" + rem_id + " WHERE PIECE_ID=" + itemsGridView.SelectedValue.ToString());
            itemsGridView.DataBind();
        }
        else
        {
            Master.ShowError("Remain Serial no not found!");
            return;
        }
    }
}
