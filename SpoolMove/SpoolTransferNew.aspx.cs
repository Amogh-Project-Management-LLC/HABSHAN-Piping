using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolTransferNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Add Spool Transfer Request");
            txtTransBy.Text = Session["USER_NAME"].ToString();
            txtTransDate.SelectedDate = System.DateTime.Today;
        }
    }

    protected void ddlFromSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlFromSubcon.Items.Clear();
        ddlFromSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlToSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlToSubcon.Items.Clear();
        ddlToSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlFromSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + ddlFromSubcon.SelectedValue + "'");
        prefix += "-SPL-TRANS-";
        txtTransNo.Text = WebTools.NextSerialNo("PIP_SPL_TRANSFER", "TRANS_NO", prefix, 4, " WHERE FROM_SC = '" + ddlFromSubcon.SelectedValue + "'");

        string sql_command = "";
        if (ddlReason.SelectedIndex > 0)
        {
            var res_id = int.Parse(ddlReason.SelectedValue.ToString());
            if (res_id == 4)
                RowErectionOption.Visible = true;
            else
                RowErectionOption.Visible = false;

            switch (res_id)
            {
                case 1:
                    sql_command = "Select COAT_JC_NO AS JC_NO, JC_ID from PIP_COATING_JC WHERE FROM_SC='" + ddlFromSubcon.SelectedValue + "' AND SC_ID='" + ddlToSubcon.SelectedValue + "'";
                    sqlDocRef.SelectCommand = sql_command;
                    txtDocNo.Visible = false;
                    ddlDocNo.Visible = true;
                    break;
                case 2:
                    sql_command = "SELECT PNT_REQ_NO AS JC_NO, SPL_PNT_ID AS JC_ID FROM PIP_PAINTING_SPL";
                    sqlDocRef.SelectCommand = sql_command;
                    txtDocNo.Visible = false;
                    ddlDocNo.Visible = true;
                    break;
                case 3:
                    sql_command = "SELECT SER_NO AS JC_NO, TRANS_ID AS JC_ID FROM PIP_SPOOL_TRANS WHERE cat_id = 8 AND SC_ID='" + ddlFromSubcon.SelectedValue + "'";
                    sqlDocRef.SelectCommand = sql_command;
                    txtDocNo.Visible = false;
                    ddlDocNo.Visible = true;
                    break;

                case 4:
                    if (rdoErectionOption.SelectedValue.ToString().Equals("AT_SITE"))
                        sql_command = "SELECT rc.RCV_NO AS JC_NO FROM VIEW_SPOOL_RECEIVE rc WHERE rc.RCV_CAT_NAME='RECEIVE AT SITE'";
                    else
                        sql_command = "SELECT rc.RCV_NO AS JC_NO FROM VIEW_SPOOL_RECEIVE rc WHERE rc.RCV_CAT_NAME='RECEIVE BY FIELD SUBCON'";

                    sqlDocRef.SelectCommand = sql_command;
                    txtDocNo.Visible = false;
                    ddlDocNo.Visible = true;
                    break;

                case 5:
                    sql_command = "SELECT SER_NO AS JC_NO, TRANS_ID AS JC_ID FROM PIP_SPOOL_TRANS WHERE cat_id = 10 AND SC_ID=" + ddlFromSubcon.SelectedValue;
                    sqlDocRef.SelectCommand = sql_command;
                    txtDocNo.Visible = false;
                    ddlDocNo.Visible = true;
                    break;
               
            }
        }

        sqlDocRef.DataBind();
    }

    protected void ddlReason_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string sql_command = "";
        if (ddlReason.SelectedIndex < 0)
            return;

        var res_id = int.Parse(ddlReason.SelectedValue.ToString());
        if (res_id == 4)
            RowErectionOption.Visible = true;
        else
            RowErectionOption.Visible = false;

        switch (res_id)
        {
            case 1:
                sql_command = "Select COAT_JC_NO AS JC_NO, JC_ID from PIP_COATING_JC WHERE FROM_SC='" + ddlFromSubcon.SelectedValue + "' AND SC_ID='" + ddlToSubcon.SelectedValue + "'";
                sqlDocRef.SelectCommand = sql_command;
                txtDocNo.Visible = false;
                ddlDocNo.Visible = true;
                break;
            case 2:
                sql_command = "SELECT PNT_REQ_NO AS JC_NO, SPL_PNT_ID AS JC_ID FROM PIP_PAINTING_SPL";
                sqlDocRef.SelectCommand = sql_command;
                txtDocNo.Visible = false;
                ddlDocNo.Visible = true;
                break;
            case 3:
                sql_command = "SELECT SER_NO AS JC_NO, TRANS_ID AS JC_ID FROM PIP_SPOOL_TRANS WHERE cat_id = 8 AND SC_ID='" + ddlFromSubcon.SelectedValue +"'";
                sqlDocRef.SelectCommand = sql_command;
                txtDocNo.Visible = false;
                ddlDocNo.Visible = true;
                break;

            case 4:
                if (rdoErectionOption.SelectedValue.ToString().Equals("AT_SITE"))
                    sql_command = "SELECT rc.RCV_NO AS JC_NO FROM VIEW_SPOOL_RECEIVE rc WHERE rc.RCV_CAT_NAME='RECEIVE AT SITE'";
                else
                    sql_command = "SELECT rc.RCV_NO AS JC_NO FROM VIEW_SPOOL_RECEIVE rc WHERE rc.RCV_CAT_NAME='RECEIVE BY FIELD SUBCON'";

                sqlDocRef.SelectCommand = sql_command;
                txtDocNo.Visible = false;
                ddlDocNo.Visible = true;
                break;

            case 5:
                sql_command = "SELECT SER_NO AS JC_NO, TRANS_ID AS JC_ID FROM PIP_SPOOL_TRANS WHERE cat_id = 10 AND SC_ID=" + ddlFromSubcon.SelectedValue;
                sqlDocRef.SelectCommand = sql_command;
                txtDocNo.Visible = false;
                ddlDocNo.Visible = true;
                break;
            case 6:
                txtDocNo.Visible = true;
                ddlDocNo.Visible = false;
                break;
            case 7:
                txtDocNo.Visible = true;
                ddlDocNo.Visible = false;
                break;

        }

        sqlDocRef.DataBind();
        //Master.show_success("SQL_COMMAND AND res_id " + sql_command+" & "+ res_id);
        // txtAutoDocument.Re
        //txtAutoDocument.DataBind();
        //Master.show_success(txtAutoDocument.Entries.Count.ToString());
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (ddlDocNo.CheckedItems.Count == 0 && ddlDocNo.Visible)
            {
                Master.show_error("Please select a document number for reference.");
                return;
            }
            dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFERTableAdapter trans = new dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFERTableAdapter();
            trans.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtTransNo.Text,
                txtShip.Text,
                txtTransDate.SelectedDate,
                txtTransBy.Text,
                decimal.Parse(ddlFromSubcon.SelectedValue),
                ddlReason.SelectedItem.Text,
                decimal.Parse(ddlToSubcon.SelectedValue),
                "", System.DateTime.Today,
                txtRemarks.Text,
                txtContainerNo.Text);

            string sql;
            string trans_id;
            foreach (RadComboBoxItem item in ddlDocNo.CheckedItems)
            {
                trans_id = WebTools.GetExpr("TRANS_ID", "PIP_SPL_TRANSFER", " WHERE TRANS_NO = '" + txtTransNo.Text + "'");
                sql = "INSERT INTO PIP_SPL_TRANSFER_DOC (TRANS_ID, DOC_REF_NO) VALUES ('" + trans_id + "', '" + item.Text + "')";
                WebTools.ExeSql(sql);
            }

            Master.show_success("Transfer " + txtTransNo.Text + " Added.");

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void rdoErectionOption_SelectedIndexChanged(object sender, EventArgs e)
    {
        sqlDocRef.DataBind();
    }
}