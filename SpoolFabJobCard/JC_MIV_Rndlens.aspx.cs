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
using dsCuttingPlanTableAdapters;

public partial class JC_MIV_RndLens : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Cutting Plan (" + WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO",
                " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]) + ")";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_CutPlan.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }
    protected void btnYes_Click(object sender, EventArgs e)
    {
        try
        {
            rowsGridView.DeleteRow(rowsGridView.SelectedIndex);
            Master.ShowMessage("Row deleted successfully!");
            rowsGridView.SelectedIndex = -1;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (rowsGridView.SelectedIndex < 0)
        {
            Master.ShowMessage("Select the entire row!");
            return;
        }
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowMessage("Proceed delete the selected row?");
    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        if (cboMat.SelectedValue.ToString() == "-1")
        {
            Master.ShowMessage("Select an item code!");
            return;
        }
        PIP_WORK_ORD_CUTLEN_RNDLENTableAdapter rnd = new PIP_WORK_ORD_CUTLEN_RNDLENTableAdapter();
        try
        {
            rnd.InsertQuery(decimal.Parse(Request.QueryString["WO_ID"]), decimal.Parse(cboMat.SelectedValue.ToString()), null);
            rowsGridView.DataBind();
            Master.ShowMessage(cboMat.SelectedItem.Text + " material added!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            rnd.Dispose();
        }
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        btnInsert.Visible = true;
        cboMat.Visible = true;
        btnAddAllPipes.Visible = true;
        cboMat.DataBind();
    }

    protected void btnAddAllPipes_Click(object sender, EventArgs e)
    {
        string MAT_SCOPE_CODE = WebTools.GetExpr("MAT_SCOPE_CODE", "PIP_WORK_ORD", "WO_ID=" + Request.QueryString["WO_ID"]);
        string random_len = "";
        decimal? random_len_dec = 0;

        PIP_WORK_ORD_CUTLEN_RNDLENTableAdapter rnd = new PIP_WORK_ORD_CUTLEN_RNDLENTableAdapter();
        try
        {
            foreach (ListItem li in cboMat.Items)
            {
                if (!string.IsNullOrEmpty(li.Value.ToString()) && li.Value.ToString() != "-1")
                {
                    random_len = WebTools.GetExpr("PIPE_RL", "PIP_PIPE_RANDOM_LEN",
                        "PIPE_RL > 0 AND PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND MAT_SCOPE_CODE='" + MAT_SCOPE_CODE +
                        "' AND MAT_CODE1='" + li.Text + "'");
                    if (!string.IsNullOrEmpty(random_len))
                    {
                        random_len_dec = decimal.Parse(random_len);
                        //random_len_dec = 11;
                    }
                    else
                    {
                        random_len_dec = null;
                    }

                    rnd.InsertQuery(decimal.Parse(Request.QueryString["WO_ID"]), decimal.Parse(li.Value.ToString()), random_len_dec);
                    //rnd.InsertQuery(decimal.Parse(Request.QueryString["WO_ID"]), decimal.Parse(li.Value.ToString()), 0);
                }
            }

            rowsGridView.DataBind();
            cboMat.DataBind();

            Master.ShowMessage("Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            rnd.Dispose();
        }
    }
    protected void cboMat_DataBinding(object sender, EventArgs e)
    {
        cboMat.Items.Clear();
        cboMat.Items.Add(new ListItem("Material Code", "-1"));
    }
}