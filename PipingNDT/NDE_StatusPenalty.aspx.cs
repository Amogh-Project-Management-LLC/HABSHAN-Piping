using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web;
using Telerik.Web.UI;

public partial class PipingNDT_NDE_StatusPenalty : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string nde_req_id = WebTools.GetExpr("NDE_REQ_ID", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Request.QueryString["NDE_ITEM_ID"]);
            hiddenSC.Value=WebTools.GetExpr("SC_ID", "PIP_NDE_REQUEST", "NDE_REQ_ID=" + nde_req_id);

           
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string sql;

        string joint_id = WebTools.GetExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Request.QueryString["NDE_ITEM_ID"]);

        string p_joint_id = WebTools.GetExpr("JOINT_ID", "PIP_PENALTY_JOINTS", "JOINT_ID=" + joint_id + " AND PENALTY_WELDER_ID=" + ddWelder.SelectedValue.ToString());

        if (rcbpj1.SelectedItem.Value.ToString()==rcbpj2.SelectedItem.Value.ToString())
        {
            Master.ShowError("Please select different penalty joints");
            return;
        }
        //fresh entry
        if (p_joint_id == "")
        {
            if(rcbpj1.SelectedItem.Value.ToString() == "-1" && rcbpj2.SelectedItem.Value.ToString() == "-1")
            {
                Master.ShowError("Select atleast one penalty joint");
                return;
            }

            sql = "INSERT INTO PIP_PENALTY_JOINTS(NDE_ITEM_ID,JOINT_ID,PENALTY_JNT1,PENALTY_JNT2,PENALTY_WELDER_ID) VALUES(" +
                 Request.QueryString["NDE_ITEM_ID"] + "," + joint_id + ",";
            if (rcbpj1.SelectedItem.Value.ToString() != "-1")
            {
                sql += rcbpj1.SelectedValue.ToString()+",";
            }
            else
            {
                sql += "NULL,";
            }
            if (rcbpj2.SelectedItem.Value.ToString() != "-1")
            {
                sql += rcbpj2.SelectedValue.ToString() +",";
            }
            else
            {
                sql += "NULL,";
            }
            sql += ddWelder.SelectedValue.ToString()+ ")";
            WebTools.ExeSql(sql);

            Master.ShowSuccess("Penalty Joint Saved");
        }

        else
        {
            //Update nde status
            sql = "UPDATE PIP_PENALTY_JOINTS SET PENALTY_JNT1=";

            if (rcbpj1.SelectedItem.Value.ToString() != "-1")
            {
                sql += rcbpj1.SelectedValue.ToString();
            }
            else
            {
                sql += "NULL";
            }

            sql += ", PENALTY_JNT2=";

            if (rcbpj2.SelectedItem.Value.ToString() != "-1")
            {
                sql += rcbpj2.SelectedValue.ToString();
            }
            else
            {
                sql += "NULL";
            }
           
            sql += " WHERE JOINT_ID=" + joint_id + " and PENALTY_WELDER_ID=" + ddWelder.SelectedValue.ToString();
            try
            {
                WebTools.ExeSql(sql);

                Master.ShowSuccess("Penalty Joints Updated!");
            }
            catch (Exception ex)
            {
                Master.ShowError(ex.Message);
            }
        }
        string penalty_jnt1 = WebTools.GetExpr("PENALTY_JNT1", "PIP_PENALTY_JOINTS", "JOINT_ID=" + joint_id + " AND PENALTY_WELDER_ID=" + ddWelder.SelectedValue.ToString());
        string penalty_jnt2 = WebTools.GetExpr("PENALTY_JNT2", "PIP_PENALTY_JOINTS", "JOINT_ID=" + joint_id + " AND PENALTY_WELDER_ID=" + ddWelder.SelectedValue.ToString());
        if (penalty_jnt1 != "")
        {
          
            rcbpj1.Enabled = false;
            ResetPJ1.Visible = true;

        }
        if (penalty_jnt2 != "")
        {
         
            rcbpj2.Enabled = false;
            ResetPJ2.Visible = true;
        }
    }
    protected void ddJoint2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddJoint1_DataBound(object sender, EventArgs e)
    {
        //string TRACER_JOINT_ID1 = WebTools.GetExpr("TRACER_JOINT_ID1", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Session["popup_NDE_ITEM_ID"].ToString());

        //if (TRACER_JOINT_ID1.Length > 0)
        //{
        //    for (int i = 0; i < ddJoint1.Items.Count; i++)
        //    {
        //        if (ddJoint1.Items[i].Value.ToString() == TRACER_JOINT_ID1)
        //        {
        //            ddJoint1.Items[i].Selected = true;
        //            break;
        //        }
        //    }
        //}
    }
    protected void ddJoint2_DataBound(object sender, EventArgs e)
    {
        //string TRACER_JOINT_ID2 = WebTools.GetExpr("TRACER_JOINT_ID2", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Session["popup_NDE_ITEM_ID"].ToString());

        //if (TRACER_JOINT_ID2.Length > 0)
        //{
        //    for (int i = 0; i < ddJoint2.Items.Count; i++)
        //    {
        //        if (ddJoint2.Items[i].Value.ToString() == TRACER_JOINT_ID2)
        //        {
        //            ddJoint2.Items[i].Selected = true;
        //            break;
        //        }
        //    }
        //}
    }
    protected void ddWelder_DataBound(object sender, EventArgs e)
    {
        //string TRACER_WELDER_NO = WebTools.GetExpr("TRACER_WELDER_NO", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Session["popup_NDE_ITEM_ID"].ToString());

        //if (TRACER_WELDER_NO.Length > 0)
        //{
        //    for (int i = 0; i < ddWelder.Items.Count; i++)
        //    {
        //        if (ddWelder.Items[i].Text.ToString() == TRACER_WELDER_NO)
        //        {
        //            ddWelder.Items[i].Selected = true;
        //            break;
        //        }
        //    }
        //}
    }
    protected void ddWelder_DataBinding(object sender, EventArgs e)
    {
      //  ddWelder.Items.Clear();
      //  ddWelder.Items.Add(new ListItem("(Select)", "-1"));
    }
    protected void Joint2DataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    //protected void ddJoint1_DataBinding(object sender, EventArgs e)
    //{
    //    ddJoint1.Items.Clear();
    //    ddJoint1.Items.Add(new ListItem("(Select)", "-1"));
    //}
    //protected void ddJoint2_DataBinding(object sender, EventArgs e)
    //{
    //    ddJoint2.Items.Clear();
    //    ddJoint2.Items.Add(new ListItem("(Select)", "-1"));
    //}

    protected void ddWelder_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        string joint_id = WebTools.GetExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Request.QueryString["NDE_ITEM_ID"]);
        rcbpj1.ClearSelection();
        rcbpj2.ClearSelection();
        rcbpj1.Enabled = true;
        rcbpj2.Enabled = true;
        ResetPJ1.Visible = false;
        ResetPJ2.Visible = false;

       string penalty_jnt1=WebTools.GetExpr("PENALTY_JNT1", "PIP_PENALTY_JOINTS", "JOINT_ID=" + joint_id+ " AND PENALTY_WELDER_ID="+ddWelder.SelectedValue.ToString());
       string penalty_jnt2=WebTools.GetExpr("PENALTY_JNT2", "PIP_PENALTY_JOINTS", "JOINT_ID=" + joint_id + " AND PENALTY_WELDER_ID=" + ddWelder.SelectedValue.ToString());
        if(penalty_jnt1!="")
        {
            RadComboBoxItem item1 = new RadComboBoxItem();
            item1.Text = WebTools.GetExpr("JOINT_TITLE", "VIEW_JOINTS_SIMPLE_WELDING", "JOINT_ID=" + penalty_jnt1);
            item1.Value = penalty_jnt1;
            rcbpj1.Items.Add(item1);
            rcbpj1.SelectedValue = penalty_jnt1;
            rcbpj1.Enabled = false;
            ResetPJ1.Visible = true;

        }
        if(penalty_jnt2!="")
        {
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = WebTools.GetExpr("JOINT_TITLE", "VIEW_JOINTS_SIMPLE_WELDING", "JOINT_ID=" + penalty_jnt2);
            item2.Value = penalty_jnt2;
            rcbpj2.Items.Add(item2);
            rcbpj2.SelectedValue = penalty_jnt2;
            rcbpj2.Enabled = false;
            ResetPJ2.Visible = true;
        }

    }

    protected void ResetPJ1_Click(object sender, EventArgs e)
    {
        string joint_id = WebTools.GetExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Request.QueryString["NDE_ITEM_ID"]);
        string  sql = "UPDATE PIP_PENALTY_JOINTS SET penalty_jnt1=NULL WHERE  JOINT_ID="+joint_id+ " and penalty_welder_id=" + ddWelder.SelectedValue.ToString();

        WebTools.ExeSql(sql);
        rcbpj1.ClearSelection();
        rcbpj1.Enabled = true;
        ResetPJ1.Visible = false;
        Master.ShowSuccess("Penalty Joint1 Removed!");
    }

    protected void ResetPJ2_Click(object sender, EventArgs e)
    {
        string joint_id = WebTools.GetExpr("JOINT_ID", "PIP_NDE_REQUEST_JOINTS", "NDE_ITEM_ID=" + Request.QueryString["NDE_ITEM_ID"]);
        string sql = "UPDATE PIP_PENALTY_JOINTS SET penalty_jnt2=NULL WHERE  JOINT_ID=" + joint_id + " and penalty_welder_id=" + ddWelder.SelectedValue.ToString();

        WebTools.ExeSql(sql);
        rcbpj2.ClearSelection();
        rcbpj2.Enabled = true;
        ResetPJ2.Visible = false;

        Master.ShowSuccess("Penalty Joint2 Removed!");
    }
}