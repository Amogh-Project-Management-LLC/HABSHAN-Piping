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
using dsPO_ShipmentATableAdapters;

public partial class Material_MatReceiveNewItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
            string mrir = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID=" +
                Request.QueryString["MAT_RCV_ID"]);
            Master.HeadingMessage = "MRIR Materials Register (" + mrir + ")";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }

        //if (WebTools.GetExpr("HEAT_NO", "PIP_HEAT_NO", " WHERE HEAT_NO='" + txtHeatNo.Text +
        //    "' AND PROJECT_ID=" + Session["PROJECT_ID"].ToString()) == "")
        //{
        //    Master.ShowWarn("Heat number not found!");
        //    return;
        //}
        //else
        //{
        //    //Find TC_CODE for selected heat number
        //}

        PIP_MAT_RECEIVE_DETAILTableAdapter items = new PIP_MAT_RECEIVE_DETAILTableAdapter();
        try
        {
            items.InsertQuery(Decimal.Parse(Request.QueryString["MAT_RCV_ID"]),
            mat_id, Decimal.Parse(txtQty.Text),
            "", 1,
            txtPoItem.Text, txtRemarks.Text,
            txtMrItem.Text, txtSRNNo.Text, decimal.Parse(txtUnitWeight.Text));
            Master.ShowMessage("Item added.");
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

    private void go_back()
    {
        Response.Redirect("MatReceiveItems.aspx?MAT_RCV_ID=" + Request.QueryString["MAT_RCV_ID"]);
    }

    protected void txtMatCode_TextChanged(object sender, EventArgs e)
    {
        decimal mat_id = db_lookup.MAT_ID(txtMatCode.Text, Decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
        matIdField.Value = mat_id.ToString();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        go_back();
    }
}