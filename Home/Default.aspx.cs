using System;
using System.Globalization;
using Telerik.Web.UI;
using System.IO;
using System.Data;
using System.Data.OracleClient;
using System.Text;
using System.Web.UI.WebControls;
using Ionic.Zip;

public partial class ipms_Home : BasePage
{
    string milestoneselected = "'";
    string priorityselected = "'";
    string areaselected = "'";
    string subconselected = "'";

    string chart1_1 = "SELECT COLOR, LABEL, Sum(CNT) as cnt FROM VIEW_ISO_SHT_STATUS_DASHBOARD ";
    string chart2_1 = "SELECT COLOR,LABEL,Sum(CNT) as cnt FROM VIEW_INCH_DIA_DASHBOARD ";
    string chart3_1 = "SELECT COLOR,LABEL,Sum(CNT) as cnt FROM VIEW_FAB_INCH_DIA_DASHBOARD";
    string chart4_1 = "SELECT COLOR,LABEL,Sum(CNT) as cnt FROM VIEW_SPOOLS_DASHBOARD";

    string chartgroup = " GROUP BY color,LABEL,ORD ORDER BY ORD";

    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage = "Home";
        if (!IsPostBack)
        {
            if (WebTools.UserInRole("FATA"))
            {
                FataRow.Visible = true;
            }
            else
            {
                FataRow.Visible = false;
            }
            //RadHtmlChart1_EPIC.DataSource = dsISOPlanningReport_EPIC;
            //RadHtmlChart1_EPIC.DataBind();

            PieChart1.DataSource = sqlIsomeSheetStatus;
            PieChart1.DataBind();
            PieChart2.DataSource = sqlInchDiaStatus;
            PieChart2.DataBind();
            PieChart3.DataSource = FabMatAvlStatus;
            PieChart3.DataBind();
            //PieChart4.DataSource = SpoolFabStatus;
            //PieChart4.DataBind();
            //DivWiseScope1.DataSource = DivWiseMatAvlStatus;
            //DivWiseScope1.DataBind();
            //DivWiseScope2.DataSource = DivWiseSplStatus;
            //DivWiseScope2.DataBind();

            //PieChart5.DataSource = dsISOPlanningReport;
            //PieChart5.DataBind();

            //PieChart6.DataSource = dsISOPlanningReport;
            //PieChart6.DataBind();
            //PieChart5.PlotArea.XAxis.AxisCrossingPoints[0].Value = 100;
            //PieChart5.PlotArea.XAxis.AxisCrossingPoints[1].Value = decimal.Parse("100");


            ddlPriority.DataSource = PriorityDataSource;
            ddlPriority.DataBind();

            ddlArea.DataSource = AreaDataSource;
            ddlArea.DataBind();

            //ddlPriority.DataSource = PriorityDataSource;
            //ddlPriority.DataTextField = "AREA_PRIORITY";
            //ddlPriority.DataValueField = "AREA_PRIORITY";

            //ddlArea.DataSource = AreaDataSource;
            //ddlArea.DataTextField = "AREA";
            //ddlArea.DataValueField = "AREA";

            Decimal total_scope = WebTools.DSum("CNT", "VIEW_SPOOLS_DASHBOARD", "1=1");
            //lblSplFabStatus.Text = lblSplFabStatus.Text + String.Format(CultureInfo.InvariantCulture,
            //                     "{0:0,0}", total_scope);
            //lblDivWiseStatus2.Text = lblDivWiseStatus2.Text + String.Format(CultureInfo.InvariantCulture,
            //                     "{0:0,0}", total_scope);

            //PieChart4.DataBind();
            total_scope = WebTools.DSum("CNT", "VIEW_FAB_INCH_DIA_DASHBOARD", "1=1");
            lblFabMatStatus.Text = lblFabMatStatus.Text + String.Format(CultureInfo.InvariantCulture,
                                 "{0:0,0}", total_scope);
            //lblDivWiseStatus.Text = lblFabMatStatus.Text;
            total_scope = WebTools.DSum("CNT", "VIEW_INCH_DIA_DASHBOARD", "1=1");
            lblInchDiaStatus.Text = lblInchDiaStatus.Text + String.Format(CultureInfo.InvariantCulture,
                                 "{0:0,0}", total_scope);
            total_scope = WebTools.DSum("CNT", "VIEW_ISO_SHT_STATUS_DASHBOARD", "1=1");
            lblIsomeShtStatus.Text = lblIsomeShtStatus.Text + String.Format(CultureInfo.InvariantCulture,
                                 "{0:0,0}", total_scope);
        }
    }
    protected void RadChart1_ItemDataBound(object sender, Telerik.Charting.ChartItemDataBoundEventArgs e)
    {
        //e.SeriesItem.Name = ((DataRowView)e.DataItem)["Name"].ToString();
    }

    protected void RadChart2_ItemDataBound(object sender, Telerik.Charting.ChartItemDataBoundEventArgs e)
    {
        //e.SeriesItem.Name = ((DataRowView)e.DataItem)["Name"].ToString();
    }
    protected void btnItemCode_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/FATA/GenerateItemCode.aspx");
    }

    protected void ddlMilestone_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        setWhereClause();
        if (milestoneselected.Length > 1)
        {
            string priority_query = "select Distinct area_priority from view_piping_dpr_rdlc where milestone in (" + milestoneselected + ") order by area_priority";
            PriorityDataSource.SelectCommand = priority_query;
            ddlPriority.DataSource = PriorityDataSource;
            ddlPriority.DataBind();
        }
    }

    protected void ddlPriority_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        setWhereClause();
        if (milestoneselected.Length > 1 && priorityselected.Length > 1)
        {
            string area_query = "select Distinct AREA_L2 AS AREA from view_piping_dpr_rdlc where milestone in (" + milestoneselected + ") and area_priority in (" + priorityselected + ") order by area_l2";
            AreaDataSource.SelectCommand = area_query;

            ddlArea.DataSource = AreaDataSource;
            ddlArea.DataBind();
        }
    }

    protected void ddlArea_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        setWhereClause();
    }

    protected void setWhereClause()
    {
        string chart1_2 = "";
        string chart2_2 = "";
        string chart3_2 = "";
        string chart4_2 = "";

        //milestone
        foreach (RadComboBoxItem item in ddlMilestone.CheckedItems)
        {
            milestoneselected += item.Value + "','";
        }
        if (milestoneselected.Length > 1)
        {
            milestoneselected = milestoneselected.Substring(0, milestoneselected.Length - 2);
        }

        //Area Priority
        foreach (RadComboBoxItem item in ddlPriority.CheckedItems)
        {
            priorityselected += item.Value + "','";
        }
        if (priorityselected.Length > 1)
        {
            priorityselected = priorityselected.Substring(0, priorityselected.Length - 2);
        }

        //Area 
        foreach (RadComboBoxItem item in ddlArea.CheckedItems)
        {
            areaselected += item.Value + "','";
        }
        if (areaselected.Length > 1)
        {
            areaselected = areaselected.Substring(0, areaselected.Length - 2);
        }

        if (milestoneselected.Length > 1)
        {
            chart1_2 = " WHERE MILESTONE IN (" + milestoneselected + ")";
            chart2_2 = " WHERE MILESTONE IN (" + milestoneselected + ")";
            chart3_2 = " WHERE MILESTONE IN (" + milestoneselected + ")";
            chart4_2 = " WHERE MILESTONE IN (" + milestoneselected + ")";
        }
        if (priorityselected.Length > 1)
        {
            if (milestoneselected.Length > 1)
            {
                chart1_2 = chart1_2 + " AND  AREA_PRIORITY IN (" + priorityselected + ")";
                chart2_2 = chart2_2 + " AND AREA_PRIORITY IN (" + priorityselected + ")";
                chart3_2 = chart3_2 + " AND AREA_PRIORITY IN (" + priorityselected + ")";
                chart4_2 = chart4_2 + " AND AREA_PRIORITY IN (" + priorityselected + ")";
            }
            else
            {
                chart1_2 = " WHERE AREA_PRIORITY IN (" + priorityselected + ")";
                chart2_2 = " WHERE AREA_PRIORITY IN (" + priorityselected + ")";
                chart3_2 = " WHERE AREA_PRIORITY IN (" + priorityselected + ")";
                chart4_2 = " WHERE AREA_PRIORITY IN (" + priorityselected + ")";
            }
        }
        if (areaselected.Length > 1)
        {
            if (priorityselected.Length > 1 || milestoneselected.Length > 1)
            {
                chart1_2 = chart1_2 + " AND AREA IN (" + areaselected + ")";
                chart2_2 = chart2_2 + " AND AREA IN (" + areaselected + ")";
                chart3_2 = chart3_2 + " AND AREA IN (" + areaselected + ")";
                chart4_2 = chart4_2 + " AND AREA IN (" + areaselected + ")";
            }
            else
            {
                chart1_2 = chart1_2 + " WHERE AREA IN (" + areaselected + ")";
                chart2_2 = chart2_2 + " WHERE AREA IN (" + areaselected + ")";
                chart3_2 = chart3_2 + " WHERE AREA IN (" + areaselected + ")";
                chart4_2 = chart4_2 + " WHERE AREA IN (" + areaselected + ")";
            }
        }

        sqlIsomeSheetStatus.SelectCommand = chart1_1 + chart1_2 + chartgroup;
        sqlInchDiaStatus.SelectCommand = chart2_1 + chart2_2 + chartgroup;
        FabMatAvlStatus.SelectCommand = chart3_1 + chart3_2 + chartgroup;
        SpoolFabStatus.SelectCommand = chart4_1 + chart4_2 + chartgroup;

        PieChart1.DataSource = sqlIsomeSheetStatus;
        PieChart1.DataBind();
        PieChart2.DataSource = sqlInchDiaStatus;
        PieChart2.DataBind();
        PieChart3.DataSource = FabMatAvlStatus;
        PieChart3.DataBind();
        //PieChart4.DataSource = SpoolFabStatus;
        //PieChart4.DataBind();
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        try
        {
            WebTools.ExecuteProcedure("PRC_REFRESH_DASHBOARD");
            Master.ShowSuccess("Data Refreshed!");
        }
        catch (Exception ex)
        {
            Master.ShowMessage(ex.Message);
        }
    }

    //protected void rdoCountOrInchdia_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (rdoCountOrInchdia.SelectedValue.Equals("ID"))
    //    {
    //        PieChart6.DataBind();
    //        PieChart6.Visible = true;
    //        PieChart5.Visible = false;
    //    }
    //    else
    //    {
    //        PieChart5.DataBind();
    //        PieChart5.Visible = true;
    //        PieChart6.Visible = false;
    //    }
    //}

    protected void btnExportPlannedVsActual_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(dsISOPlanningReport, "PlannedVsActual.xls");
    }
}