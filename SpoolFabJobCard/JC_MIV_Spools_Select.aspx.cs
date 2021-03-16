using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsFabricationJCTableAdapters;
public partial class SpoolFabJobCard_JC_MIV_Spools_Select : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
               Request.QueryString["ISSUE_ID"]);
            string wo = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);
            Master.HeadingMessage = "Add MIV Spools (" + wo + "/ " + miv_no + ")";
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            PIP_MAT_ISSUE_WO_SPLTableAdapter wo_spl = new PIP_MAT_ISSUE_WO_SPLTableAdapter();
            int issue_id = int.Parse(Request.QueryString["ISSUE_ID"]);
            int spl_cnt = 0;
            foreach (GridItem item in JCMIVSpoolGrid.MasterTableView.Items)
            {
                GridDataItem dataitem = (GridDataItem)item;
                if (dataitem.Selected)
                {
                    string spl_id = dataitem.GetDataKeyValue("SPL_ID").ToString();
                    wo_spl.InsertQuery(issue_id, int.Parse(spl_id));
                    spl_cnt++;
                }
            }
            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
                  Request.QueryString["ISSUE_ID"]);
            Master.ShowSuccess("Spools Added to MIV " + miv_no + " :" + spl_cnt);
        }
        catch(Exception ex)
        {
            Master.ShowError("Error:" + ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_Spools.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"] + "&WO_ID=" + Request.QueryString["WO_ID"]);
    }
}