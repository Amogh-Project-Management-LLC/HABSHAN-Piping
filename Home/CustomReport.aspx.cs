using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;


public partial class Home_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
           

           
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {

        RadPersistenceManager1.StorageProvider = new XMLStorageProvider();
        string report_code = Request.QueryString["REPORT_CODE"].ToString();
        string rep_id = WebTools.GetExpr("EXPT_ID", "CUSTOM_REPORT_INDEX", " WHERE REPORT_CODE=" + report_code);
        SqlDataSource1.SelectCommand = WebTools.GetExpr("EXPT_SQL", "IPMS_SYS_EXPORT", " WHERE EXPT_ID=" + rep_id);
    }

    protected void CheckBoxEnableDragDrop_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkBox = sender as CheckBox;
        this.RadPivotGrid1.ConfigurationPanelSettings.EnableDragDrop = checkBox.Checked;
        this.RadPivotGrid1.Rebind();
    }
    protected void CheckBoxEnableFieldsContextMenu_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkBox = sender as CheckBox;
        this.RadPivotGrid1.ConfigurationPanelSettings.EnableFieldsContextMenu = checkBox.Checked;
        this.RadPivotGrid1.Rebind();
    }
    protected void RadComboBoxPosition_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        PivotGridConfigurationPanelPosition position =
            (PivotGridConfigurationPanelPosition)Enum.Parse(typeof(PivotGridConfigurationPanelPosition), RadComboBoxPosition.SelectedValue);
        this.RadPivotGrid1.ConfigurationPanelSettings.Position = position;
        if (position == PivotGridConfigurationPanelPosition.FieldsWindow)
        {
            this.RadPivotGrid1.EnableZoneContextMenu = true;
        }
        else
        {
            this.RadPivotGrid1.EnableZoneContextMenu = false;
        }
        this.RadPivotGrid1.Rebind();
    }

    protected void ButtonExcel_Click(object sender, EventArgs e)
    {
        string alternateText = (sender as ImageButton).AlternateText;
        RadPivotGrid1.ExportSettings.Excel.Format = (PivotGridExcelFormat)Enum.Parse(typeof(PivotGridExcelFormat), alternateText);
        RadPivotGrid1.ExportSettings.IgnorePaging = CheckBox1.Checked;
        RadPivotGrid1.ExportToExcel();
    }

    protected void ButtonWord_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        RadPivotGrid1.ExportSettings.IgnorePaging = CheckBox1.Checked;
        RadPivotGrid1.ExportToWord();
    }


    protected void saveBtn_Click(object sender, EventArgs e)
    {
        try
        {
            RadPersistenceManager1.StorageProviderKey = "CustomPersistenceSettingsKey";
            RadPersistenceManager1.SaveState();
            Master.ShowSuccess("Saved");
        }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    protected void loadBtn_Click(object sender, EventArgs e)
    {
        string fileId = "CustomPersistenceSettingsKey";
        RadPersistenceManager1.StorageProviderKey = fileId;
        RadPersistenceManager1.LoadState();
        RadPivotGrid1.Rebind();
    }

    protected void RadPivotGrid1_FieldCreated(object sender, PivotGridFieldCreatedEventArgs e)
    {
       
    }

    protected void RadPivotGrid1_DataBinding(object sender, EventArgs e)
    {
    }

    protected void RadPivotGrid1_NeedDataSource(object sender, PivotGridNeedDataSourceEventArgs e)
    {

    }
}