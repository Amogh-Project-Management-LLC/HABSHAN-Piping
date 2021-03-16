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
using Telerik.Web.UI;

public partial class SpoolProgressSelection_1 : System.Web.UI.Page
{
    string area = "";
    string Subcon = "";
    string module_id = "";

    public bool REPORT_CODE { get; private set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Daily Progress Report";
        }
    }

    

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }



    protected void btnPreview_Click(object sender, EventArgs e)
    { 
        if (ddlArea.CheckedItems.Count > 0 && ddlSubcon.CheckedItems.Count >0)
        {
            string module_id = ddlModule.SelectedValue;
            string cat_id = RadComboBox1.SelectedValue;
            getArea();
            getSubCon();

            WebTools.ExeSql("DELETE FROM TABLE_RDLC_SELECTION WHERE USER_NAME = '" + Session["USER_NAME"].ToString() + "' AND REPORT_CODE='" + Request.QueryString["ReportID"] + "'");
            WebTools.ExeSql("INSERT INTO  TABLE_RDLC_SELECTION (REPORT_CODE,USER_NAME,MODULE_ID, AREA, FAB_SUBCON)" +
                " VALUES ('" + Request.QueryString["ReportID"] + "','"+ Session["USER_NAME"].ToString() +"','" + module_id+"','"+area.Replace("'","''")+"','"+ Subcon.Replace("'", "''") + "') ");
            Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID="+ Request.QueryString["ReportID"] +"&MODULE_ID="+ module_id +"&CAT_ID="+ cat_id);
        }
        else
        {
            Master.ShowWarn("Please select Area and SubCon");
        }
    }
 
    
   
    protected void getArea()
    {
        if (ddlArea.CheckedItems.Count > 0)
        {
            var collection = ddlArea.CheckedItems;
            foreach (var item in collection)
            {
                if (item.Value.Length==0)
                {
                    item.Value = "-";
                }
                else
                {
                    area = area + "'" + item.Value + "',";
                }
                

            }
            area = area.Substring(0, area.Length - 1);

        }
    }

 
    protected void getSubCon()
    {
        if (ddlSubcon.CheckedItems.Count > 0)
        {
            var collection = ddlSubcon.CheckedItems;
            foreach (var item in collection)
            {
                if (item.Value.Length == 0)
                {
                    item.Value = "-";
                }
                else
                {
                    Subcon = Subcon + "'" + item.Value + "',";
                }

            }
            Subcon = Subcon.Substring(0, Subcon.Length - 1);

        }
    }

   
}