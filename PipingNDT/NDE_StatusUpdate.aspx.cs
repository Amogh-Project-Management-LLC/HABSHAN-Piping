using System;

public partial class PipingNDT_NDE_StatusUpdate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage ( "Joint NDE Status Update");
            int nde_type_id = int.Parse(WebTools.GetExpr("NDE_TYPE_ID", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]));
            string Sql_DSPassFlag = "SELECT PASS_FLG_ID, PASS_FLG FROM PIP_NDE_PASS_FLG WHERE PASS_FLG<>'RESHOOT'"; 
            PassFlgDataSource.DataBind();
            switch (nde_type_id)
            {
                case 3:
                    row_PT_MT_ReportNo.Visible = true;
                    row_PT_MT_ReportDate.Visible = true;
                    lbl_PT_MT_ReportNo.Text = "PT Hot Report No.";
                    lbl_PT_MT_ReportDate.Text = "PT Hot Report Date";
                    break;
                case 5:
                    row_PT_MT_ReportNo.Visible = true;
                    row_PT_MT_ReportDate.Visible = true;
                    lbl_PT_MT_ReportNo.Text = "MT Hot Report No.";
                    lbl_PT_MT_ReportDate.Text = "MT Hot Report Date";
                    break;
                case 1:
                case 2:
                case 12:
                case 13:
                    row_film1.Visible = true;
                    row_film2.Visible = true;
                    Sql_DSPassFlag = "SELECT PASS_FLG_ID, PASS_FLG FROM PIP_NDE_PASS_FLG";
                    break;
            }
            PassFlgDataSource.SelectCommand = Sql_DSPassFlag;
            PassFlgDataSource.DataBind();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        /////////////////////////////////////////////////////////////////////////////
        try
        {
            string ISSUE_DATE;

            ISSUE_DATE = WebTools.GetExpr("ISSUE_DATE", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]);
            DateTime issue_date = DateTime.Parse(ISSUE_DATE.ToString());
            //////////////////////swn check////////////////////////////////////
            string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"]);
            int swn_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_SWN_SPOOL WHERE SPL_ID=" + spl_id));
            int rel_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_REL_REQ_SPL WHERE SPL_ID=" + spl_id));
            string pwht = WebTools.ExeSql("SELECT NVL(PWHT,'N') FROM PIP_SPOOL_JOINTS WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"]);

            int nde_type_id = int.Parse(WebTools.GetExpr("NDE_TYPE_ID", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"]));
            if (swn_cnt > rel_cnt)
            {
                Master.show_error("Spool Under SWN!");
                return;
            }

            // NDE Report
            string rep_date = txtRepDate.SelectedDate.ToString();
            DateTime report_date = DateTime.Parse(rep_date.ToString());

            if(report_date > System.DateTime.Today)
            {
                Master.show_error("Report Date is greater than Today!");
                return;
            }

            if (report_date < issue_date)
            {
                Master.show_error("Report Date is less than Issue Date!");
                return;
            }

            //pwht check
            if (pwht == "Y")
            {
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
                    string rt2_nde_dt = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=2 and NDE_DATE IS NOT NULL AND   JOINT_ID = " + Request.QueryString["JOINT_ID"]);
                    if (rt2_nde_dt.Length > 0)
                    {
                        DateTime rt2_nde_date = DateTime.Parse(rt2_nde_dt);
                        if (rt2_nde_date < report_date)
                        {
                            Master.show_error("PWHT Report Date should be less than RT-2 Report Date");
                            return;
                        }
                    }
                    string ut2_nde_dt = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=13 AND NDE_DATE IS NOT NULL  JOINT_ID = " + Request.QueryString["JOINT_ID"]);
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
            /////////////////////////////////////////////////////////////////////////////
            string sql;

            //Update nde status
            sql = "UPDATE PIP_NDE_REQUEST_JOINTS SET";
            if (txtRepNo.Text != "")
                sql += " NDE_REP_NO='" + txtRepNo.Text + "'";
            else
                sql += " NDE_REP_NO=NULL";

            if (!txtRepDate.IsEmpty)
                sql += ", NDE_DATE='" + txtRepDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "'";
            else
                sql += ", NDE_DATE=NULL";

            if (ddPassFlag.SelectedValue.ToString() != "")
                sql += ", PASS_FLG_ID=" + ddPassFlag.SelectedValue.ToString();
            else
                sql += ", PASS_FLG_ID=NULL";

            if (txtFilm1.Text != "")
                sql += ", TOTAL_FILM1=" + txtFilm1.Text;
            else
                sql += ", TOTAL_FILM1=NULL";

            if (txtFilm2.Text != "")
                sql += ", TOTAL_FILM2=" + txtFilm2.Text;
            else
                sql += ", TOTAL_FILM2=NULL";

            if (row_PT_MT_ReportNo.Visible)
            {
                sql += ",MT_PT_ROOT_REP_NO='" + txtPT_MT_ReportNo.Text + "'";
                if (!txtPT_MT_ReportDate.IsEmpty)
                    sql += ",MT_PT_ROOT_REP_DATE='" + txtPT_MT_ReportDate.SelectedDate.Value.ToString("dd-MMM-yyyy") + "'";
            }

            sql += " WHERE JOINT_ID=" + Request.QueryString["JOINT_ID"].ToString() + " AND NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"].ToString();

            WebTools.ExeSql(sql);
            //Master.ShowSuccess(sql);
            Master.show_success("Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
    private bool pwht_rep_date_chk()
    {
        string pwht_date = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_TYPE_ID=7 AND PASS_FLG_ID=1 AND JOINT_ID = " + Request.QueryString["JOINT_ID"]);

        string rep_date = txtRepDate.SelectedDate.ToString();
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
}