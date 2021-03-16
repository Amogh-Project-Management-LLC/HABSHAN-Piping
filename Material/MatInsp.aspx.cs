using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Material_MatInsp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Receive & Inspection (MRIR)";
            Master.AddModalPopup("~/Material/MatInspAdd.aspx", btnAdd.ClientID, 550, 850);
            Master.AddModalPopup("~/Material/MatInsp_View.aspx", btnView.ClientID, 600, 600);
            Master.RadGridList = grdMRIR.ClientID;

            
        }
    }

    protected void grdMRIR_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["popUp_MIR_ID"] = grdMRIR.SelectedValue;
        //string esd_no = WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " WHERE MAT_RCV_ID='" + grdMRIR.SelectedValue + "'");

        //if (esd_no.Length > 0)
        //    btnESD.Enabled = false;
        //else
        //    btnESD.Enabled = true;
    }

    protected void btnMaterial_Click(object sender, EventArgs e)
    {      
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select MRIR to proceed.");
            return;
        }
        Response.Redirect("~/Material/MatInspDetail.aspx?MIR_ID=" + grdMRIR.SelectedValue);
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select MRIR to proceed.");
            return;
        }

        string filename = WebTools.GetExpr("MIR_No", "PRC_MAT_INSP", " MIR_ID='" + grdMRIR.SelectedValue + "'");
        WebTools.ExportDataSetToExcel(sqlExportMIR, "MRIR_" + filename + ".xls");
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select MRIR to proceed.");
            return;
        }

        string repType = ddlReport.SelectedValue;
        switch (repType)
        {
            case "1":
                //Response.Redirect("~/Material/ReportViewer.aspx?ReportID=10&Arg1=" + grdMRIR.SelectedValue);
                string mrv_id = WebTools.GetExpr("MRV_ID", "PRC_MAT_INSP", " WHERE MIR_ID = '" + grdMRIR.SelectedValue + "'");
                if (!string.IsNullOrEmpty(mrv_id))
                {
                    Response.Redirect("~/Material/ReportViewer.aspx?ReportID=10.1&Arg1=" + grdMRIR.SelectedValue);
                    break;
                }
                break;
            case "2":
                Response.Redirect("~/Material/ReportViewer.aspx?ReportID=10&Arg1=" + grdMRIR.SelectedValue);
                break;
        }        
    }

    protected void btnExportAll_Click(object sender, EventArgs e)
    {
        string job_code = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        WebTools.ExportDataSetToExcel(sqlExportMIRAll, "MRIR-" + job_code + ".xls");
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=11&RetUrl=~/Material/MatInsp.aspx");
    }

    protected void btnESD_Click(object sender, EventArgs e)
    {
        if (grdMRIR.SelectedItems.Count == 0)
        {
            Master.ShowMessage("Please select MRIR to proceed.");
            return;
        }
        
        string esd_no = WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " WHERE MAT_RCV_ID='" + grdMRIR.SelectedValue + "'");

        if (esd_no.Trim().Length > 0)
        {
            Master.ShowMessage("ESD already created for this MRIR. Please go to ESD Page to make further changes.");
            return;
        }

        string count = WebTools.GetExpr("MIR_ID", "PRC_MAT_INSP_DETAIL", " WHERE MIR_ID = " + grdMRIR.SelectedValue + " AND (EXC_QTY > 0 OR PRC_MAT_INSP_DETAIL.SH_QTY > 0 OR PRC_MAT_INSP_DETAIL.DAMAG_QTY > 0)");

        if (count.Trim().Length == 0)
        {
            Master.ShowError("Invalid Request. There is no excess/shortage/damage in selected MIR.");
            return;
        }
        string prefix = WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        string sc_id = WebTools.GetExpr("MRIR_SC_ID", "PRC_MAT_INSP", " MIR_ID = '" + grdMRIR.SelectedValue + "'");
        prefix += "-ESD-";
        prefix += WebTools.GetExpr("SHORT_NAME", "SUB_CONTRACTOR", " SUB_CON_ID='" + sc_id + "'") + "-";
        string rep_no = WebTools.NextSerialNo("PIP_MAT_EXCEPTION_REP", "REP_NO", prefix, 3, " SC_ID = '" + sc_id + "'");


        string sql = "INSERT INTO PIP_MAT_EXCEPTION_REP (PROJ_ID, REP_NO, MAT_RCV_ID, REP_DATE, SC_ID) VALUES (";
        sql += "1, '" + rep_no + "', '" + grdMRIR.SelectedValue + "', '" + System.DateTime.Now.ToString("dd-MMM-yyyy") + "'," + sc_id + ")";

        string sql1 = string.Empty;
        string excp_id = string.Empty;
        try
        {
            WebTools.ExeSql(sql);
            excp_id = WebTools.GetExpr("EXCP_ID", "PIP_MAT_EXCEPTION_REP", " WHERE REP_NO='" + rep_no + "'");
            sql = "SELECT MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXC_QTY,SH_QTY, DAMAG_QTY FROM PRC_MAT_INSP_DETAIL WHERE MIR_ID = " + grdMRIR.SelectedValue + " AND (EXC_QTY > 0 OR PRC_MAT_INSP_DETAIL.SH_QTY > 0 OR PRC_MAT_INSP_DETAIL.DAMAG_QTY > 0) ";
            DataTable dt = General_Functions.GetDataTable(sql);

            foreach (DataRow row in dt.Rows)
            {
                if (row["EXC_QTY"].ToString().Length > 0 && decimal.Parse(row["EXC_QTY"].ToString()) > 0)
                {
                    sql1 = "INSERT INTO PIP_MAT_EXCEPTION_REP_DETAIL (EXCP_ID, MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXCP_FLG, EXCP_QTY) VALUES ";
                    sql1 += " ('" + excp_id + "', '" + row["MIR_ITEM"].ToString() + "', '" + row["PO_ITEM"].ToString() + "', '";
                    sql1 += row["MAT_ID"] + "','" + row["HEAT_NO"] + "','E', '" + row["EXC_QTY"] + "')";

                    WebTools.ExeSql(sql1);
                }

                if (row["SH_QTY"].ToString().Length > 0 && decimal.Parse(row["SH_QTY"].ToString()) > 0)
                {
                    sql1 = "INSERT INTO PIP_MAT_EXCEPTION_REP_DETAIL (EXCP_ID, MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXCP_FLG, EXCP_QTY) VALUES ";
                    sql1 += " ('" + excp_id + "', '" + row["MIR_ITEM"].ToString() + "', '" + row["PO_ITEM"].ToString() + "', '";
                    sql1 += row["MAT_ID"] + "','" + row["HEAT_NO"] + "','S', '" + row["SH_QTY"] + "')";

                    WebTools.ExeSql(sql1);
                }

                if (row["DAMAG_QTY"].ToString().Length > 0 && decimal.Parse(row["DAMAG_QTY"].ToString()) > 0)
                {
                    sql1 = "INSERT INTO PIP_MAT_EXCEPTION_REP_DETAIL (EXCP_ID, MIR_ITEM, PO_ITEM, MAT_ID, HEAT_NO, EXCP_FLG, EXCP_QTY) VALUES ";
                    sql1 += " ('" + excp_id + "', '" + row["MIR_ITEM"].ToString() + "', '" + row["PO_ITEM"].ToString() + "', '";
                    sql1 += row["MAT_ID"] + "','" + row["HEAT_NO"] + "','D', '" + row["DAMAG_QTY"] + "')";

                    WebTools.ExeSql(sql1);
                }
            }

            Master.ShowSuccess("ESD Created Successfully.");
        }
        catch (Exception ex)
        {
            //Rollback           
            excp_id = WebTools.GetExpr("EXCP_ID", "PIP_MAT_EXCEPTION_REP", " WHERE REP_NO='" + rep_no + "'");
            if (excp_id.Trim().Length > 0)
            {
                sql = "DELETE FROM PIP_MAT_EXCEPTION_REP_DETAIL WHERE EXCP_ID = " + excp_id;
                WebTools.ExeSql(sql);
                sql = "DELETE FROM PIP_MAT_EXCEPTION_REP WHERE EXCP_ID = " + excp_id;
                WebTools.ExeSql(sql);
            }

            Master.ShowError(ex.Message);
        }
    }

    protected void grdMRIR_DataBound(object sender, EventArgs e)
    {
      
    }

    protected void grdMRIR_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {

            Telerik.Web.UI.GridDataItem item = (Telerik.Web.UI.GridDataItem)e.Item;
            TableCell cell = (TableCell)item["PDF_FLG"];
            if (cell.Text == "Y")
            {
                Image img1 = (Image)e.Item.FindControl("Image1");
                img1.Visible = true;

            }

            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                ((ImageButton)item["EditCommandColumn"].Controls[0]).Visible = false;
            }


            if (!WebTools.UserInRole("MM_DELETE"))
            {
                ((ImageButton)item["DeleteColumn"].Controls[0]).Visible = false;
            }
        }
    }
}