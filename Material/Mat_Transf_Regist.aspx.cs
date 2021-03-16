using dsMaterialBTableAdapters;
using System;

public partial class Erection_Additional_Mat_Regist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Transfer - Register";
            txtCreateDate.SelectedDate = System.DateTime.Now;
            txtCreateBy.Text = Session["USER_NAME"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_MAT_TRANSFTableAdapter issue = new PIP_MAT_TRANSFTableAdapter();
        try
        {
            string cat_id = ddlTransType.SelectedValue;
            string doc_name = string.Empty;
            if (ddlTransDocName.Visible)
                doc_name = ddlTransDocName.SelectedItem.Text;
            issue.InsertQuery(
                decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtTransfNo.Text, txtCreateDate.SelectedDate,
                txtCreateBy.Text,
                Decimal.Parse(ddFrom.SelectedValue.ToString()),
                Decimal.Parse(ddTo.SelectedValue.ToString()),
                txtRemarks.Text,
                ddScope.SelectedValue.ToString(), decimal.Parse(cat_id), doc_name);

            Master.ShowMessage("Material transfer created.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            issue.Dispose();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Mat_Transf.aspx");
    }

    protected void ddScope_DataBinding(object sender, EventArgs e)
    {
        ddScope.Items.Clear();
        ddScope.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddFrom_DataBinding(object sender, EventArgs e)
    {
        ddFrom.Items.Clear();
        ddFrom.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddTo_DataBinding(object sender, EventArgs e)
    {
        ddTo.Items.Clear();
        ddTo.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlTransType_DataBinding(object sender, EventArgs e)
    {
        ddlTransType.Items.Clear();
        ddlTransType.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void ddlTransType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string sql = string.Empty;
        switch (ddlTransType.SelectedValue)
        {
            case "1":
                lblTransDoc.Text = "Material Request No";
                lblTransDoc.Visible = true;
                ddlTransDocName.Visible = true;
                //sql = "SELECT MAT_REQ_ID, MAT_REQ_NO as DOC_NAME FROM VIEW_MATERIAL_REQUEST WHERE REQ_TO = '" + ddFrom.SelectedValue + "' AND REQ_FROM = '" + ddTo.SelectedValue +"' ORDER BY MAT_REQ_NO DESC";                
                break;
            case "3":
                lblTransDoc.Text = "Painting MIV No";
                lblTransDoc.Visible = true;
                ddlTransDocName.Visible = true;
               //sql = "";
                break;
            default:
                lblTransDoc.Visible = false;
                ddlTransDocName.Visible = false;
                break;
        }

        BindDocumentNo();
        //sqlDocumentSource.SelectCommand = sql;
       
    }

    protected void ddFrom_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"] + "'");
        string sc_id = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID='" + ddFrom.SelectedValue + "'");
        prefix += "-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " WHERE SUB_CON_ID = '" + sc_id + "'");
        prefix += "-MAT-TRANS-";
        txtTransfNo.Text = WebTools.NextSerialNo("PIP_MAT_TRANSF", "TRANSF_NO",prefix, 4, " WHERE A_STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID = '" + sc_id + "')");
        //BindDocumentNo();
    }

    protected void ddTo_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        BindDocumentNo();
        //ddlTransDocName.SelectedItem.Text = "";
    }

    protected void ddlTransDocName_DataBinding(object sender, EventArgs e)
    {
        ddlTransDocName.Items.Clear();
        ddlTransDocName.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select)", ""));
    }

    protected void BindDocumentNo()
    {
        string sql = string.Empty;
        lblMessage.Text = "";
        string from_sc = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" + ddFrom.SelectedValue);
        string to_sc = WebTools.GetExpr("SC_ID", "STORES_DEF", " WHERE STORE_ID=" + ddTo.SelectedValue);
        switch (ddlTransType.SelectedValue)
        {
            case "1":
                sql = "SELECT MAT_REQ_ID, MAT_REQ_NO as DOC_NAME FROM VIEW_MATERIAL_REQUEST WHERE REQ_TO = '" + from_sc + "' AND REQ_FROM = '" + to_sc + "' ORDER BY MAT_REQ_NO DESC";
                break;
            case "3":
                sql = "SELECT ISSUE_ID, ISSUE_NO AS DOC_NAME, A.SC_ID AS MIV_FROM, B.TO_SC FROM PIP_BULK_PAINT_ISSUE A, PIP_PAINTING_MAT B WHERE A.PAINT_JC_ID = B.PAINT_ID AND A.SC_ID = '"+ from_sc +"' AND B.TO_SC = '"+ to_sc +"'";
                break;
        }
        sqlDocumentSource.SelectCommand = sql;
        ddlTransDocName.DataBind();
        if (ddlTransDocName.Items.Count == 1 && ddlTransType.SelectedValue.Equals("1"))
            lblMessage.Text = "No Material Request found under selected 'To Store' subcon !";
        if (ddlTransDocName.Items.Count == 1 && ddlTransType.SelectedValue.Equals("3"))
            lblMessage.Text = "No Painting MIV request found under selected 'To Store' subcon !";

        //Master.ShowSuccess(sql);
    }
}