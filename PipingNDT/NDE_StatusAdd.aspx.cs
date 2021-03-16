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

public partial class PipingNDT_NDE_StatusAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("NDT Status - Add Joint");
        }
    }

    protected void cboPassFlg_DataBound(object sender, EventArgs e)
    {
        if (passFlgField.Value.ToString() == "") return;
        for (int i = 0; i < ddPassFlag.Items.Count; i++)
        {
            if (ddPassFlag.Items[i].Value.ToString() == passFlgField.Value.ToString())
            {
                ddPassFlag.SelectedIndex = i;
                break;
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string sql;

        //Update nde status
        sql = "INSERT INTO PIP_NDE_REQUEST_JOINTS(PROJECT_ID, JOINT_ID, REWORK_CODE, NDE_TYPE_ID, PASS_FLG_ID, NDE_REP_NO, NDE_DATE, TOTAL_FILMS, REPAIR_FILMS, RESHOOT_FILMS) VALUES(";

        sql += Session["PROJECT_ID"].ToString() + "," + cboNewJoint.SelectedValue.ToString() + ",'" + ddReworkCode.SelectedValue.ToString() + "'," + ddNDE_Type.SelectedValue.ToString() + ",";
        sql += ddPassFlag.SelectedValue.ToString() + ",'" + txtRepNo.Text.Trim().ToUpper() + "','" + txtNDE_Date.SelectedDate.Value.ToString("dd-MMM-yyyy") + "'";

        if (txtTotalFilms.Text != "")
        {
            sql += ", " + txtTotalFilms.Text;
        }
        else
        {
            sql += ", NULL";
        }

        if (txtRepairFilms.Text != "")
        {
            sql += ", " + txtRepairFilms.Text;
        }
        else
        {
            sql += ", NULL";
        }

        if (txtReshootFilms.Text != "")
        {
            sql += ", " + txtReshootFilms.Text;
        }
        else
        {
            sql += ", NULL";
        }

        sql += ")";

        try
        {
            WebTools.ExeSql(sql);

            Master.show_success(cboNewJoint.SelectedItem.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(sql);
            //Master.show_error(ex.Message);
        }
    }
    private void Update_newjointDataSource()
    {
        if (IsPostBack)
        {
            string nde_type_id = ddNDE_Type.SelectedValue.ToString();

            string sql = "SELECT JOINT_ID, JOINT_TITLE " +
                "FROM VIEW_TOTAL_JOINTS " +
                "WHERE  (ISO_TITLE1 = :ISO_TITLE1)";

            sql += " AND (JOINT_ID NOT IN " +
                "(SELECT JOINT_ID FROM PIP_NDE_REQUEST_JOINTS WHERE (PASS_FLG_ID=1 OR NDE_DATE IS NULL) AND NDE_TYPE_ID=" + nde_type_id + "))";

            switch (ddNDE_Type.SelectedValue.ToString())
            {
                case "1":
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL) AND (RT>0)";
                    break;
                case "2":
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL) AND (PT>0)";
                    break;
                case "3":
                    newjointDataSource.SelectCommand = sql + " AND (MT<>0)";
                    break;
                case "4":
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL) AND (PMI>0)";
                    break;
                case "7":
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL) AND (PWHT='Y')";
                    break;
                case "8":
                    //HT
                    newjointDataSource.SelectCommand = sql + " AND (WELD_DATE IS NOT NULL)";
                    break;
                case "9":
                    //UT
                    newjointDataSource.SelectCommand = sql;
                    break;
                case "10":
                    //LT
                    newjointDataSource.SelectCommand = sql + " AND (NOT (WELD_DATE IS NULL))";
                    break;
                case "11":
                    //ORF
                    newjointDataSource.SelectCommand = sql + " AND (NOT (WELD_DATE IS NULL))";
                    break;
            }

            sql += " ORDER BY JOINT_TITLE";

            newjointDataSource.SelectParameters.Add("ISO_TITLE1", TypeCode.Empty, txtIsome.Text);
            //Binding
        }
    }
    protected void txtIsome_TextChanged(object sender, EventArgs e)
    {
        Update_newjointDataSource();
    }
    protected void cboNewJoint_DataBinding(object sender, EventArgs e)
    {
        //cboNewJoint.Items.Clear();
        //cboNewJoint.Items.Add(new ListItem("(Select)", "-1"));
    }
}