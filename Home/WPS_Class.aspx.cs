using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Home_WPS_Class : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string heading = "Piping Class for WPS (";
            heading += WebTools.GetExpr("WPS_NO1", "PIP_WPS_NO", " WHERE WPS_ID='" + Request.QueryString["WPS_ID"] + "'");
            heading += ")";

            Master.HeadingMessage(heading);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string sql = string.Empty;
            //Master.show_info(cboPipeClass.Items.Count.ToString());
            for (int i = 0; i < cboPipeClass.Items.Count; i++)
            {
                if (cboPipeClass.Items[i].Checked)
                {
                    sql = "INSERT INTO PIP_WPS_SPEC (WPS_ID, CLASS) VALUES ('" + Request.QueryString["WPS_ID"] + "','" + cboPipeClass.Items[i].Text + "')";
                    
                    WebTools.ExeSql(sql);
                }
            }
            RadGrid1.Rebind();
            Master.show_success("Data Updated.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            if(e.Item is GridDataItem)
            {
                // NORMAL MODE
                GridDataItem item = e.Item as GridDataItem;
                string strId = item.GetDataKeyValue("CLASS").ToString();

                string sql = "DELETE FROM PIP_WPS_SPEC WHERE WPS_ID = '" + Request.QueryString["WPS_ID"] + "' AND CLASS= '" + strId + "'";
                WebTools.ExeSql(sql);
                RadGrid1.Rebind();
                Master.show_success("Item Deleted.");
            }
        }
    }
}