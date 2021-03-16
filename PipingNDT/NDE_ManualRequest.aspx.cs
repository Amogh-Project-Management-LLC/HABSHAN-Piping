using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsNDETableAdapters;
using System.Data;

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

       


      //  Master.ShowMessage(jntsDataSource.SelectCommand);
        int nde_type_id = int.Parse(Request.QueryString["NDE_TYPE_ID"].ToString());
        DataTable jnts_datatable = ((DataView)jntsDataSource.Select(DataSourceSelectArguments.Empty)).Table;

        
        Session.Add("JNTSDataTable", jnts_datatable);
        //FUNCTION CALL
        DataTable line_Status_DT= get_Line_Status(jnts_datatable, nde_type_id);
        //FUNCTION CALL
        set_color(jnts_datatable,nde_type_id);
        lineGrid.DataSource = line_Status_DT;
        lineGrid.DataBind();
        lineGrid.Rebind();
        ViewState["0"] = LineWiseDataSource.SelectCommand;

       
    }

    protected void set_color(DataTable jnt_dt,int nde_type_id)
    {

       switch(nde_type_id)
        {
            case 1:
            case 12:
                foreach (RadListBoxItem item in From_Joints.Items)
                {


                    var results = from jntrow in jnt_dt.AsEnumerable()
                                  where jntrow.Field<decimal>("JOINT_ID") == decimal.Parse(item.Value.ToString())
                                  select jntrow;
                    DataView jntrowview = results.AsDataView();
                    foreach(DataRowView viewrow in jntrowview)
                    {
                        DataRow row = viewrow.Row;
                       if( int.Parse(row["RT1_DONE"].ToString())==1)
                        {
                            item.BackColor = System.Drawing.Color.LightGreen;
                        }
                       
                        if (int.Parse(row["RT1_REJ"].ToString()) == 1)
                        {
                            item.BackColor = System.Drawing.Color.Red;
                        }
                        if (int.Parse(row["RT1_RSHT"].ToString()) == 1)
                        {
                            item.BackColor = System.Drawing.Color.MediumOrchid;
                        }
                        if((int.Parse(row["RT1_REP_NDE_BAL"].ToString())==1 || int.Parse(row["JNT_REV_ID"].ToString())==2)&&(int.Parse(row["RT1_RQSTD"].ToString()) != 1))
                        {
                            item.BackColor = System.Drawing.Color.LightCoral;
                        }
                        if (int.Parse(row["RT1_RQSTD"].ToString()) == 1 && int.Parse(row["RT1_DONE"].ToString())==0 && int.Parse(row["RT1_REJ"].ToString())==0 && int.Parse(row["RT1_RSHT"].ToString()) == 0)
                        {
                            item.BackColor = System.Drawing.Color.Yellow;
                        }
                      
                    }
                  
                }
                break;
        }
       

    }

    protected DataTable get_Line_Status(DataTable dt,int nde_type_id)
    {
       
        DataTable dtgroup = new DataTable();

        switch (nde_type_id)
        {
            
            case 1:
            case 12:

              var grouped1 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    rt = d.Field<decimal>("RT"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
              .Select(x => new {
                  Line = x.Key.line,
                  RT = x.Key.rt,
                  SHOP_SC = x.Key.shop_sc,
                  FIELD_SC = x.Key.field_sc,
                  Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("RT1_REQRD")) * x.Key.rt / 100),
                  Q2 = x.Sum(r => r.Field<decimal>("RT1_RQSTD")),
                  Q3 = x.Sum(r => r.Field<decimal>("RT1_DONE")),
                  Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("RT1_REQRD")) * x.Key.rt / 100)) - x.Sum(r => r.Field<decimal>("RT1_DONE"))
              });
               
                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("RT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("RT1_REQRD", typeof(decimal));
                dtgroup.Columns.Add("RT1_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("RT1_DONE", typeof(decimal));
                dtgroup.Columns.Add("RT1_BAL", typeof(decimal));
                foreach (var item in grouped1)
                {
                    dtgroup.Rows.Add(item.Line, item.RT, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }
              
                break;
            case 2:
            case 13:

                var grouped2 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    rt = d.Field<decimal>("RT"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
                .Select(x => new {
                    Line = x.Key.line,
                    RT = x.Key.rt,
                    SHOP_SC = x.Key.shop_sc,
                    FIELD_SC = x.Key.field_sc,
                    Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("RT2_REQRD")) * x.Key.rt / 100),
                    Q2 = x.Sum(r => r.Field<decimal>("RT2_RQSTD")),
                    Q3 = x.Sum(r => r.Field<decimal>("RT2_DONE")),
                    Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("RT2_REQRD")) * x.Key.rt / 100)) - x.Sum(r => r.Field<decimal>("RT2_DONE"))
                });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("RT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("RT2_REQRD", typeof(decimal));
                dtgroup.Columns.Add("RT2_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("RT2_DONE", typeof(decimal));
                dtgroup.Columns.Add("RT2_BAL", typeof(decimal));
                foreach (var item in grouped2)
                {
                    dtgroup.Rows.Add(item.Line, item.RT, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }

                break;
            case 3:

                var grouped3 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    pt = d.Field<decimal>("PT"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
               .Select(x => new {
                   Line = x.Key.line,
                   PT = x.Key.pt,
                   SHOP_SC = x.Key.shop_sc,
                   FIELD_SC = x.Key.field_sc,
                   Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("PT_REQRD")) * x.Key.pt / 100),
                   Q2 = x.Sum(r => r.Field<decimal>("PT_RQSTD")),
                   Q3 = x.Sum(r => r.Field<decimal>("PT_DONE")),
                   Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("PT_REQRD")) * x.Key.pt / 100)) - x.Sum(r => r.Field<decimal>("PT_DONE"))
               });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("PT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("PT_REQRD", typeof(decimal));
                dtgroup.Columns.Add("PT_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("PT_DONE", typeof(decimal));
                dtgroup.Columns.Add("PT_BAL", typeof(decimal));
                foreach (var item in grouped3)
                {
                    dtgroup.Rows.Add(item.Line, item.PT, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }
                break;
            case 5:
                var grouped5 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    mt = d.Field<decimal>("MT"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
               .Select(x => new {
                   Line = x.Key.line,
                   MT = x.Key.mt,
                   SHOP_SC = x.Key.shop_sc,
                   FIELD_SC = x.Key.field_sc,
                   Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("MT_REQRD")) * x.Key.mt / 100),
                   Q2 = x.Sum(r => r.Field<decimal>("MT_RQSTD")),
                   Q3 = x.Sum(r => r.Field<decimal>("MT_DONE")),
                   Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("MT_REQRD")) * x.Key.mt / 100)) - x.Sum(r => r.Field<decimal>("MT_DONE"))
               });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("PT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("MT_REQRD", typeof(decimal));
                dtgroup.Columns.Add("MT_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("MT_DONE", typeof(decimal));
                dtgroup.Columns.Add("MT_BAL", typeof(decimal));
                foreach (var item in grouped5)
                {
                    dtgroup.Rows.Add(item.Line, item.MT, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }
              
                break;
            case 7:

                var grouped7 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
              
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
           .Select(x => new {
               Line = x.Key.line,
               SHOP_SC = x.Key.shop_sc,
               FIELD_SC = x.Key.field_sc,
               Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("PWHT_REQRD"))),
               Q2 = x.Sum(r => r.Field<decimal>("PWHT_RQSTD")),
               Q3 = x.Sum(r => r.Field<decimal>("PWHT_DONE")),
               Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("PWHT_REQRD")))) - x.Sum(r => r.Field<decimal>("PWHT_DONE"))
           });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("PT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("PWHT_REQRD", typeof(decimal));
                dtgroup.Columns.Add("PWHT_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("PWHT_DONE", typeof(decimal));
                dtgroup.Columns.Add("PWHT_BAL", typeof(decimal));
                foreach (var item in grouped7)
                {
                    dtgroup.Rows.Add(item.Line, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }

 
                break;
            case 8:
                var grouped8 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    ht = d.Field<decimal>("HT"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
             .Select(x => new {
                 Line = x.Key.line,
                 HT = x.Key.ht,
                 SHOP_SC = x.Key.shop_sc,
                 FIELD_SC = x.Key.field_sc,
                 Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("HT_REQRD")) * x.Key.ht / 100),
                 Q2 = x.Sum(r => r.Field<decimal>("HT_RQSTD")),
                 Q3 = x.Sum(r => r.Field<decimal>("HT_DONE")),
                 Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("HT_REQRD")) * x.Key.ht / 100)) - x.Sum(r => r.Field<decimal>("HT_DONE"))
             });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("HT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("HT_REQRD", typeof(decimal));
                dtgroup.Columns.Add("HT_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("HT_DONE", typeof(decimal));
                dtgroup.Columns.Add("HT_BAL", typeof(decimal));
                foreach (var item in grouped8)
                {
                    dtgroup.Rows.Add(item.Line, item.HT, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }
           
                break;
            case 9:

                var grouped9 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    pmi = d.Field<decimal>("PMI"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
                   .Select(x => new {
                       Line = x.Key.line,
                       PMI = x.Key.pmi,
                       SHOP_SC = x.Key.shop_sc,
                       FIELD_SC = x.Key.field_sc,
                       Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("PMI_REQRD")) * x.Key.pmi / 100),
                       Q2 = x.Sum(r => r.Field<decimal>("PMI_RQSTD")),
                       Q3 = x.Sum(r => r.Field<decimal>("PMI_DONE")),
                       Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("PMI_REQRD")) * x.Key.pmi / 100)) - x.Sum(r => r.Field<decimal>("PMI_DONE"))
                   });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("PMI", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("PMI_REQRD", typeof(decimal));
                dtgroup.Columns.Add("PMI_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("PMI_DONE", typeof(decimal));
                dtgroup.Columns.Add("PMI_BAL", typeof(decimal));
                foreach (var item in grouped9)
                {
                    dtgroup.Rows.Add(item.Line, item.PMI, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }


               
                break;
            case 10:
                var grouped10 = dt.AsEnumerable().GroupBy(d => new
                {
                    line = d.Field<string>("LINE_NO"),
                    ft = d.Field<decimal>("FT"),
                    shop_sc = d.Field<string>("SHOP_SC"),
                    field_sc = d.Field<string>("FIELD_SC")

                })
               .Select(x => new {
                   Line = x.Key.line,
                   FT = x.Key.ft,
                   SHOP_SC = x.Key.shop_sc,
                   FIELD_SC = x.Key.field_sc,
                   Q1 = Math.Ceiling(x.Sum(r => r.Field<decimal>("FT_REQRD")) * x.Key.ft / 100),
                   Q2 = x.Sum(r => r.Field<decimal>("FT_RQSTD")),
                   Q3 = x.Sum(r => r.Field<decimal>("FT_DONE")),
                   Q4 = (Math.Ceiling(x.Sum(r => r.Field<decimal>("FT_REQRD")) * x.Key.ft / 100)) - x.Sum(r => r.Field<decimal>("FT_DONE"))
               });

                dtgroup.Columns.Add("LINE_NO", typeof(string));
                dtgroup.Columns.Add("FT", typeof(string));
                dtgroup.Columns.Add("SHOP_SC", typeof(string));
                dtgroup.Columns.Add("FIELD_SC", typeof(string));
                dtgroup.Columns.Add("FT_REQRD", typeof(decimal));
                dtgroup.Columns.Add("FT_RQSTD", typeof(decimal));
                dtgroup.Columns.Add("FT_DONE", typeof(decimal));
                dtgroup.Columns.Add("FT_BAL", typeof(decimal));
                foreach (var item in grouped10)
                {
                    dtgroup.Rows.Add(item.Line, item.FT, item.SHOP_SC, item.FIELD_SC, item.Q1, item.Q2, item.Q3, item.Q4);
                }
                break;
        }
        return dtgroup;
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (To_Joints.Items.Count == 0)
        {
            Master.ShowMessage("No Joint selected!" + ViewState["0"].ToString());
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
                lineGrid.DataBind();
             
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
        Response.Redirect("NDE_RequestJoints.aspx?NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"] + "&SC_ID=" + Request.QueryString["SC_ID"]);
    }


    protected void From_Joints_Transferred(object sender, RadListBoxTransferredEventArgs e)
    {
        if (e.Items.Count >= 1 && e.SourceListBox.ClientID.Contains("From_Joints"))
        {
            DataTable jntsDT = Session["JNTSDataTable"] as DataTable;
            foreach (RadListBoxItem item in e.Items)
            {
                DataRow dr = jntsDT.Select("JOINT_ID=" + item.Value).First();

                dr["RT1_RQSTD"] = 1;
            }


            //FUNCTION CALL
            DataTable line_Status_DT = get_Line_Status(jntsDT, int.Parse(Request.QueryString["NDE_TYPE_ID"].ToString()));
            //FUNCTION CALL

            lineGrid.DataSource = line_Status_DT;
            lineGrid.DataBind();
            lineGrid.Rebind();
        }
        if (e.Items.Count >= 1 && e.SourceListBox.ClientID.Contains("To_Joints"))
        {
            DataTable jntsDT = Session["JNTSDataTable"] as DataTable;
            foreach (RadListBoxItem item in e.Items)
            {
                DataRow dr = jntsDT.Select("JOINT_ID=" + item.Value).First();

                dr["RT1_RQSTD"] = 0;
            }


            //FUNCTION CALL
            DataTable line_Status_DT = get_Line_Status(jntsDT, int.Parse(Request.QueryString["NDE_TYPE_ID"].ToString()));
            //FUNCTION CALL

            lineGrid.DataSource = line_Status_DT;
            lineGrid.DataBind();
            lineGrid.Rebind();
        }

    }

    protected void From_Joints_Transferring(object sender, RadListBoxTransferringEventArgs e)
    {
        int cnt = 0;
        foreach (RadListBoxItem item in e.Items)
        {
            if (item.BackColor.Name == "LightGreen" || item.BackColor.Name == "Red" || item.BackColor.Name == "MediumOrchid" || item.BackColor.Name == "Yellow" )
            {            
                e.Cancel = true;
                cnt++;
            }
        }
        if(cnt>0)
        {
            Master.ShowWarn("You cannot move Requested,Accepted,Rejected,Reshoot Joints to Request!");
        }

    }
}



