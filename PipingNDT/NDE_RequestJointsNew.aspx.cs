using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsNDETableAdapters;
public partial class PipingNDT_NDE_RequestJointsNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string nde_req = WebTools.GetExpr("NDE_REQ_NO", "PIP_NDE_REQUEST", "NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
            Master.HeadingMessage("Joint NDE Request : " + nde_req);
            Update_JointsDropDown();

        }
       
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        VIEW_ADAPTER_NDE_JOINTSTableAdapter adapter = new VIEW_ADAPTER_NDE_JOINTSTableAdapter();
        try
        {
            string ISSUE_DATE;
            string WELD_DATE;
            DateTime weld_date;

            ISSUE_DATE = WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
            DateTime issue_date = DateTime.Parse(ISSUE_DATE.ToString());
            //////////////////////swn check////////////////////////////////////
            string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + rcbIsoJnt.SelectedValue.ToString());
            int swn_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_SWN_SPOOL WHERE SPL_ID=" + spl_id));
            int rel_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_REL_REQ_SPL WHERE SPL_ID=" + spl_id));
            string pwht = WebTools.ExeSql("SELECT NVL(PWHT,'N') FROM PIP_SPOOL_JOINTS WHERE JOINT_ID=" + rcbIsoJnt.SelectedValue.ToString());

            int nde_type_id = int.Parse(Request.QueryString["NDE_TYPE_ID"]);
            if (swn_cnt > rel_cnt)
            {
                Master.show_error("Spool Under SWN!");
                return;
            }
            ///////////////////////////////////////////////////////////////////
            /////////////////////////////Rejected Joint check//////////////////////////
            string r_joint=WebTools.GetExpr("joint_id", "PIP_NDE_REQUEST_JOINTS", " WHERE JOINT_ID=" + rcbIsoJnt.SelectedValue.ToString() + " and pass_flg_id=2 ");

            if (r_joint.Length > 0 && nde_type_id !=3 && nde_type_id != 5) 
            {
                WELD_DATE = WebTools.GetExpr("REPAIR_DATE", "PIP_JOINTS_REPAIR_DWR", " WHERE  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                if (WELD_DATE.Length <=0)
                {
                    Master.show_error("Joint not repaired!");
                    return;
                }
                if (WELD_DATE.Length > 0)
                {
                    weld_date = DateTime.Parse(WELD_DATE);
                    if (issue_date < weld_date)
                    {
                        Master.show_error("Issue Date is earlier than Repair Weld Date!");
                        return;
                    }
                }

            }
            else
            {
                WELD_DATE = WebTools.GetExpr("WELD_DATE", "PIP_SPOOL_JOINTS", " WHERE  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                if (WELD_DATE.Length <= 0)
                {
                    Master.show_error("joint not welded!");
                    return;
                }
                if (WELD_DATE.Length > 0)
                {
                    weld_date = DateTime.Parse(WELD_DATE);
                    if (issue_date < weld_date)
                    {
                        Master.show_error("Issue Date is earlier than  Weld Date!");
                        return;
                    }
                }
            }

            //check if already requested

           
            string old_request = WebTools.GetExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE  JOINT_ID = " + rcbIsoJnt.SelectedValue+" AND NDE_REQ_ID="+ Request.QueryString["NDE_REQ_ID"]+" AND NDE_TYPE_ID="+ Request.QueryString["NDE_TYPE_ID"]);

            if(old_request.Length>0)
            {
                Master.show_error("Joint Already Requested in Same Request");
                return;
            }

            
            //Only Request
            if (ddlStatus.SelectedValue.ToString() == "-1")
            {
                //pwht check
                if(pwht=="Y")
                {
                    if(nde_type_id==3 || nde_type_id == 5 || nde_type_id == 8 || nde_type_id == 11 || nde_type_id == 2 || nde_type_id == 13)
                    {
                        if(pwht_done()==false)
                        {
                            Master.show_error("PWHT Not yet done!");
                            return;
                        }
                        //pwht should be less than current issue date
                        if(pwht_date_chk()==true)
                        {
                            Master.show_error("PWHT Report date should be less than  current request issue date");
                            return;
                        }
                        
                    }
                    if(nde_type_id==1 || nde_type_id==10 || nde_type_id==12)
                    {
                        if(pwht_done()==true)
                        {
                            Master.show_error("PWHT already done");
                            return;
                        }
                        //pwht should be greater than  current issue date
                        if(pwht_date_chk()==false)
                        {
                            Master.show_error("PWHT Report Date should greater than  current request issue date ");
                            return;
                        }
                    }
                    if(nde_type_id==7)
                    {

                        //should be before RT-2/UT-2                    
                        string rt2_jnt_req = WebTools.GetExpr("NDE_REQ_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=2  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                        if(rt2_jnt_req.Length>0)
                        {
                         string rt2_req_dt=    WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID = " +rt2_jnt_req);
                         DateTime rt2_req_date = DateTime.Parse(rt2_req_dt);
                         if(rt2_req_date<issue_date)
                            {
                                Master.show_error("PWHT Request Date should be less than RT-2 Request Date");
                                return;
                            }
                        }
                        string ut2_jnt_req = WebTools.GetExpr("NDE_REQ_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=13  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                        if (ut2_jnt_req.Length > 0)
                        {
                            string ut2_req_dt = WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID = " + ut2_jnt_req);
                            DateTime ut2_req_date = DateTime.Parse(ut2_req_dt);
                            if (ut2_req_date < issue_date)
                            {
                                Master.show_error("PWHT Request Date should be less than UT-2 Request Date");
                                return;
                            }
                        }

                        

                    }

                }

                adapter.InsertQuery(Decimal.Parse(Session["PROJECT_ID"].ToString()),
                    Decimal.Parse(Request.QueryString["NDE_REQ_ID"]),
                    Decimal.Parse(rcbIsoJnt.SelectedValue),
                    decimal.Parse(Request.QueryString["NDE_TYPE_ID"]));
                Master.show_success("Joint added to Request");
            }
            //Request+Report
            else
            {
                string rep_date = txtReportDate.SelectedDate.ToString();
                DateTime report_date = DateTime.Parse(rep_date.ToString());

             

                if (report_date < issue_date)
                {
                    Master.show_error("Report Date is less than Issue Date!");
                    return;
                }



                //pwht check
                if (pwht == "Y")
                {
                    ///////////////////////////////////////issue date check with pwht report date/////////////////////////////////////
                    if (nde_type_id == 3 || nde_type_id == 5 || nde_type_id == 8 || nde_type_id == 11 || nde_type_id == 2 || nde_type_id == 13)
                    {
                        if (pwht_done() == false)
                        {
                            Master.show_error("PWHT Not yet done!");
                            return;
                        }
                        //pwht should be less than current issue date
                        if (pwht_date_chk() == true)
                        {
                            Master.show_error("PWHT Report date should be less than  current request issue date");
                            return;
                        }
                    }
                    if (nde_type_id == 1 || nde_type_id == 10 || nde_type_id == 12)
                    {
                        if (pwht_done() == true)
                        {
                            Master.show_error("PWHT already done");
                            return;
                        }
                        //pwht should be greater than  current issue date
                        if (pwht_date_chk() == false)
                        {
                            Master.show_error("PWHT Report Date should greater than  current request issue date ");
                            return;
                        }
                    }
                    if (nde_type_id == 7)
                    {
                
                        //PWHT REQ DATEshould be before RT-2/UT-2                    
                        string rt2_jnt_req = WebTools.GetExpr("NDE_REQ_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=2  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                        if (rt2_jnt_req.Length > 0)
                        {
                            string rt2_req_dt = WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID = " + rt2_jnt_req);
                            DateTime rt2_req_date = DateTime.Parse(rt2_req_dt);
                            if (rt2_req_date < issue_date)
                            {
                                Master.show_error("PWHT Request Date should be less than RT-2 Request Date");
                                return;
                            }
                        }
                        string ut2_jnt_req = WebTools.GetExpr("NDE_REQ_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=13  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                        if (ut2_jnt_req.Length > 0)
                        {
                            string ut2_req_dt = WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID = " + ut2_jnt_req);
                            DateTime ut2_req_date = DateTime.Parse(ut2_req_dt);
                            if (ut2_req_date < issue_date)
                            {
                                Master.show_error("PWHT Request Date should be less than UT-2 Request Date");
                                return;
                            }
                        }


                    }

                    ////////////////////////////report date chk with pwht report date////////////////////////////////////////
                    if (nde_type_id == 3 || nde_type_id == 5 || nde_type_id == 8 || nde_type_id == 11 || nde_type_id == 2 || nde_type_id == 13)
                    {               
                        //pwht report date should be less than current report date
                        if (pwht_rep_date_chk() == true)
                        {
                            Master.show_error("PWHT Report date should be less than  current request report date");
                            return;
                        }

                    }
                    if (nde_type_id == 1 || nde_type_id == 10 || nde_type_id == 12)
                    {
                        //pwht should be greater than  current issue date
                        if (pwht_rep_date_chk() == false)
                        {
                            Master.show_error("PWHT Report Date should greater than  current request report date ");
                            return;
                        }
                    }
                    if (nde_type_id == 7)
                    {
                        //PWHT REPORT should be before RT-2/UT-2
                        string rt2_nde_dt = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=2 and NDE_DATE IS NOT NULL AND   JOINT_ID = " + rcbIsoJnt.SelectedValue);
                        if (rt2_nde_dt.Length > 0)
                        {
                            DateTime rt2_nde_date = DateTime.Parse(rt2_nde_dt);
                            if (rt2_nde_date < report_date)
                            {
                                Master.show_error("PWHT Report Date should be less than RT-2 Report Date");
                                return;
                            }
                        }
                        string ut2_nde_dt = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=13 AND NDE_DATE IS NOT NULL  JOINT_ID = " + rcbIsoJnt.SelectedValue);
                        if (ut2_nde_dt.Length > 0)
                        {

                            DateTime ut2_nde_date = DateTime.Parse(ut2_nde_dt);
                            if (ut2_nde_date < issue_date)
                            {
                                Master.show_error("PWHT Report Date should be less than UT-2 Report Date");
                                return;
                            }
                        }

                    }
                
                    //////////////////////////////////////////////////////////////////////////////////////////////////////

                }

                int film1, film2;
                if (txtFilm1.Text.Length > 0)
                {
                    film1 = int.Parse(txtFilm1.Text);
                }
                else
                {
                    film1 = 0;
                }
                if (txtFilm2.Text.Length > 0)
                {
                    film2 = int.Parse(txtFilm2.Text);
                }
                else
                {
                    film2 = 0;
                }

                adapter.InsertNDEReqRep(Decimal.Parse(Session["PROJECT_ID"].ToString()),
                 Decimal.Parse(Request.QueryString["NDE_REQ_ID"]),
                 Decimal.Parse(rcbIsoJnt.SelectedValue),
                 decimal.Parse(Request.QueryString["NDE_TYPE_ID"]),
                 int.Parse(ddlStatus.SelectedValue),
                 txtReportNo.Text,
                 txtReportDate.SelectedDate,
                 film1,
                 film2
                 );

                Master.show_success("NDE Request and Report updated for the joint!");

            }

        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            adapter.Dispose();
        }
    }

    private bool pwht_done()
    {
        string pwht_chk = WebTools.GetExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE PASS_FLG_ID=1 AND  JOINT_ID = " + rcbIsoJnt.SelectedValue);
        if(pwht_chk.Length<=0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    private bool pwht_date_chk()
    {
        string pwht_date = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=7 AND PASS_FLG_ID=1 AND JOINT_ID = " + rcbIsoJnt.SelectedValue.ToString());
       
        string req_date = WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE  ISSUE_ID = " + Request.QueryString["NDE_REQ_ID"]);
        DateTime pwht_dt;
        DateTime req_dt = DateTime.Parse(req_date);

        if (pwht_date.Length <= 0)
            return false;
        else
        {
            pwht_dt = DateTime.Parse(pwht_date);
            if (pwht_dt > req_dt)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
      
    }

    private bool pwht_rep_date_chk()
    {
        string pwht_date = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=7 AND PASS_FLG_ID=1 AND JOINT_ID = " + rcbIsoJnt.SelectedValue.ToString());

        string rep_date = txtReportDate.SelectedDate.ToString();
        DateTime pwht_dt;
        DateTime rep_dt = DateTime.Parse(rep_date);

        if (pwht_date.Length <= 0)
            return false;
        else
        {
            pwht_dt = DateTime.Parse(pwht_date);
            if (pwht_dt > rep_dt)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

    }

    private void check_100_percent_nde()
    {

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
        //13  UT2   NDE-UT2


        string nde_type_id = Request.QueryString["NDE_TYPE_ID"];
            string sc_id = Request.QueryString["SC_ID"];
            string sql = "SELECT JOINT_ID, JOINT_TITLE " +
                "FROM VIEW_JOINTS_FOR_NDE_REQ " +
                "WHERE SUB_CON_ID="+sc_id;

            sql += " AND (JOINT_ID NOT IN " +
                "(SELECT DISTINCT JOINT_ID FROM PIP_NDE_REQUEST_JOINTS WHERE ((PASS_FLG_ID=1 OR NDE_DATE IS NULL)) AND NDE_TYPE_ID=" +nde_type_id+"))";

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
                  case "15":
                  //PAUT
                  newjointDataSource.SelectCommand = sql + " AND (NOT (WELD_DATE IS NULL))";
                  break;
        }

            sql += " ORDER BY JOINT_TITLE";

     

            rcbIsoJnt.Items.Clear();
        //rcbIsoJnt.Items.Add(new Telerik.Web.UI.RadComboBoxItem("Iso/Joint/Rev code/CRW code",""));
        
            newjointDataSource.DataBind();
        
    }

}