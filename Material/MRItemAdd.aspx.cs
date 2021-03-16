using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MRItemAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Add Items (";
            heading += WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " MR_ID='" + Request.QueryString["MR_ID"] + "'");
            heading += ")";
            Master.HeadingMessage(heading);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsMaterialDTableAdapters.PIP_MAT_REQUISITION_DETAILTableAdapter mr_detail = new dsMaterialDTableAdapters.PIP_MAT_REQUISITION_DETAILTableAdapter();
            mr_detail.InsertQuery(decimal.Parse(Request.QueryString["MR_ID"].ToString()), decimal.Parse(txtMRItem.Text), txtTagNo.Text,
                txtMatDescr.Text, txtClientPartNo.Text, decimal.Parse(txtMRQty.Text), decimal.Parse(txtPrevQty.Text), "",
                txtDelPoint.Text, txtConstArea.Text);
            Master.show_success("Item Added to MR.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}