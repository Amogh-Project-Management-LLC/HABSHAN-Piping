using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsErectionTableAdapters;

public partial class Erection_MatIssueLooseJoints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "SITE JOB CARD - JOINT LIST";
        }
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            VIEW_MAT_ISSUE_ASSEMBLY_JOINTTableAdapter joint = new VIEW_MAT_ISSUE_ASSEMBLY_JOINTTableAdapter();
            VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter loose = new VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter();
            int flag = 0;
            foreach (RadComboBoxItem item in ddlJointList.Items)
            {
                if (item.Checked)
                {
                    string bolt_qty = WebTools.GetExpr("BOLT_QTY", "PIP_SITE_JOINTS", " WHERE JOINT_ID='" + decimal.Parse(item.Value) + "'");
                    string gasket_qty = WebTools.GetExpr("GASKET_QTY", "PIP_SITE_JOINTS", " WHERE JOINT_ID='" + decimal.Parse(item.Value) + "'");
                    if(bolt_qty=="")
                    {
                        bolt_qty = "0";
                    }
                    if(gasket_qty=="")
                    {
                        gasket_qty = "0";
                    }
                   
                   //string iso_id= WebTools.GetExpr("ISO_ID", "PIP_SITE_JOINTS", " WHERE JOINT_ID='" + decimal.Parse(item.Value) + "'");
                   // string bolt_item_code = WebTools.GetExpr("BOLT_ITEM_CODE", "PIP_SITE_JOINTS", " WHERE JOINT_ID='" + decimal.Parse(item.Value) + "'");
                   // string gasket_item_code = WebTools.GetExpr("GASKET_ITEM_CODE", "PIP_SITE_JOINTS", " WHERE JOINT_ID='" + decimal.Parse(item.Value) + "'");
                   // string bolt_mat_id = WebTools.GetExpr("MAT_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_CODE1='" + bolt_item_code + "'");
                   // string gasket_mat_id = WebTools.GetExpr("MAT_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_CODE1='" + gasket_item_code + "'");
                   // string bolt_bom_id = WebTools.GetExpr("BOM_ID", "VIEW_ISO_BOM_LINK", " WHERE  ISO_ID='"+iso_id+"' AND MAT_ID='" + bolt_mat_id + "'");
                   // string gasket_bom_id = WebTools.GetExpr("BOM_ID", "VIEW_ISO_BOM_LINK", " WHERE  ISO_ID='" + iso_id + "' AND  MAT_ID='" + gasket_mat_id + "'");
                   
                        
                    joint.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"].ToString()), decimal.Parse(item.Value), null, decimal.Parse(bolt_qty), decimal.Parse(gasket_qty));

                    //if (bolt_bom_id != "")
                    //{
                    //    loose.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"].ToString()),decimal.Parse(bolt_bom_id), decimal.Parse(bolt_qty), null);
                    //}
                    //if ( gasket_bom_id != "")
                    //{
                    //    loose.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"].ToString()), decimal.Parse(gasket_bom_id), decimal.Parse(gasket_qty), null);
                    //}
                    
                }
            }

            itemsGridView.Rebind();
            Master.ShowMessage("Items Added!" );
            
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message+": BOM NOT FOUND FOR GASKET/BOLT IN ISOMETRIC");
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("SiteAssemblyJC.aspx");
    }
}