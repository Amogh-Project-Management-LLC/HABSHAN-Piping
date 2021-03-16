using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Dashboard_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            //LoadFabStatus();
            //gridFabStatus.DataSource = sqlFabProgress;
            //gridFabStatus.DataBind();

            //lblUpdateByVal.Text = WebTools.GetExpr("UPDATE_BY", "VIEW_SCOPE_DASHBOARD", " WHERE 1 = 1");
            //lblSinceLastRunVal.Text = WebTools.GetExpr("UPDATE_DATE_CHAR", "VIEW_SCOPE_DASHBOARD", " WHERE 1 = 1");
            string narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='SPOOLGEN_NARRATIVE'");
            if (narrativetxt != string.Empty)
            {
                txtSpgnNarrative.Text = narrativetxt;
            }
            narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='MATERIAL_NARRATIVE'");
            if (narrativetxt != string.Empty)
            {
                txtMaterialNarrative.Text = narrativetxt;
            }
            narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='WORKFRONT_NARRATIVE'");
            if (narrativetxt != string.Empty)
            {
                txtWorkFrontNarrative.Text = narrativetxt;
            }
            narrativetxt = WebTools.GetExpr("TEXT", "DASHBOARD_NARRATIVE", " WHERE LABEL='FAB_NARRATIVE'");
            if (narrativetxt != string.Empty)
            {
                txtFabNarrative.Text = narrativetxt;
            }

        }
        if (!WebTools.UserInRole("DASHBOARD_NARRATIVE"))
        {
            btnShow.Visible = false;
            btnHide.Visible = false;
        }

        }

    //protected void ddlSubconList_DataBinding(object sender, EventArgs e)
    //{
    //    ddlSubconList.Items.Clear();
    //    ddlSubconList.Items.Add(new ListItem("(ALL)", "-1"));
    //}

    //protected void radFabStatus_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    LoadFabStatus();
    //}

    //private void LoadFabStatus()
    //{
    //    if (ddlSubconList.SelectedValue == "-1")
    //    {
    //        if (radFabStatus.SelectedValue == "INCH_DIA")
    //        {
    //            gridFabStatus.DataSource = sqlFabProgress;
    //            gridFabStatus.DataBind();
    //        }
    //    }
    //    else
    //    {
    //        if (radFabStatus.SelectedValue == "INCH_DIA")
    //        {
    //            //sqlFabProgressSC

    //            gridFabStatus.DataSource = sqlFabProgressSC;
    //            gridFabStatus.DataBind();
    //        }
    //    }
    //}

    //protected void ddlSubconList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    LoadFabStatus();
    //}

    //protected void gridFabStatus_DataBound(object sender, EventArgs e)
    //{

    //}

    //protected void gridFabStatus_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{
    //    if (e.Item is GridDataItem)
    //    {
    //        GridDataItem item = (GridDataItem)e.Item;

    //        for (int i = 0; i < item.Cells.Count; i++)
    //        {
    //            item.Cells[i].Text = item.Cells[i].Text.ToString(CultureInfo.InvariantCulture.NumberFormat);
    //        }

    //        double total_scope = Convert.ToDouble(item.Cells[2].Text);
    //        double sg_done = Convert.ToDouble(item.Cells[3].Text);
    //        double mat_avl = Convert.ToDouble(item.Cells[4].Text);
    //        double jc_issued = Convert.ToDouble(item.Cells[5].Text);
    //        double weld_done = Convert.ToDouble(item.Cells[6].Text);
    //        double nde_done = Convert.ToDouble(item.Cells[7].Text);
    //        double spl_paint = Convert.ToDouble(item.Cells[8].Text);
    //        double sent_to_site = Convert.ToDouble(item.Cells[9].Text);
    //        double spool_count_scope = Convert.ToDouble(item.Cells[10].Text);

    //        var sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(sg_done * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(sg_done * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart2.DataSource = sg_dt;
    //        RadHtmlChart2.DataBind();

    //        sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(mat_avl * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(mat_avl * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart3.DataSource = sg_dt;
    //        RadHtmlChart3.DataBind();

    //        sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(jc_issued * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(jc_issued * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart4.DataSource = sg_dt;
    //        RadHtmlChart4.DataBind();


    //        sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(weld_done * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(weld_done * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart5.DataSource = sg_dt;
    //        RadHtmlChart5.DataBind();

    //        sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(nde_done * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(nde_done * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart6.DataSource = sg_dt;
    //        RadHtmlChart6.DataBind();

    //        sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(spl_paint * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(spl_paint * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart7.DataSource = sg_dt;
    //        RadHtmlChart7.DataBind();

    //        sg_dt = new DataTable();

    //        sg_dt.Columns.Add("SCOPE_TEXT");
    //        sg_dt.Columns.Add("SCOPE_VALUE");
    //        sg_dt.Columns.Add("COLOR_CODE");
    //        sg_dt.Rows.Add("SPOOLGEN PROGRESS", Math.Round(sent_to_site * 100 / total_scope, 1), "#4DCA5E");
    //        sg_dt.Rows.Add("BALANCE", Math.Round(100 - Math.Round(sent_to_site * 100 / total_scope, 1), 1), "#D6D6D6");
    //        RadHtmlChart8.DataSource = sg_dt;
    //        RadHtmlChart8.DataBind();
    //    }


    //}

    //protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    //{
    //    string seriesName = RadHtmlChart1.PlotArea.Series[0].Name;


    //        if (seriesName == "Months")
    //        {
    //            int quarter = int.Parse(e.Argument);
    //        sqlIsometricReceive.SelectParameters[0].DefaultValue = e.Argument; //Year.ToString();
    //                                                                           // sqlIsometricReceive.SelectParameters[1].DefaultValue = quarter.ToString();
    //        RadHtmlIsoStatus.PlotArea.XAxis.DataLabelsField = "ISO_COUNT";
    //        RadHtmlIsoStatus.PlotArea.Series[0].DataFieldY = "ISO_COUNT";
    //        RadHtmlIsoStatus.PlotArea.Series[0].Name = "Months";
    //        RadHtmlIsoStatus.DataSourceID = "sqlIsometricReceive";
    //        }

    //}

    //protected void btnRefresh_Click(object sender, EventArgs e)
    //{
    //    string sql1 = "Begin P_DASHBOARD_UPDATE('" +  Session["USER_NAME"].ToString() + "')" + ";END;";
    //    WebTools.exec_non_qry(sql1);

    //    lblUpdateByVal.Text = WebTools.GetExpr("UPDATE_BY", "VIEW_SCOPE_DASHBOARD", " WHERE 1 = 1");
    //    lblSinceLastRunVal.Text = WebTools.GetExpr("UPDATE_DATE_CHAR", "VIEW_SCOPE_DASHBOARD", " WHERE 1 = 1");
    //}




    protected void SpoolgenGrid_DataBinding(object sender, EventArgs e)
    {
        foreach (GridColumn col in SpoolgenGrid.MasterTableView.AutoGeneratedColumns)
        {
            col.HeaderText = col.HeaderText.ToString().Replace('S', 'X');

        }
    }

    protected void btnSpgnNarrative_Click(object sender, EventArgs e)
    {
        string txt = txtSpgnNarrative.Text;
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtSpgnNarrative.Text + "' WHERE LABEL='SPOOLGEN_NARRATIVE'";
        WebTools.ExeSql(query);
        Master.ShowError(query+" "+txt);
    }

    protected void btnMaterialNarrative_Click(object sender, EventArgs e)
    {
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtMaterialNarrative.Text + "' WHERE LABEL='MATERIAL_NARRATIVE'";
        WebTools.ExeSql(query);

    }

    protected void btnWorkFrontNarrative_Click(object sender, EventArgs e)
    {
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtWorkFrontNarrative.Text + "' WHERE LABEL='WORKFRONT_NARRATIVE'";
        WebTools.ExeSql(query);
        
    }


    protected void btnFabNarrative_Click(object sender, EventArgs e)
    {
        string query = "UPDATE DASHBOARD_NARRATIVE SET TEXT='" + txtFabNarrative.Text + "' WHERE LABEL='FAB_NARRATIVE'";
        WebTools.ExeSql(query);
    }



    protected void btnShow_Click(object sender, EventArgs e)
    {
        btnSpgnNarrative.Visible = true;
        btnMaterialNarrative.Visible = true;
        btnWorkFrontNarrative.Visible = true;
        btnFabNarrative.Visible = true;
        
    }

    protected void btnHide_Click(object sender, EventArgs e)
    {
        btnSpgnNarrative.Visible = false;
        btnMaterialNarrative.Visible = false;
        btnWorkFrontNarrative.Visible = false;
        btnFabNarrative.Visible = false;

    }

}