using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolCoatingJCTrans : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "SPOOL TRANSFER NOTE";
            heading += "<br/>";
            heading += WebTools.GetExpr("COAT_JC_NO", "PIP_COATING_JC", " WHERE JC_ID='" + Request.QueryString["JC_ID"] + "'");

            Master.HeadingMessage = heading;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SpoolCoatingJC.aspx");
    }

    protected void radAddOptions_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch(radAddOptions.SelectedValue)
        {
            case "APPEND":
                cboTransferList.Visible = true;
                btnSave.Enabled = true;
                break;
            case "NEW":
                cboTransferList.Visible = false;
                btnSave.Enabled = true;
                break;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string trans_id = string.Empty;
            switch (radAddOptions.SelectedValue)
            {
                case "APPEND":
                    Import(cboTransferList.SelectedValue);
                    break;
                case "NEW":
                    Import(Register());
                    //trans_id = Register();
                    break;
            }

           /// Master.ShowMessage(trans_id);
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void Import(string trans_id)
    {
        string spl_id, sql, doc_no;
        try
        {
            foreach (GridDataItem row in itemsGrid.Items)
            {
                CheckBox cb = row["Check_Col"].FindControl("CheckBox1") as CheckBox;

                if (cb.Checked)
                {
                    spl_id = row.GetDataKeyValue("SPL_ID").ToString();
                    doc_no = row["COAT_JC_NO"].Text;
                    sql = "INSERT INTO PIP_SPL_TRANSFER_DETAIL (TRANS_ID, SPL_ID, DOC_NO) VALUES ";
                    sql += " ('" + trans_id + "', '" + spl_id + "', '" + doc_no + "')";

                    WebTools.ExeSql(sql);
                }
            }

            string trans_no = WebTools.GetExpr("TRANS_NO", "PIP_SPL_TRANSFER", " WHERE TRANS_ID='" + trans_id + "'");
            Master.ShowMessage("Data Imported to Transfer No " + trans_no + ".");

            itemsGrid.Rebind();
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected string Register()
    {
        string trans_id = string.Empty;
        string to_sc_id = WebTools.GetExpr("SC_ID", "PIP_COATING_JC", " WHERE JC_ID = '" + Request.QueryString["JC_ID"] + "'");
        string from_sc_id = WebTools.GetExpr("FROM_SC", "PIP_COATING_JC", " WHERE JC_ID = '" + Request.QueryString["JC_ID"] + "'");
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + from_sc_id + "'");
        prefix += "-SPL-TRANS-";
        string trans_no = WebTools.NextSerialNo("PIP_SPL_TRANSFER", "TRANS_NO", prefix, 4, " WHERE FROM_SC = '" + from_sc_id + "'");

        
        string sql = "INSERT INTO PIP_SPL_TRANSFER (PROJECT_ID, TRANS_NO, TRANS_DATE, TRANS_BY, FROM_SC, TO_SC, TRANSFER_REASON, REMARKS) VALUES ";
        sql += " (1, '" + trans_no + "', '" + System.DateTime.Today.ToString("dd-MMM-yyyy") + "', '" + Session["USER_NAME"] + "', " + from_sc_id;
        sql += ", " + to_sc_id + ", 'FOR COATING', '')";

        WebTools.ExeSql(sql);

        trans_id = WebTools.GetExpr("TRANS_ID", "PIP_SPL_TRANSFER", " WHERE TRANS_NO = '" + trans_no + "'");

        //register document number 
        string doc = WebTools.GetExpr("COAT_JC_NO", "PIP_COATING_JC", " WHERE JC_ID='" + Request.QueryString["JC_ID"] + "'");
        sql = "INSERT INTO PIP_SPL_TRANSFER_DOC (TRANS_ID, DOC_REF_NO) VALUES ('" + trans_id + "', '" + doc + "')";
        WebTools.ExeSql(sql);

        return trans_id;
    }
}