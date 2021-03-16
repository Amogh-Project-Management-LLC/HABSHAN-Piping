using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Home_ViewReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if (!WebTools.UserInRole("VIEW_PDF_REPORTS_SELECT"))
            //{
            //    Response.Redirect("~/Index.aspx");
            //    return;
            //}

            Master.HeadingMessage = "View PDF Reports";
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {

    }

    protected void ddlIsome_DataBinding(object sender, EventArgs e)
    {
        ddlIsome.Items.Clear();
        ddlIsome.Items.Add(new ListItem("(SELECT ISOMETRIC)", ""));
    }

    protected void ddlSpool_DataBinding(object sender, EventArgs e)
    {
        ddlSpool.Items.Clear();
        ddlSpool.Items.Add(new ListItem("(ALL SPOOLS)", "-99"));
    }

    //protected void ddlJoint_DataBinding(object sender, EventArgs e)
    //{
    //    ddlJoint.Items.Clear();
    //    ddlJoint.Items.Add(new ListItem("(ALL JOINTS)", "-99"));
    //}

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = RadioButtonList1.SelectedIndex;
    }


    protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string filelink = item["FILE_LINK1"].Text;
            string filepath = item["FILE_PATH"].Text;
            //string filepath = (item["FILE_LINK1"].Controls[0] as TextBox).Text;

            if (File.Exists(filepath))
            {
                string url = "<a title='PDF' href='" + filelink + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

    protected void RadGrid2_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string filelink=item["FILE_LINK1"].Text;
            string filepath = item["FILE_PATH"].Text;
            //string filepath = (item["FILE_LINK1"].Controls[0] as TextBox).Text;

            if (File.Exists(filepath))
            {
                string url = "<a title='PDF' href='" + filelink + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }

    }



    protected void RadGrid2_PreRender(object sender, EventArgs e)
    {         
        RadGrid2.MasterTableView.GetColumn("FILE_LINK1").Display = false;
        RadGrid2.MasterTableView.GetColumn("FILE_PATH").Display = false;
    }

    protected void RadGrid1_PreRender(object sender, EventArgs e)
    {
        RadGrid1.MasterTableView.GetColumn("FILE_LINK1").Display = false;
        RadGrid1.MasterTableView.GetColumn("FILE_PATH").Display = false;
    }
}