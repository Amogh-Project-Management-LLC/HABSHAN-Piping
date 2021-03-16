using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Material_MaterialSubstitution : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Material Substitution";
            Master.AddModalPopup("~/Material/MaterialSubstitutionNew.aspx", btnAdd.ClientID, 400, 600);
            Master.RadGridList = itemsGrid.ClientID;
        }
    }

    protected void itemsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "DELETE")
        {
            if (!WebTools.UserInRole("MM_DELETE"))
            {
                Master.ShowWarn("Access Denied!");
                return;
            }
        }

        if (e.CommandName.ToUpper() == "EDIT")
        {
            if (!WebTools.UserInRole("MM_UPDATE"))
            {
                Master.ShowWarn("Access Denied!");
                e.Canceled = true;
                return;
            }
        }
    }

    protected void btnDetails_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Request Number to Proceed.");
            return;
        }
        Response.Redirect("MaterialSubstitutionItems.aspx?REQ_ID=" + itemsGrid.SelectedValue);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (itemsGrid.SelectedIndexes.Count == 0)
        {
            Master.ShowError("Select Request Number to Proceed.");
            return;
        }
        Response.Redirect("ReportViewer.aspx?ReportID=23&Arg1=" + itemsGrid.SelectedValue);
    }

    protected void itemsGrid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string REQ_ID = item.GetDataKeyValue("REQ_ID").ToString();
            string REQ_NO = WebTools.GetExpr("REQ_NO", "PIP_MAT_SUBSTITUTE", " REQ_ID = " + REQ_ID);
            string filename = REQ_NO + ".pdf";

            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_SUBSTITUTE'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MAT_SUBSTITUTE'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");
          

            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("pdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }
}