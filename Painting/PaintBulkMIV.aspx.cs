using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Painting_PaintBulkMIV : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Bulk Material Painting (MIV)";

            Master.AddModalPopup("~/Painting/PaintBulkMIVAdd.aspx", btnRegister.ClientID, 500, 650);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select MIV Number to Continue.");
            return;
        }
        Response.Redirect("PaintBulkMIVItems.aspx?ISSUE_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowWarn("Select MIV Number");
            return;
        }
        Response.Redirect("PaintISO_ReportViewer.aspx?ReportID=8&Arg1=" + itemsGrid.SelectedValue);
    }

    protected void itemsGrid_ItemDeleted(object sender, Telerik.Web.UI.GridDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            if (e.Exception.Message == "Exception has been thrown by the target of an invocation.")
                Master.ShowError("Child Records Found!!");
            else
                Master.ShowError(e.Exception.Message);
        }
    }

    protected void btnCreateTransfer_Click(object sender, EventArgs e)
    {

        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowMessage("Select MIV to continue.");
            return;
        }

        string doc = WebTools.GetExpr("ISSUE_NO", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_ID = '" + itemsGrid.SelectedValue + "'");
        string trans_id = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSF", " WHERE DOC_REF_NO='" + doc + "'");


        if (!string.IsNullOrEmpty(trans_id))
        {
            Master.ShowError("Transfer Number for Selected MIV is already created.");
            return;
        }

        string from_store = WebTools.GetExpr("STORE_ID", "STORES_DEF", " WHERE SC_ID = '" +
                                                 WebTools.GetExpr("SC_ID", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_ID = " + itemsGrid.SelectedValue) + "'");

        string to_sc = WebTools.GetExpr("TO_SC", "PIP_PAINTING_MAT", " WHERE PAINT_ID='" +
                                                WebTools.GetExpr("PAINT_JC_ID", "PIP_BULK_PAINT_ISSUE", " WHERE ISSUE_ID = " + itemsGrid.SelectedValue) + "'");

        string to_store = WebTools.GetExpr("STORE_ID", "STORES_DEF", " WHERE SC_ID=" + to_sc);
        //Get New Transfer NO
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID='" + from_store + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + sc_id + "'");
        prefix += "-MAT-TRANS-";
        string trans_no = WebTools.NextSerialNo("PIP_MAT_TRANSF", "TRANSF_NO", prefix, 4, " WHERE A_STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID = '" + sc_id + "')");


        try
        {
            dsMaterialBTableAdapters.PIP_MAT_TRANSFTableAdapter item = new dsMaterialBTableAdapters.PIP_MAT_TRANSFTableAdapter();
            item.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), trans_no, System.DateTime.Now, Session["USER_NAME"].ToString(), decimal.Parse(from_store),
                decimal.Parse(to_store), null, "MAIN", 3, doc);

            trans_id = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_NO='" + trans_no + "'");

            if (!string.IsNullOrEmpty(trans_id))
            {
                //Update Transfer Detail
                dsMaterialBTableAdapters.PIP_MAT_TRANSF_DETAILTableAdapter detail = new dsMaterialBTableAdapters.PIP_MAT_TRANSF_DETAILTableAdapter();


                dsPaintingMat.VIEW_BULK_PAINT_ISSUE_DETAILDataTable dt = new dsPaintingMat.VIEW_BULK_PAINT_ISSUE_DETAILDataTable();
                dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter issue = new dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter();
                dt = issue.GetData(decimal.Parse(itemsGrid.SelectedValue.ToString()));
                
                foreach (DataRow r in dt.Rows)
                {
                    detail.InsertQuery(decimal.Parse(trans_id), decimal.Parse(r["MAT_ID"].ToString()), r["HEAT_NO"].ToString(), decimal.Parse(r["ISSUE_QTY"].ToString()), "XXX", 1,
                            null, null, r["PAINT_CODE"].ToString().Length == 0 ? "XXX" : r["PAINT_CODE"].ToString());
                }
            }

            Master.ShowMessage(trans_no + " Created Successfully.");
        }
        catch (Exception ex)
        {
            trans_id = WebTools.GetExpr("TRANSF_ID", "PIP_MAT_TRANSF", " WHERE TRANSF_NO='" + trans_no + "'");

            string sql = "DELETE FROM PIP_MAT_TRANSF_DETAIL WHERE TRANSF_ID = '" + trans_id + "'";
            WebTools.ExeSql(sql);
            
            sql = "DELETE FROM PIP_MAT_TRANSF WHERE TRANSF_ID = '" + trans_id + "'";
            WebTools.ExeSql(sql);

            Master.ShowError(ex.Message);
        }

    }
}