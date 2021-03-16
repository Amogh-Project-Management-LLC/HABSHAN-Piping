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
using dsNDETableAdapters;
using Telerik.Web.UI;

public partial class WeldingInspec_NDE_RequestJoints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {     
            string nde_req = WebTools.GetExpr("NDE_REQ_NO", "PIP_NDE_REQUEST", "NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
            Master.HeadingMessage = "NDT Request <br/>" + nde_req;

            Master.AddModalPopup("~/PipingNDT/NDE_RequestJointsNew.aspx?NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"] + "&SC_ID=" + Request.QueryString["SC_ID"], btnEntry.ClientID, 450, 550);
            Master.RadGridList = RadGrid1.ClientID;
        }
    }
    protected void btnAddJoint_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_NDE_JOINTSTableAdapter adapter = new VIEW_ADAPTER_NDE_JOINTSTableAdapter();
        try
        {
            adapter.InsertQuery(Decimal.Parse(Session["PROJECT_ID"].ToString()),
                Decimal.Parse(Request.QueryString["NDE_REQ_ID"]),
                Decimal.Parse(cboNewJoint.SelectedValue),
                decimal.Parse(Request.QueryString["NDE_TYPE_ID"]));

            RadGrid1.DataBind();

            Master.ShowSuccess(cboNewJoint.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
        finally
        {
            adapter.Dispose();
        }
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        Update_JointsDropDown();
    }

    private void Update_JointsDropDown()
    {
        //1	  RT1   NDE-RT1
        //2   RT2   NDE-RT2
        //3	  PT    NDE-PT
        //5	  MT    NDE-MT
        //7	  PWHT  NDE-PWHT
        //8	  HT    NDE-HT
        //9	  PMI   NDE-PMI
        //10  FT	NDE-FT
        //11  LT	NDE-LT
        //12  UT	NDE-UT
        
        if (IsPostBack)
        {
            string nde_type_id = Request.QueryString["NDE_TYPE_ID"];
            string sql = "SELECT JOINT_ID, JOINT_TITLE " +
                "FROM VIEW_JOINTS_FOR_NDE_REQ " +
                "WHERE (ISO_TITLE1 = :ISO_TITLE1) AND (REWORK_CODE = :REWORK_CODE OR :REWORK_CODE LIKE '%RS%')";

            sql += " AND (JOINT_ID NOT IN " +
                "(SELECT DISTINCT JOINT_ID FROM PIP_NDE_REQUEST_JOINTS WHERE ((PASS_FLG_ID=1 OR NDE_DATE IS NULL) AND REWORK_CODE = :REWORK_CODE) AND NDE_TYPE_ID=:NDE_TYPE_ID)" +
                ")";

            switch (Request.QueryString["NDE_TYPE_ID"])
            {

                case "1":
                    //RT1
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL) AND (RT>0)";
                    break;

                case "2":
                    //RT2
                    //AND PWHT DONE
                    newjointDataSource.SelectCommand = sql +
                        " AND (WELD_DATE IS NOT NULL) AND (RT>0) AND " +
                        "JOINT_ID IN (SELECT JOINT_ID FROM PIP_NDE_REQUEST_JOINTS WHERE NDE_TYPE_ID=7 AND PASS_FLG_ID=1)";
                    break;

                case "3":
                    newjointDataSource.SelectCommand = sql + " AND (PT<>0)";
                    break;

                case "5":
                    newjointDataSource.SelectCommand = sql + " AND (MT<>0)";
                    break;

                case "7":
                    //PWHT
                    //CHECK RT1 IS DONE?
                    newjointDataSource.SelectCommand = sql +
                        " AND (WELD_DATE IS NOT NULL) AND (PWHT='Y') AND " +
                        "(RT < 100 OR (RT = 100 AND JOINT_ID IN (SELECT JOINT_ID FROM PIP_NDE_REQUEST_JOINTS WHERE NDE_TYPE_ID=1 AND PASS_FLG_ID=1)))";
                    break;

                case "8":
                    //HT
                    //CHECK RT1 IS DONE?
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL)";
                    break;

                case "9":
                    //PMI
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL) AND (PMI>0)";
                    break;

                case "10":
                    //FT
                    newjointDataSource.SelectCommand = sql + " AND (NOT (WELD_DATE IS NULL))";
                    break;

                case "11":
                    //LT
                    newjointDataSource.SelectCommand = sql + " AND (NOT (WELD_DATE IS NULL))";
                    break;
            }

            sql += " ORDER BY JOINT_TITLE";

           

            cboNewJoint.Items.Clear();
            newjointDataSource.DataBind();
        }
    }

    

   
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("NDE_Request.aspx?NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"]);
    }

    protected void RadGrid1_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
            return;
        }
    }
    protected void ddReworkCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        Update_JointsDropDown();
    }
    protected void cboNewJoint_DataBinding(object sender, EventArgs e)
    {
        //cboNewJoint.Items.Clear();
    }
    protected void ddReworkCode_DataBinding(object sender, EventArgs e)
    {
        //ddReworkCode.Items.Clear();
        //ddReworkCode.Items.Add(new ListItem("-", "-"));
    }

    protected void btnAutoRequest_Click(object sender, EventArgs e)
    {
        Response.Redirect("NDE_AutoRequest.aspx?NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" +Request.QueryString["NDE_TYPE_ID"]+ "&SC_ID=" + Request.QueryString["SC_ID"]);
    }

    protected void btnManualRequest_Click(object sender, EventArgs e)
    {
        Response.Redirect("NDE_ManualRequest.aspx?NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"] + "&SC_ID=" + Request.QueryString["SC_ID"]);
    }


    protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == "Delete")
        {
            if (!WebTools.UserInRole("PIP_WIC_DELETE"))
            {
                e.Canceled = true;
                Master.ShowWarn("Access Denied!");
                return;
            }
            GridDataItem item = e.Item as GridDataItem;
            string nde_item_id = item.GetDataKeyValue("NDE_ITEM_ID").ToString();
            string nde_rep = WebTools.GetExpr("NDE_REP_NO", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + nde_item_id);
            if (nde_rep.Length > 0)
            {
                e.Canceled = true;
                Master.ShowError("NDE Report is updated, Cannot delete joint now!");
                return;
            }
        }
    }

}