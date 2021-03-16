using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolCoatingUpdate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Coating Reports";
            if (ViewState["TYPE_ID"] != null)
            {
                ddlCoatingTypeList.SelectedIndex = Int32.Parse(ViewState["TYPE_ID"].ToString());
            }

            Master.AddModalPopup("~/SpoolMove/SpoolCoatingReport.aspx", btnUpdate.ClientID, 500, 750);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void ddlCoatingTypeList_DataBinding(object sender, EventArgs e)
    {
        ddlCoatingTypeList.Items.Clear();
        ddlCoatingTypeList.Items.Add(new Telerik.Web.UI.DropDownListItem("(Coating Type Request)", "-1"));
    }

    protected void ddlCoatingTypeList_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        ViewState["TYPE_ID"] = ddlCoatingTypeList.SelectedIndex;
    }
}