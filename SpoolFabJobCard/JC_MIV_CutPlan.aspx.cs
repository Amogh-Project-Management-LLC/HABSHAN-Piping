using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class Material_JC_MIV_CutPlan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            woIdField.Value = WebTools.GetExpr("WO_ID", "PIP_MAT_ISSUE_WO", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);

            string wo = WebTools.GetExpr("WO_NAME || ' * ' || ISSUE_NO", "VIEW_JC_MIV", "ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
            Master.HeadingMessage = "Cutting Plan <br/>" + wo;

            update_buttons();
        }
    }

    private void update_buttons()
    {
        //Check if Cutting Plan Done
        string ISSUE_ID = WebTools.GetExpr("ISSUE_ID", "VIEW_CUTLEN_REP_MATS_A", "ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
        if (ISSUE_ID.Length > 0)
        {
            btnRun.Enabled = false;
            btnDelete.Enabled = true;
        }
        else
        {
            btnRun.Enabled = true;
            btnDelete.Enabled = false;
        }

        string REM_ID = WebTools.GetExpr("REM_ID", "VIEW_TOTAL_PIPE_REM", " WHERE USED_QTY>0 AND REM_FROM=" + Request.QueryString["ISSUE_ID"]);
        if (REM_ID.Length > 0)
        {
            btnDelete.Enabled = false;
        }

        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            btnRun.Enabled = false;
            btnDelete.Enabled = false;
        }

        check_Err();

    }

    private void check_Err()
    { 
        // find errors
        string PIPE_LEN_ERR = WebTools.GetExpr("ISSUE_ID", "VIEW_CUTLEN_RANDOM_LEN_ERR", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
        if (PIPE_LEN_ERR.Length > 0)
        {
            ErrorDiv.Visible = true;
            btnPipeLenErr.Enabled = true;
        }
        else
        {
            btnPipeLenErr.Enabled = false;
        }

        string NO_SET_CUTLEN = WebTools.GetExpr("ISSUE_ID", "VIEW_CUTLEN_WO_BOM",
            " WHERE SET_CUTLEN IS NULL AND ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
        if (NO_SET_CUTLEN.Length > 0)
        {
            ErrorDiv.Visible = true;
            btnPipeNotInCP.Enabled = true;
        }
        else
        {
            btnPipeNotInCP.Enabled = false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV.aspx");
    }

    protected void btnRun_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        decimal return_val;
        string message = string.Empty;

        //cutting plan is available?
        return_val = WebTools.DMax("ISSUE_ID", "PIP_WORK_ORD_CUTLEN", " WHERE ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
        if (return_val > 0)
        {
            message = "Cutting plan already calculated!";
        }

        //remain pipe used?
        return_val = WebTools.DMax("REM_FROM", "VIEW_TOTAL_PIPE_REM", " WHERE USED_QTY>0 AND REM_FROM=" + Request.QueryString["ISSUE_ID"]);
        if (return_val > 0)
        {
            Master.ShowWarn("This job card remains already used in other job cards!");
            return;
        }

        modeField.Value = "1";
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn(message + "PROCEED RUN THE CUT-LENGHT CALCULATION?");
    }

    protected void btnUndo_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowWarn("ACCESS DENIED!");
            return;
        }
        modeField.Value = "2";
        btnYes.Visible = true;
        btnNo.Visible = true;
        Master.ShowWarn("PROCEED UNDO THE CUT-LENGHT CALCULATION?");
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        string result;
        if (modeField.Value.ToString() == "1")
        {
            //run the cut-lenght calculation
            string use_rem = chkUseRem.Checked == true ? "'Y'" : "'N'";
            string use_extr = chkUseExtra.Checked == true ? "'Y'" : "'N'";
            string pip_adj = chkPipeAdj.Checked == true ? "'Y'" : "'N'";
            string cutting_alw = txtCuttingAlwMM.Text == string.Empty ? "0" : txtCuttingAlwMM.Text;

            WebTools.ExecNonQuery("UPDATE PIP_SPOOL SET MAT_TYPE=REPLACE(MAT_TYPE, ' - ', '-') WHERE MAT_TYPE LIKE '% - %'");
            WebTools.ExecNonQuery("UPDATE PIP_ISOMETRIC SET MAIN_MAT=REPLACE(MAIN_MAT, ' - ', '-') WHERE MAIN_MAT LIKE '% - %'");

            result = WebTools.GetExpr("FNC_CUTLEN_MAIN(" + Request.QueryString["ISSUE_ID"] +
                "," + use_rem +
                "," + pip_adj +
                "," + use_extr +
                "," + cboType.SelectedValue.ToString() +
                "," + cutting_alw +
                ")", "DUAL", "");

            if (string.IsNullOrEmpty(result))
            {
                result = "2";
            }

            if (result == "1")
            {
                Master.ShowMessage("Done!");
            }
            else
            {
                Master.ShowWarn("Error while calculating Cutting Plan!");
            }

            check_Err();
        }

        else if (modeField.Value.ToString() == "2")
        {
            //run the undo cut-lenght
            result = WebTools.GetExpr("FNC_CUTLEN_RESET(" + Request.QueryString["ISSUE_ID"] + ")", "DUAL", "");

            if (result == "1")
            {
                Master.ShowMessage("Done!");
            }
            else if (result == "2")
            {
                Master.ShowWarn("Remains used for other jobcards!");
            }
            else
            {
                Master.ShowWarn("Error while deleting cutting plan!");
            }
        }

        //completed

        update_buttons();
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportViewer.aspx?ReportID=" + ddReports.SelectedValue.ToString() +
            "&Arg1=" + Request.QueryString["ISSUE_ID"]);
    }

    protected void btnRandomLens_Click(object sender, EventArgs e)
    {
        Response.Redirect("JC_MIV_Rndlens.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"] +
            "&WO_ID=" + woIdField.Value.ToString());
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Response.Redirect("CuttingPlanMaster.aspx?ISSUE_ID=" +
            Request.QueryString["ISSUE_ID"] + "&WO_ID=" + woIdField.Value.ToString());
    }

    protected void btnPipeLenErr_Click(object sender, EventArgs e)
    {
        Response.Redirect("CutlenRandomLenErr.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }

    protected void btnPipeNotInCP_Click(object sender, EventArgs e)
    {
        Response.Redirect("CutlenNoSetCutlen.aspx?ISSUE_ID=" + Request.QueryString["ISSUE_ID"]);
    }
}