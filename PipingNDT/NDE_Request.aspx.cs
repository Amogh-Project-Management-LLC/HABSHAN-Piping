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
using Telerik.Web.UI;

public partial class WeldingInspec_NDE_Request : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            if(Session["R_NDE_TYPE_ID"]!=null)
            ddNDE_Type.SelectedValue = Session["R_NDE_TYPE_ID"].ToString();

            Master.HeadingMessage = "NDT Request";

            Master.RadGridList = RadGrid1.ClientID;
            
            Master.AddModalPopup("~/PipingNDT/NDE_RequestNew.aspx", ImageButtonAdd.ClientID, 400, 700);

        }
    }
    protected void btnNew_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_INSERT"))
        {
            Master.ShowWarn("No Access!");
            return;
        }
        Response.Redirect("NDE_RequestNew.aspx?NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"]);
    }
    protected void btnBulkImport_Click(object sender, EventArgs e)
    {
        //  Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=18&RetUrl=" + "~/PipingNDT/NDE_RequestJoints.aspx&NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"] + "&SC_ID=" + Request.QueryString["SC_ID"]);
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=18&RetUrl=" + "~/PipingNDT/NDE_Request.aspx");
    }
    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        txtFilter.Text = txtFilter.Text.Trim().ToUpper();
    }
    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        HyperLinkPreview.NavigateUrl = "ReportViewer.aspx?ReportID=1&Arg1=" + RadGrid_NDE_REQ_ID();

        // new
        var req_id = RadGrid_NDE_REQ_ID();
        var nde_type_id = WebTools.GetExpr("NDE_TYPE_ID", "PIP_NDE_REQUEST", "NDE_REQ_ID=" + req_id);
        if(nde_type_id == "1")
        {
            HyperLinkPreview2.NavigateUrl = "ReportViewer.aspx?ReportID=2&Arg1=" + RadGrid_NDE_REQ_ID();
        }
    }
    private string RadGrid_NDE_REQ_ID()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("NDE_REQ_ID").ToString();
            }
        }
        return string.Empty;
    }
    protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
        }
    }
    protected void ddNDE_Type_DataBinding(object sender, EventArgs e)
    {
        ddNDE_Type.Items.Clear();
        ddNDE_Type.Items.Add(new DropDownListItem("Select Type", "-1"));
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count <= 0)
        {
            Master.ShowMessage("Select a request no!");
            return;
        }
        string sc_id= WebTools.GetExpr("SC_ID", "PIP_NDE_REQUEST", " WHERE NDE_REQ_ID=" + RadGrid_NDE_REQ_ID());
        Response.Redirect("NDE_RequestJoints.aspx?NDE_REQ_ID=" + RadGrid_NDE_REQ_ID() + "&NDE_TYPE_ID=" + ddNDE_Type.SelectedValue.ToString()+"&SC_ID="+sc_id);
    }
    protected void ddNDE_Type_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString["NDE_TYPE_ID"] != null)
        {
            for (int i = 0; i < ddNDE_Type.Items.Count; i++)
            {
                if (ddNDE_Type.Items[i].Value.ToString() == Request.QueryString["NDE_TYPE_ID"])
                {
                    ddNDE_Type.Items[i].Selected = true;
                    break;
                }
            }
        }
      
    }



    protected void ddNDE_Type_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        Session["R_NDE_TYPE_ID"] = ddNDE_Type.SelectedValue;
    }

   
}