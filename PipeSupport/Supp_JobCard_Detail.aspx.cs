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

public partial class Supp_JobCard_Detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_DELETE"))
            {
                Master.ShowWarn("Access Denied!");
            }

            Master.HeadingMessage = "Support Job Card <br/>" +
            WebTools.GetExpr("JC_NO", "PIP_SUPP_JC", "JC_ID=" + Request.QueryString["JC_ID"]);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Supp_JobCard.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select the entire row!");
            return;
        }
        YesNoHiddenField.Value = "1";
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Proceed delete the selected row?");
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        string bom_id = itemsGridView.SelectedValues[1].ToString();
        string tag_no = WebTools.GetExpr("MAT_CODE1", "VIEW_BOM_SIMPLE", "BOM_ID=" + bom_id);
        string mat_class = WebTools.GetExpr("MAT_CLASS", "VIEW_BOM_SIMPLE", "BOM_ID=" + bom_id);
        try
        {
            if (YesNoHiddenField.Value.ToString() == "1")
            {
                //Delete Row
                //itemsGridView.DeleteRow(itemsGridView.SelectedIndex);
                //Master.ShowMessage("Row deleted successfully!");
            }
            else if (YesNoHiddenField.Value.ToString() == "2")
            {
                //Update MTO
                WebTools.ExecNonQuery("DELETE FROM PIP_SUPP_BOM WHERE BOM_ID=" + bom_id);

                string result = WebTools.GetExpr(
                    "FNC_INSERT_SUPP_BOM('" + bom_id + "','" + tag_no + "','" + mat_class + "')", "DUAL", "");

                WebTools.ExecNonQuery(
                    "UPDATE PIP_SUPP_JC_DETAIL SET MTO_UPDATE_DATE=TO_CHAR(TO_DATE(SYSDATE), 'DD-MON-YYYY'), MTO_UPDATE_BY='" +
                    Session["USER_NAME"].ToString() + "' WHERE BOM_ID=" + bom_id + " AND JC_ID=" + itemsGridView.SelectedValues[0].ToString());

                Master.ShowSuccess("MTO Updated!");
            }
            else
            {
                Master.ShowMessage("Nothing Done!");
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        Response.Redirect("Supp_JobCard_View.aspx?JC_ID=" + Request.QueryString["JC_ID"] +
            "&BOM_ID=" + itemsGridView.SelectedValues[0].ToString());
    }
    protected void itemsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
        {
            e.Cancel = true;
            Master.ShowWarn("Access Denied!");
        }
    }
    protected void btnUpdateBOM_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (itemsGridView.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select a row!");
            return;
        }
        string bom_id = itemsGridView.SelectedValues[1].ToString();
        YesNoHiddenField.Value = "2";
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Proceed Update MTO for Selected BOM? BOM_ID=" + bom_id);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = txtSearch.Text.Trim().ToUpper();
    }
}