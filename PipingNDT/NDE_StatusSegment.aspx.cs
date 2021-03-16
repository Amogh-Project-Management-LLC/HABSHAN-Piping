using System;

public partial class PipingNDT_NDE_StatusSegment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HiddenNDE_ITEM_ID.Value = WebTools.GetExpr("NDE_ITEM_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_REQ_ID='" + Request.QueryString["REQ_ID"] + "' AND JOINT_ID='" + Request.QueryString["JOINT_ID"] + "'");

            Master.HeadingMessage("RT Segment - " +
                WebTools.GetExpr("JOINT_TITLE", "VIEW_ADAPTER_NDE_STATUS", "NDE_ITEM_ID=" + HiddenNDE_ITEM_ID.Value)
                );
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string sql;

        //Update nde status
        sql = "INSERT INTO PIP_NDE_REQUEST_SEGMENT(NDE_ITEM_ID, RT_SEGMENT, RT_DEFECT, REPAIR_LEN, REPAIR_WELDER_ID, PASS_FLG_ID) VALUES(";

        sql += HiddenNDE_ITEM_ID.Value + ",'" + txtRT_Segment.Text.Trim() + "','" + ddDefect.SelectedItem.Value.ToString() + "',";

        sql += (txtRepairLen.Text.Length > 0 ? txtRepairLen.Text : "NULL") + ",";

        sql += (ddWelder.SelectedValue.ToString() != "-1" ? ddWelder.SelectedValue.ToString() : "NULL") + ",";

        sql += (ddPassFlag.SelectedValue.ToString() != "-1" ? ddPassFlag.SelectedValue.ToString() : "NULL");

        sql += ")";

        try
        {
            WebTools.ExeSql(sql);
            RadGrid1.DataBind();

            Master.show_success(txtRT_Segment.Text + " Saved!");
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}