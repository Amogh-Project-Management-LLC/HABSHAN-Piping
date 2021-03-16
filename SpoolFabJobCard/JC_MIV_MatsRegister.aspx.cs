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
using dsFabricationJCTableAdapters;

public partial class Material_MatReceiveNewItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("MM_INSERT"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }

            //      txtHN.Text = "XXX";

            string miv_no = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" +
                Request.QueryString["ISSUE_ID"]);
            string wo = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);
            Master.HeadingMessage("Job Card Materials (" + wo + "/ " + miv_no + ")");

            hiddenSC.Value = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            hiddenStore.Value = WebTools.GetExpr("STORE_ID", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlMatCode.SelectedValue.ToString() == "-1")
            {
                Master.show_error("Please select Mat code");
                return;
            }

            PIP_MAT_ISSUE_WO_MATSTableAdapter wo_mats = new PIP_MAT_ISSUE_WO_MATSTableAdapter();

            decimal miv_qty = decimal.Parse(txtMIVQty.Text);
            decimal bal_qty = decimal.Parse(txtBalIssue.Text);
            decimal max_qty = 0;
            if (txtMaxQty.Text != string.Empty)
                max_qty = decimal.Parse(txtMaxQty.Text);
            int pieces = 0;
            string item_id = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " WHERE MAT_ID=" + ddlMatCode.SelectedValue.ToString());
            string item_nam = WebTools.GetExpr("ITEM_NAM", "PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id);
            if (miv_qty == 0)
            {
                Master.show_error("Cannot issue Zero MIV Qty");
                return;
            }
            if (item_nam.ToUpper().Contains("PIPE"))
            {
                if (txtPieces.Text != string.Empty)
                {
                    pieces = int.Parse(txtPieces.Text);
                    if (pieces <= 0)
                    {
                        Master.show_error("No. of Pipe Pieces should be greater than 0");
                        return;
                    }
                }
                else
                {
                    Master.show_error("No. of Pipe Pieces Cannot be blank");
                    return;
                }
                //removed as discussed with nanda, only information will be shown of max issue qty, it wont restrict to choose more qty
                //if (txtMaxQty.Text != string.Empty)
                //{
                //    if (decimal.Parse(txtMIVQty.Text) > decimal.Parse(txtMaxQty.Text))
                //    {
                //        Master.show_error("Cannot issue Pipe more than Max Issue Qty.");
                //        return;
                //    }
                // }
            }
            //if(item_nam.ToUpper().Contains("PIPE"))
            //{
            //    if(miv_qty>max_qty)
            //    {
            //        Master.show_error("Cannot Issue More than: MIV Balance Qty + 5% Additional pipe="+txtMaxQty.Text);
            //        return;
            //    }
            //    decimal min_pip_len  = decimal.Parse(WebTools.GetExpr("MIN_PIP_LEN", "VIEW_PIPE_PIECE_LENGTTH", " WHERE MAT_ID=" + ddlMatCode.SelectedValue.ToString()));
            //    decimal max_pip_len = decimal.Parse(WebTools.GetExpr("MAX_PIP_LEN", "VIEW_PIPE_PIECE_LENGTTH", " WHERE MAT_ID=" + ddlMatCode.SelectedValue.ToString()));
            //    decimal min_pieces =Math.Floor(miv_qty / min_pip_len);
            //    decimal max_pieces = Math.Ceiling(miv_qty / max_pip_len);
            //    if(!(pieces>=min_pieces && pieces<=max_pieces))
            //    {
            //        Master.show_error("Can Issue Minimun Pieces:" + min_pieces + " OR Maximum Pieces:" + max_pieces);
            //        return;

            //    }

            //}
            if (!item_nam.ToUpper().Contains("PIPE"))
            {
                if (miv_qty > bal_qty)
                {
                    Master.show_error("Except Pipe, Cannot Issue More than: MIV Balance Qty=" + txtBalIssue.Text);
                    return;
                }
            }

            decimal? mir_id = null;
            decimal? store = null;
            wo_mats.InsertQuery(int.Parse(Request.QueryString["ISSUE_ID"]), int.Parse(ddlMatCode.SelectedValue.ToString()),
                                ddlMRIRNo.SelectedValue.ToString() == "-1" ? mir_id : int.Parse(ddlMRIRNo.SelectedValue.ToString())
                                , ddlHeatNo.SelectedValue.ToString(),
                                decimal.Parse(txtMIVQty.Text), pieces, txtRemarks.Text, int.Parse(Request.QueryString["ISSUE_REV_ID"]), ddlSubStore.SelectedValue.ToString() == "-1" ? store : int.Parse(ddlSubStore.SelectedValue.ToString()));


            Master.show_success("JC MIV Material Added!");
            refresh_qty();
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_Mats.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"].ToString() +
            "&WO_ID=" + Request.QueryString["WO_ID"]);
    }

    protected void ddlMatCode_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        refresh_qty();

    }
    public void refresh_qty()
    {
        if (ddlMatCode.SelectedValue.ToString() == "-1")
        {
            return;
        }
        try
        {
            txtMaxQty.Text = string.Empty;
            string item_id = WebTools.GetExpr("ITEM_ID", "PIP_MAT_STOCK", " WHERE MAT_ID=" + ddlMatCode.SelectedValue.ToString());
            string item_nam = WebTools.GetExpr("ITEM_NAM", "PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id);
            if (item_nam.ToUpper().Contains("PIPE"))
            {
                lblPieces.Visible = true;
                txtPieces.Visible = true;
            }
            else
            {
                lblPieces.Visible = false;
                txtPieces.Visible = false;
            }
            string req_qty = WebTools.GetExpr("JC_REQ_QTY", "VIEW_JC_MIV_ISSUE_SUMMARY", " WHERE WO_ID=" + Request.QueryString["WO_ID"] + " AND MAT_ID=" + ddlMatCode.SelectedValue.ToString());
            txtReqQty.Text = req_qty;

            string del_bom_qty = WebTools.GetExpr("DEL_BOM_QTY", "VIEW_JC_MIV_ISSUE_SUMMARY", " WHERE WO_ID=" + Request.QueryString["WO_ID"] + " AND MAT_ID=" + ddlMatCode.SelectedValue.ToString());
            txtDelBomQty.Text = del_bom_qty;

            string jcmivissued = WebTools.GetExpr("NVL(JC_MIV_QTY,0)", "VIEW_JC_MIV_ISSUE_SUMMARY", " WHERE WO_ID=" + Request.QueryString["WO_ID"] + " AND MAT_ID=" + ddlMatCode.SelectedValue.ToString());
            txtMIVIssuedQty.Text = jcmivissued;

            // string maxqty = WebTools.GetExpr("MAX_ISSUE_QTY", "VIEW_JC_MIV_ISSUE_SUMMARY", " WHERE WO_ID=" + Request.QueryString["WO_ID"] + " AND MAT_ID=" + ddlMatCode.SelectedValue.ToString());
            if (item_nam.ToUpper().Contains("PIPE"))
            {
                string max_len = WebTools.GetExpr("MAX_PIP_LEN", "VIEW_PIPE_PIECE_LENGTTH", " WHERE MAT_ID=" + ddlMatCode.SelectedValue.ToString());
                if (max_len != string.Empty)
                {

                    decimal max_pip_len = decimal.Parse(max_len);
                    decimal max_issue_qty = ((decimal.Parse(req_qty) - decimal.Parse(jcmivissued)) + max_pip_len);
                    if (max_issue_qty > 0)
                        txtMaxQty.Text = max_issue_qty + "";
                    else
                        txtMaxQty.Text = "0";

                }
            }
            else
            {

                txtMaxQty.Text = decimal.Parse(req_qty) - decimal.Parse(jcmivissued) + "";
            }
            txtBalIssue.Text = decimal.Parse(req_qty) - decimal.Parse(jcmivissued) + "";
            string sc_id = WebTools.GetExpr("SC_ID", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            string bal_qty = WebTools.GetExpr("BAL_QTY", "VIEW_ITEM_REP_A",
                " WHERE MAT_ID=" + ddlMatCode.SelectedValue.ToString() /*+ " AND SUB_CON_ID=" + sc_id*/);
            //Subcon Check removed for CPECC Piping as requested
            txtSubBalQty.Text = bal_qty == string.Empty ? "0" : bal_qty;
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}