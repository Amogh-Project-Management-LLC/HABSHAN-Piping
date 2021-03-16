using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class SpoolMove_SpoolCoatingReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.HeadingMessage("Spool Coating Reports - Update");
    }

    protected void ddlCoatingTypeList_DataBinding(object sender, EventArgs e)
    {
        ddlCoatingTypeList.Items.Clear();
        ddlCoatingTypeList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Coating Type Request)", "-1"));
    }

    protected void cboSpoolList_DataBinding(object sender, EventArgs e)
    {

    }

    protected void txtSearchIsome_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        HiddenISO.Value = WebTools.GetExpr("ISO_ID", "PIP_ISOMETRIC", " WHERE ISO_TITLE1 = '" + txtSearchIsome.Text + "'");
    }

    protected void ddlSubcon_DataBinding(object sender, EventArgs e)
    {
        ddlSubcon.Items.Clear();
        ddlSubcon.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", ""));
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsPaintingRepsTableAdapters.VIEW_SPL_COATING_REPORTTableAdapter coating = new dsPaintingRepsTableAdapters.VIEW_SPL_COATING_REPORTTableAdapter();
            string jc_id = string.Empty;
            foreach (RadComboBoxItem item in cboSpoolList.CheckedItems)
            {
                jc_id = WebTools.GetExpr("JC_ID", "VIEW_SPL_COATING_REPORT", " WHERE SPL_ID = '" + item.Value + "' AND TYPE_ID = '" + ddlCoatingTypeList.SelectedValue + "' AND COAT_REP_DT IS NULL");
                coating.UpdateQuery(txtCoatingRep.Text, txtCoatingDate.SelectedDate.ToString(), txtBlastRep.Text, txtBlastDate.SelectedDate, decimal.Parse(jc_id),
                    decimal.Parse(item.Value));
                Master.show_success("Report Updated.");
            }
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}