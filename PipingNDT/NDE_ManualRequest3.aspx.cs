using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsNDETableAdapters;

public partial class PipingNDT_NDE_ManualRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string nde_req = WebTools.GetExpr("NDE_REQ_NO", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" +Request.QueryString["NDE_REQ_ID"]);
        
        Master.HeadingMessage = "Add Joints to (" + nde_req + ")";



    }

    protected void ddlLineNo_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {

        string condition = "'";

        foreach (RadComboBoxItem item in rcbLineNO.CheckedItems)
        {
            condition += item.Value + "','";
        }
        if (condition.Length > 1)
            condition = condition.Substring(0, condition.Length - 2);
        else
            condition = "''";
        jntsDataSource.SelectCommand += " AND LINE_NO IN (" + condition + ")";
        From_Joints.DataSource = jntsDataSource;
        From_Joints.DataBind();


        int nde_type_id = int.Parse(Request.QueryString["NDE_TYPE_ID"].ToString());
        switch (nde_type_id)
        {
            case 1:
            case 12:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,RT AS RT_PERCENT,Round(Sum(RT1_REQRD) * RT / 100) AS RT1_Required,SUM(RT1_RQSTD) AS RT_REQUESTED,Sum(RT1_DONE) RT1_Done,Round(Sum(RT1_REQRD) * RT / 100)-SUM(RT1_RQSTD) AS RT1_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                   "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, RT, SC_ID, FIELD_SC_ID";
                break;
            case 2:
            case 13:

                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,RT AS RT_PERCENT,Round(Sum(RT2_REQRD) * RT / 100) AS RT2_Required,SUM(RT2_RQSTD) AS R2_REQUESTED,Sum(RT2_DONE) RT2_Done,Round(Sum(RT2_REQRD) * RT / 100)-SUM(RT2_RQSTD) AS RT2_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, RT, SC_ID, FIELD_SC_ID";
                break;
            case 3:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,PT AS PT_PERCENT,Round(Sum(PT_REQRD) * PT / 100) AS PT_Required,SUM(PT_RQSTD) AS PT_REQUESTED,Sum(PT_DONE) PT_Done,Round(Sum(PT_REQRD) * PT / 100)-SUM(PT_RQSTD) AS PT_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, PT, SC_ID, FIELD_SC_ID";
                break;
            case 5:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,MT AS MT_PERCENT,Round(Sum(MT_REQRD) * MT / 100) AS MT_Required,SUM(MT_RQSTD) AS MT_REQUESTED,Sum(MT_DONE) MT_Done,Round(Sum(MT_REQRD) * MT / 100)-SUM(MT_RQSTD) AS MT_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, MT, SC_ID, FIELD_SC_ID";
                break;
            case 7:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,Round(Sum(PWHT_REQRD)) AS PWHT_Required,SUM(PWHT_RQSTD) AS PWHT_REQUESTED,Sum(PWHT_DONE) PWHT_Done,Round(Sum(PWHT_REQRD)-SUM(PWHT_RQSTD) AS PWHT_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, SC_ID, FIELD_SC_ID";
                break;
            case 8:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,HT AS HT_PERCENT,Round(Sum(HT_REQRD) * HT / 100) AS HT_Required,SUM(HT_RQSTD) AS HT_REQUESTED,Sum(HT_DONE) HT_Done,Round(Sum(HT_REQRD) * HT / 100)-SUM(HT_RQSTD) AS HT_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, HT, SC_ID, FIELD_SC_ID";
                break;
            case 9:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,PMI AS PMI_PERCENT,Round(Sum(PMI_REQRD) * PMI / 100) AS PMI_Required,SUM(PMI_RQSTD) AS PMI_REQUESTED,Sum(PMI_DONE) PMI_Done,Round(Sum(PMI_REQRD) * PMI / 100)-SUM(PMI_RQSTD) AS PMI_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, PMI, SC_ID, FIELD_SC_ID";
                break;
            case 10:
                LineWiseDataSource.SelectCommand = " SELECT  LINE_NO,FT AS FT_PERCENT,Round(Sum(FT_REQRD) * FT / 100) AS FT_Required,SUM(FT_RQSTD) AS FT_REQUESTED,Sum(FT_DONE) FT_Done,Round(Sum(FT_REQRD) * FT / 100)-SUM(FT_RQSTD) AS FT_BALANCE " +
                                                   "  FROM " +
                                                   " VIEW_NDE_MANUAL_REQUEST_JNTS " +
                                                   " WHERE LINE_NO IN (" + condition + ") AND " +
                                                      "(((CAT_ID = 1 OR CAT_ID = 3) AND SC_ID =" + Request.QueryString["SC_ID"] + " AND WO_ID IS NOT NULL)" +
                                                   "OR((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = " + Request.QueryString["SC_ID"] + "))" +
                                                   " GROUP BY LINE_NO, FT, SC_ID, FIELD_SC_ID";
                break;
        }
        lineGrid.DataSource = LineWiseDataSource;
        lineGrid.DataBind();
        lineGrid.Rebind();
        ViewState["0"] = LineWiseDataSource.SelectCommand;



    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (To_Joints.Items.Count == 0)
        {
            Master.ShowMessage("No Spool selected!" + ViewState["0"].ToString());
            return;
        }
        VIEW_ADAPTER_NDE_JOINTSTableAdapter nde_jnts = new VIEW_ADAPTER_NDE_JOINTSTableAdapter();
        try
        {
            int cnt = 0;
            if (To_Joints.Items.Count > 0)
            {
                for (int i = 0; i < To_Joints.Items.Count; i++)
                {
                    nde_jnts.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), decimal.Parse(Request.QueryString["NDE_REQ_ID"]),decimal.Parse(To_Joints.Items[i].Value), decimal.Parse(Request.QueryString["NDE_TYPE_ID"]));
                    cnt++;
                }
           

                To_Joints.Items.Clear();
                string nde_req = WebTools.GetExpr("NDE_REQ_NO", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
                Master.ShowSuccess(cnt+": Joints added to NDE Request :"+nde_req);

                From_Joints.DataBind();
                LineWiseDataSource.SelectCommand = ViewState["0"].ToString();
                LineWiseDataSource.DataBind();
               // lineGrid.DataBind();

                lineGrid.DataBind();
                //    Response.Redirect(Request.RawUrl);
                Master.ShowSuccess(cnt + ": Joints added to NDE Request :" + nde_req);
            }
            else
            {
                Master.ShowMessage("No Joint selected!"+ ViewState["0"].ToString());
                return;
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            nde_jnts.Dispose();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {

    }

    protected void From_Joints_DataBound(object sender, EventArgs e)
    {
        foreach (RadListBoxItem item in From_Joints.Items)
        {
           
            if (item.Value == "1905")
                item.BackColor = System.Drawing.Color.Red;

            if (item.Value == "1906")

                item.BackColor = System.Drawing.Color.LightGreen;
        }
    }
}

