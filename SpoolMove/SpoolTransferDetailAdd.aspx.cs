using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolTransferDetailAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Spools (";
            heading += WebTools.GetExpr("TRANS_NO", "PIP_SPL_TRANSFER", " WHERE TRANS_ID='" + Request.QueryString["TRANS_ID"].ToString() + "'");
            heading += ")";

            Master.HeadingMessage(heading);

            string document = WebTools.GetExpr("DOC_REF_NO", "VIEW_SPL_TRANSFER", " WHERE TRANS_ID = '" + Request.QueryString["TRANS_ID"] + "'");

            if (document.Trim().Length > 0)
            {
                ddlAddOptions.Items[1].Text = "Import From ";
                ddlAddOptions.Items[1].Enabled = true;
                //ddlDocRef.Visible = true;
            }
            else
                ddlAddOptions.Items[1].Enabled = false;
        }
    }

    protected void ddlAddOptions_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch(ddlAddOptions.SelectedValue)
        {
            case "MANUAL":
                EntryTable.Visible = EntryTable.Visible ? false : true;
                ImportTable.Visible = false;
                ddlDocRef.Visible = false;
                break;
            case "IMPORT":
                EntryTable.Visible = false;
                ImportTable.Visible = ImportTable.Visible ? false : true;
                ddlDocRef.Visible = true;
                break;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFER_DETAILTableAdapter spl = new dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFER_DETAILTableAdapter();
        int i = 0;
        while (i < cboSpoolList.Items.Count)
        {
            if (cboSpoolList.Items[i].Selected)
                spl.InsertQuery(decimal.Parse(Request.QueryString["TRANS_ID"].ToString()),
                     decimal.Parse(cboSpoolList.Items[i].Value), txtRemarks.Text);

            i++;
        }

        Master.show_success("Spools Added to Transfer Note.");
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        string reason = WebTools.GetExpr("TRANSFER_REASON", "PIP_SPL_TRANSFER", " WHERE TRANS_ID='" + Request.QueryString["TRANS_ID"] + "'");
        string document = ddlDocRef.SelectedItem.Text; //WebTools.GetExpr("DOC_REF_NO", "PIP_SPL_TRANSFER", " WHERE TRANS_ID = '" + Request.QueryString["TRANS_ID"] + "'");

        string doc_table = WebTools.GetExpr("DOC_TABLE", "PIP_SPL_TRANSFER_REASON", " WHERE REASON_TYPE = '" + reason.ToUpper() + "'");
        string doc_no_col = WebTools.GetExpr("DOC_NO_COL", "PIP_SPL_TRANSFER_REASON", " WHERE REASON_TYPE = '" + reason.ToUpper() + "'");
        string doc_id_col = WebTools.GetExpr("DOC_ID_COL", "PIP_SPL_TRANSFER_REASON", " WHERE REASON_TYPE = '" + reason.ToUpper() + "'");
        string spl_table = WebTools.GetExpr("SPL_TABLE", "PIP_SPL_TRANSFER_REASON", " WHERE REASON_TYPE = '" + reason.ToUpper() + "'");
        string spl_id_col = WebTools.GetExpr("SPL_ID_COL", "PIP_SPL_TRANSFER_REASON", " WHERE REASON_TYPE = '" + reason.ToUpper() + "'");
        string doc_id_spl = WebTools.GetExpr("DOC_ID_SPL", "PIP_SPL_TRANSFER_REASON", " WHERE REASON_TYPE = '" + reason.ToUpper() + "'");
        DataTable dt = new DataTable();
        try
        {
            string doc_id = WebTools.GetExpr(doc_id_col, doc_table, " WHERE " + doc_no_col + " = '" + document + "'");

            string sql;
            if (radImportOptions.SelectedValue == "DELETE")
            {
                sql = "DELETE FROM PIP_SPL_TRANSFER_DETAIL WHERE TRANS_ID = '" + Request.QueryString["TRANS_ID"] + "'";
                WebTools.ExeSql(sql);
            }

            sql = "SELECT " + spl_id_col + " FROM " + spl_table + " WHERE " + doc_id_spl + " = " + doc_id;
            sql += " AND " + spl_id_col + " NOT IN (SELECT SPL_ID FROM PIP_SPL_TRANSFER_DETAIL WHERE TRANS_ID = '" + Request.QueryString["TRANS_ID"] + "')";
           
            dt = General_Functions.GetDataTable(sql);

            foreach (DataRow dr in dt.Rows)
            {
                sql = "INSERT INTO PIP_SPL_TRANSFER_DETAIL (DOC_NO, TRANS_ID, SPL_ID) VALUES ('"+ ddlDocRef.SelectedItem.Text + "','" + Request.QueryString["TRANS_ID"] + "','" + dr[0].ToString() + "')";
                WebTools.ExeSql(sql);
            }

            Master.show_success("Data Imported Successfully.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally {
            dt.Dispose();
        }
    }
}