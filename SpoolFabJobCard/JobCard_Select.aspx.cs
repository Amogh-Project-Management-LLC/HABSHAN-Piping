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

public partial class SpoolFabJobCard_JobCard_Select : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
            {
                Master.ShowWarn("Access Denied!");
                btnSave.Enabled = false;
                
              
            }

            Master.HeadingMessage = "Spool Selection <br/>" +
            WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD", "WO_ID=" + Request.QueryString["WO_ID"]);
            
            scIdField.Value = WebTools.GetExpr("SUB_CON_ID", "VIEW_ADAPTER_FAB_JC", "WO_ID=" + Request.QueryString["WO_ID"]);
            WO_Mat.Value = WebTools.GetExpr("MAT_TYPE", "VIEW_ADAPTER_FAB_JC", "WO_ID=" + Request.QueryString["WO_ID"]);
            string TYPE_ID = WebTools.GetExpr("TYPE_ID", "PIP_WORK_ORD", " WHERE WO_ID=" + Request.QueryString["WO_ID"]);           
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("JobCard.aspx?Filter=" + Request.QueryString["Filter"]);
    }

    protected void btnMbrs_Click(object sender, EventArgs e)
    {
        if (Selected_Spools.Items.Count == 0)
        {
            Master.ShowMessage("No Spool selected!");
            return;
        }

        PIP_WORK_ORD_SPOOLTableAdapter spool = new PIP_WORK_ORD_SPOOLTableAdapter();

        try
        {
            if (Selected_Spools.Items.Count > 0)
            {
                for (int i = 0; i < Selected_Spools.Items.Count; i++)
                {

                    //Save Support; QTY=1;
                    spool.InsertQuery(decimal.Parse(Request.QueryString["WO_ID"]),
                        decimal.Parse(Selected_Spools.Items[i].Value));

                    //if (!arraylist2.Contains(Selected_Supports.Items[i]))
                    //{
                    //    arraylist2.Add(Selected_Supports.Items[i]);
                    //}
                }

                Selected_Spools.Items.Clear();
                btnSave.Enabled = false;

                Master.ShowMessage("Saved!");
            }
            else
            {
                Master.ShowMessage("No Support selected!");
                return;
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            spool.Dispose();
        }
    }
    protected void btnApplyFilter_Click(object sender, EventArgs e)
    {
        if (btnSave.Enabled == false)
        {
            btnSave.Enabled = true;
        }

        All_Spools.DataBind();
    }

    protected void AnySize_CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (AnySize_CheckBox.Checked == true)
        {
            AnySize_HiddenField.Value = "Y";
            rcbSize.Enabled = false;
          
        }
        else
        {
            AnySize_HiddenField.Value = "N";
            rcbSize.Enabled = true;
        }
    }

    protected void SFR_CheckBox_CheckedChanged(object sender, EventArgs e)
    {

    }

    protected void btnBulkImportSpl_Click(object sender, EventArgs e)
    {      
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=13&RetUrl=~/SpoolFabJobCard/JobCard.aspx");
    }

    protected void btnSpoolDownload_Click(object sender, EventArgs e)
    {
        string sql = "SELECT SPL_ID, SPL_TITLE FROM VIEW_SPL_WITH_STATUS WHERE(PROJ_ID = " + Session["PROJECT_ID"] + ") AND ";
        sql += " (SML_SC = " + scIdField.Value + ") AND (FAB_SC = " + scIdField.Value + ") AND (HOLD_STATUS = 'N') AND ";
        sql += "(MAT_TYPE ='" + WO_Mat.Value + "' OR  '"+ WO_Mat.Value + "' = 'XX') ORDER BY SPL_TITLE";

        splDwnDataSource.SelectCommand = sql;

        db_export.ExportDataSetToExcel(splDwnDataSource, "JC_Eligible_Spools.xls");
    }

    protected void rcbSize_DataBinding(object sender, EventArgs e)
    {
        rcbSize.Items.Clear();
        rcbSize.Items.Add(new Telerik.Web.UI.RadComboBoxItem("(Select)", ""));
    }

    protected void All_Spools_DataBound(object sender, EventArgs e)
    {
        int all_cnt=All_Spools.Items.Count;
        Master.ShowMessage("Spool Count:"+all_cnt);
    }
}