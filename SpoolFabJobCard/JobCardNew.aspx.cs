using dsFabricationJCTableAdapters;
using System;

public partial class Material_FabricationJobCardNew : BasePage
{
    string user_id = "";
    string jc_type = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage ("Fabrication Job Card - New");
            string user_id = WebTools.GetExpr("USER_ID", "USERS",
                                "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            createdDDL.SelectedValue = user_id;
            txtCreateDate.SelectedDate = System.DateTime.Today;
            txtRevDate.SelectedDate = System.DateTime.Today;
            txtTargetDate.SelectedDate = System.DateTime.Today.AddDays(7);
            txtRev.Text = "0";
        }


    }

    private void go_back()
    {
        Response.Redirect("JobCard.aspx");
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PIP_WORK_ORDTableAdapter wo = new PIP_WORK_ORDTableAdapter();
        try
        {
            string user_id = WebTools.GetExpr("USER_ID", "USERS",
                               "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'");
            wo.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtJcNumber.Text,
                txtCreateDate.SelectedDate,
                decimal.Parse(subconDDL.SelectedValue.ToString()),
                ddPS.SelectedValue.ToString(),
                decimal.Parse(ddJobcardType.SelectedValue.ToString()),
                ddMatType.SelectedValue.ToString(),
                txtRemarks.Text, decimal.Parse(user_id), txtRev.Text, txtRevDate.SelectedDate, txtTargetDate.SelectedDate);

            string sql = "UPDATE PIP_WORK_ORD SET MAT_AVL = '" + radJCMatAvail.SelectedValue + "' WHERE WO_NAME = '" + txtJcNumber.Text + "'";
            WebTools.ExeSql(sql);            
            Master.show_success("Job Card Created.");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            wo.Dispose();
        }
    }

   

    //private void set_jc_no()
    //{
    //    try
    //    {
    //        string sc_name = WebTools.GetExpr("SHORT_NAME", "VIEW_FAB_GROUPS", "GROUP_ID=" + subconDDL.SelectedValue.ToString());
    //        string wo_type = WebTools.GetExpr("JC_CODE", "PIP_WORK_ORD_TYPE", "TYPE_ID=" + ddJobcardType.SelectedValue.ToString());
    //        string bay_code = WebTools.GetExpr("SHORT_NAME", "PIP_FAB_GROUP", "GROUP_ID=" + subconDDL.SelectedValue.ToString()); ;
    //        string projrct_id = Session["PROJECT_ID"].ToString();
    //        string prefix = string.Format("PF-{0}-{1}-{2}-",
    //                            ddMatType.SelectedValue.ToString(),
    //                            wo_type,
    //                            bay_code
    //                            );

    //        string new_jc =
    //            General_Functions.NextSerialNo("PIP_WORK_ORD", "WO_NAME", prefix, 4, " WHERE PROJ_ID=" + Session["PROJECT_ID"].ToString());
    //        txtJcNumber.Text = new_jc;
    //    }
    //    catch (Exception ex)
    //    {
    //        Master.ShowWarn(ex.Message);
    //    }
    //}

   

    //protected void subconDDL_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    /// string prefix = "JC-2035-"+subconDDL.SelectedText.ToString();
    //    //  txtJcNumber.Text = prefix+WebTools.NextSerialNo("PIP_WORK_ORD", "WO_NAME", prefix, 4, " WHERE  1=1");
    //    txtJcNumber.Text = "abc";
    //}


    protected void set_jc_no()
    {
        jc_type = ddJobcardType.SelectedText.ToString();
        string sc_name = WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", "SUB_CON_ID=" + subconDDL.SelectedValue.ToString());
        string short_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID = '" + Session["PROJECT_ID"] + "'");
        string prefix = short_code +"-" + sc_name + "-" + jc_type + "JC-ST-";
        txtJcNumber.Text = WebTools.NextSerialNo("PIP_WORK_ORD", "WO_NAME", prefix, 4, " WHERE  sc_id=" + subconDDL.SelectedValue.ToString());
    }
    protected void subconDDL_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (int.Parse(subconDDL.SelectedValue.ToString()) != -1)
        {
            set_jc_no();
        }
        else
        {
            txtJcNumber.Text = string.Empty;
        }
        
    }



    protected void ddJobcardType_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        if (int.Parse(ddJobcardType.SelectedValue.ToString()) != -1)
        {
            if (int.Parse(subconDDL.SelectedValue.ToString()) != -1)
                set_jc_no();
         
            subconDDL.Enabled = true;

        }
        else
        {
            subconDDL.Enabled = false;
            txtJcNumber.Text = string.Empty;
        }
    }
}