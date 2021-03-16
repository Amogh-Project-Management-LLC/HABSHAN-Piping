using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public partial class SelectionPage_data : System.Web.UI.Page
{
   
    string select_text="";
    int user_id = 0;
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["USER_NAME"].ToString().Length > 0)
        {
            user_id = int.Parse(WebTools.GetExpr("USER_ID", "USERS", "USER_NAME='" + Session["USER_NAME"] + "'"));
            
        }
        else
        {
            return;
        }
        if (!IsPostBack)
        {
            Master.HeadingMessage("Selection Page");
            
            string remove_query = "UPDATE SHEET_WISE_SELECTION_USER SET WHERE_QUERY='' WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"]
                + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id;
            WebTools.ExeSql(remove_query);
            
                string insert_query = "SELECT * FROM SHEET_WISE_SELECTION WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"] + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " ORDER BY EXPT_ID,SHEET_SEQ,SEQ";
                DataTable insert_dt = General_Functions.GetDataTable(insert_query);
            foreach (DataRow insert_row in insert_dt.Rows)
            {
                string user_exist = WebTools.GetExpr("SELECTION_UNIQ", "SHEET_WISE_SELECTION_USER", " WHERE EXPT_ID="
                 + Request.QueryString["EXPT_ID"] + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id
                 + " AND SELECTION_SEQ=" + insert_row["SEQ"]);
                if (user_exist.Length == 0)
                {
                    WebTools.ExeSql("INSERT INTO SHEET_WISE_SELECTION_USER (USER_ID, SELECTION_UNIQ, SHEET_SEQ, SELECTION_SEQ, EXPT_ID)" +
                                           "VALUES (" + user_id + "," + insert_row["UNIQ"] + "," + insert_row["SHEET_SEQ"] + "," + insert_row["SEQ"] +
                                           "," + insert_row["EXPT_ID"] + ")");
                }

            }
            
            
        }
        
        string query = "SELECT * FROM VIEW_SHEET_WISE_SELECTION_USER WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"]
            + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id+ " ORDER BY EXPT_ID,SHEET_SEQ,SEQ";


        DataTable q_dt = General_Functions.GetDataTable(query);
       
        foreach (DataRow q_row in q_dt.Rows)
        {
            string ddl_query = "";
            RadComboBox ddl = new RadComboBox();
            ddl.ID = q_row["UNIQ"].ToString();
            
            if (q_row["WHERE_QUERY"].ToString().Length==0)
            {
                if (q_row["FIXED_QUERY"].ToString().Length > 0)
                {
                    ddl_query = q_row["SQL_QUERY"].ToString() + " WHERE " + q_row["FIXED_QUERY"].ToString()+ " " + q_row["ORDER_BY"].ToString();
                }
                else
                {
                    ddl_query = q_row["SQL_QUERY"].ToString() + " " + q_row["ORDER_BY"].ToString();

                }
              
            }
            else
            {
                if (q_row["FIXED_QUERY"].ToString().Length > 0)
                {
                    ddl_query = q_row["SQL_QUERY"].ToString() + " WHERE " + q_row["WHERE_QUERY"].ToString() + " AND " + q_row["FIXED_QUERY"].ToString()
                        + " " + q_row["ORDER_BY"].ToString();
                }
                else
                {
                    ddl_query = q_row["SQL_QUERY"].ToString() + " WHERE " + q_row["WHERE_QUERY"].ToString() + " " + q_row["ORDER_BY"].ToString();
                }
                    
            }
           

            DataTable ddl_dt = General_Functions.GetDataTable(ddl_query);
            ddl.DataSource = ddl_dt;
            ddl.DataTextField = q_row["TEXT_FIELD"].ToString();
            ddl.DataValueField = q_row["VALUE_FIELD"].ToString();
            ddl.AutoPostBack = true;
            ddl.AllowCustomText = true;
            ddl.CausesValidation = false;
            ddl.EnableAutomaticLoadOnDemand = true;
            ddl.ItemsPerRequest = 10;
            ddl.DropDownWidth=250;
            ddl.Width = 200;
            ddl.Height = 200;
            ddl.ShowMoreResultsBox = true;
            ddl.EnableVirtualScrolling = true;
            ddl.EmptyMessage = q_row["EMPTY_MSG"].ToString();
            ddl.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(OnSelectedIndexChanged);
            PlHolder.Controls.Add(ddl);
            Literal lt = new Literal();
            lt.Text = "<br /><br />";
            PlHolder.Controls.Add(lt);
            
            
        }
    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
   
        RadComboBox ddl = (RadComboBox)sender;
        
        string ID = ddl.ID;
        string VALUE_FIELD = WebTools.GetExpr("VALUE_FIELD", "VIEW_SHEET_WISE_SELECTION_USER", "UNIQ=" + ID +" AND USER_ID="+user_id);
        string prev_select = WebTools.GetExpr("WHERE_QUERY", "VIEW_SHEET_WISE_SELECTION_USER", "UNIQ=" + ID + " AND USER_ID=" + user_id);
        
        int seq = int.Parse(WebTools.GetExpr("SEQ", "VIEW_SHEET_WISE_SELECTION_USER", "UNIQ=" + ID + " AND USER_ID=" + user_id));
        int sheet_seq = int.Parse(WebTools.GetExpr("SHEET_SEQ", "VIEW_SHEET_WISE_SELECTION_USER", "UNIQ=" + ID + " AND USER_ID=" + user_id));
        //seq = seq + 1;
        if (ddl.SelectedValue.Length > 0)
        {
            if (prev_select.Length > 0)
            {
                string query = "UPDATE SHEET_WISE_SELECTION_USER SET WHERE_QUERY='" + prev_select.ToString().Replace("'", "''")
                    + " AND " + VALUE_FIELD + " LIKE ''" + ddl.SelectedValue + "''" + "' WHERE  EXPT_ID = "
                    + Request.QueryString["EXPT_ID"] + " AND SHEET_SEQ=" + sheet_seq + " AND USER_ID=" + user_id;
                WebTools.ExeSql(query);

            }
            else
            {
                string query = "UPDATE SHEET_WISE_SELECTION_USER SET WHERE_QUERY='" + VALUE_FIELD + " LIKE ''" + ddl.SelectedValue + "''"
                    + "' WHERE  EXPT_ID = " + Request.QueryString["EXPT_ID"] + " AND SHEET_SEQ=" + sheet_seq + " AND USER_ID=" + user_id;
                WebTools.ExeSql(query);
            }
        }
        else
        {
            if (prev_select.Length > 0)
            {
                string query = "UPDATE SHEET_WISE_SELECTION_USER SET WHERE_QUERY='" + prev_select.ToString().Replace("'", "''")
                     + "' WHERE  EXPT_ID = " + Request.QueryString["EXPT_ID"] + " AND SHEET_SEQ=" + sheet_seq + " AND USER_ID=" + user_id;
                WebTools.ExeSql(query);

            }
            else
            {
                string query = "UPDATE SHEET_WISE_SELECTION_USER SET WHERE_QUERY=''" + " WHERE  EXPT_ID = " + Request.QueryString["EXPT_ID"] + " AND SHEET_SEQ=" + sheet_seq + " AND USER_ID=" + user_id;
                WebTools.ExeSql(query);
            }
        }

        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if(Request.QueryString["SEQ"].Length == 0)
        {
            Master.show_error("Please Select Sheet Report");
        }
        else
        {
                int count = 1;
                string query = "SELECT * FROM VIEW_SHEET_WISE_SELECTION_USER WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"]
                    + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id + " ORDER BY EXPT_ID,SHEET_SEQ,SEQ";

                DataTable q_dt = General_Functions.GetDataTable(query);
                foreach (DataRow q_row in q_dt.Rows)
                {
                    RadComboBox ddl = (RadComboBox)PlHolder.FindControl(q_row["UNIQ"].ToString());
                    if (ddl.SelectedValue.Length > 0)
                    {
                        if (count == 1)
                        {

                            select_text += " WHERE " + q_row["VALUE_FIELD"] + " LIKE ''" + ddl.SelectedValue + "'' ";
                        }
                        else
                        {
                            select_text += " AND " + q_row["VALUE_FIELD"] + " LIKE ''" + ddl.SelectedValue + "'' ";
                        }

                       
                        count++;
                    }
                  
                }
            string is_not_supp_overall = WebTools.GetExpr("UPPER(IS_NOT_SUPP_OVERALL)", "SHEET_WISE_DOWNLOAD", " WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"]
             + " AND SEQ=" + Request.QueryString["SEQ"]);
            if (is_not_supp_overall == "Y" && select_text.ToString().Length == 0)
            {
                Master.show_error("Selected Sheet doesn't Support for over all Report.Please Select Any one Selection");
            }
            else
            {
                string FIXED_QUERY = WebTools.GetExpr("FIXED_QUERY", "VIEW_SHEET_WISE_SELECTION_USER", " WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"]
                    + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id + " ORDER BY EXPT_ID,SHEET_SEQ,SEQ");
                if (FIXED_QUERY.ToString().Length > 0 && select_text.ToString().Length == 0)
                {
                    select_text = FIXED_QUERY.ToString().Replace("'", "''");
                }

                string sheet_user_exist = WebTools.GetExpr("user_id", "SHEET_WISE_DOWNLOAD_USER", " WHERE EXPT_ID = " + Request.QueryString["EXPT_ID"]
                    + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id);
                if (sheet_user_exist.Length == 0)
                {
                    WebTools.ExeSql("INSERT INTO SHEET_WISE_DOWNLOAD_USER (USER_ID,  SHEET_SEQ,  EXPT_ID,WHERE_QUERY)" +
                                          "VALUES (" + user_id + "," + Request.QueryString["SEQ"] + "," + Request.QueryString["EXPT_ID"]
                                           + ",'" + select_text + "')");
                }
                else
                {
                    string where_query = "UPDATE SHEET_WISE_DOWNLOAD_USER SET WHERE_QUERY='" + select_text + "' WHERE EXPT_ID=" + Request.QueryString["EXPT_ID"]
                   + " AND SHEET_SEQ=" + Request.QueryString["SEQ"] + " AND USER_ID=" + user_id;
                    WebTools.ExeSql(where_query);

                }

                Master.show_success("Saved Please Download Report");
                ScriptManager.RegisterStartupScript(this, GetType(), "close", "CloseModal();", true);
            }


        }
        
    }
    
    
}




