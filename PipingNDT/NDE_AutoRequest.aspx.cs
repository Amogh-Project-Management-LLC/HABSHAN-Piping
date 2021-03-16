using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsNDETableAdapters;

public partial class PipingNDT_NDE_AutoRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string nde_req_no = WebTools.GetExpr("NDE_REQ_NO", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" +Request.QueryString["NDE_REQ_ID"]);
      
        Master.HeadingMessage = "Add Joints to (" + nde_req_no + ")";
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("NDE_RequestJoints.aspx?NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"] + "&SC_ID=" + Request.QueryString["SC_ID"]);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            VIEW_ADAPTER_NDE_JOINTSTableAdapter nde_jnts = new VIEW_ADAPTER_NDE_JOINTSTableAdapter();
            int nde_req_id = int.Parse(Request.QueryString["NDE_REQ_ID"]);
            int nde_type_id = int.Parse(Request.QueryString["NDE_TYPE_ID"]);
            int proj_id = int.Parse(Session["PROJECT_ID"].ToString());
            int jnt_cnt = 0;
            foreach (GridItem item in NDEAutoGrid.MasterTableView.Items)
            {
                GridDataItem dataitem = (GridDataItem)item;
                if (dataitem.Selected)
                {
                    string jnt_id = dataitem.GetDataKeyValue("JOINT_ID").ToString();
                    nde_jnts.InsertQuery(proj_id,nde_req_id, int.Parse(jnt_id),nde_type_id);
                    jnt_cnt++;
                }
            }
            string nde_req_no = WebTools.GetExpr("NDE_REQ_NO", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" +
                  Request.QueryString["NDE_REQ_ID"]);
            NDEAutoGrid.Rebind();
            Master.ShowSuccess("Joints Added to NDE Request " + nde_req_no + " :" + jnt_cnt);

        }
        catch (Exception ex)
        {
            Master.ShowError("Error:" + ex.Message);
        }

    }
}