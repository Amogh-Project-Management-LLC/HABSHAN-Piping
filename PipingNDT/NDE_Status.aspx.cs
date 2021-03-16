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
using System.IO;

public partial class PipingNDT_NDE_Status : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            if (Session["S_NDE_TYPE_ID"] != null)
                ddNDE_Type.SelectedValue = Session["S_NDE_TYPE_ID"].ToString();

            Master.HeadingMessage = "NDT Status";

            Master.RadGridList = RadGrid1.ClientID;

      
           // Master.AddModalPopup("~/PipingNDT/NDE_StatusUpdate.aspx", btnStatus.ClientID, 450, 650);
            ///Master.AddModalPopup("~/PipingNDT/NDE_StatusSegment.aspx", btnSegment.ClientID, 500, 850);
          //  Master.AddModalPopup("~/PipingNDT/NDE_StatusAdd.aspx", ImageButtonAdd.ClientID, 450, 500);
          //  Master.AddModalPopup("~/PipingNDT/NDE_StatusPenalty.aspx", btnPenalty.ClientID, 400, 600);

            if (Session["popup_NDE_ITEM_ID"] == null)
            {
                Session.Add("popup_NDE_ITEM_ID", "");
            }
        }
    }
    private string RadGrid_NDE_ITEM_ID()
    {
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                return item.GetDataKeyValue("NDE_ITEM_ID").ToString();
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
   //protected void ddNDE_Type_DataBinding(object sender, EventArgs e)
    //{
    //    ddNDE_Type.Items.Clear();
    //    ddNDE_Type.Items.Add(new DropDownListItem("Select Type", "-1"));
    //}
    //private void update_NDE_TYPE_Dropdown()
    //{
    //    for (int i = 0; i < ddNDE_Type.Items.Count; i++)
    //    {
    //        //if (ddNDE_Type.Items[i].Value.ToString() == NDE_TYPE_ID_HiddenField.Value.ToString())
    //        //{
    //        //    ddNDE_Type.Items[i].Selected = true;
    //        //    break;
    //        //}
    //    }
    //}
    protected void btnShowFilter_Click(object sender, EventArgs e)
    {
        //    if (FilterTable.Visible == false)
        //    {
        //        FilterTable.Visible = true;
        //        btnApplyFilter.Visible = true
        //            ;
        //        update_NDE_TYPE_Dropdown();

        //    }
        //    else
        //    {
        //        FilterTable.Visible = false;
        //        btnApplyFilter.Visible = false;
        //    }
        }
        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            //    if (ddNDE_Type.SelectedItem.Text == "RT")
            //    {
            //        btnPenalty.Enabled = true;
            //    }
            //    else
            //    {
            //        btnPenalty.Enabled = false;
            //    }



            //    RadGrid1.DataBind();
        }
        //protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    Session["popup_NDE_ITEM_ID"] = RadGrid_NDE_ITEM_ID();
        //}

    protected void btnBulkRep_Click(object sender, EventArgs e)
    {
        //  Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=18&RetUrl=" + "~/PipingNDT/NDE_RequestJoints.aspx&NDE_REQ_ID=" + Request.QueryString["NDE_REQ_ID"] + "&NDE_TYPE_ID=" + Request.QueryString["NDE_TYPE_ID"] + "&SC_ID=" + Request.QueryString["SC_ID"]);
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=18&RetUrl=" + "~/PipingNDT/NDE_Request.aspx");
    }



    protected void btnStatus_Click(object sender, EventArgs e)
    {
        if(RadGrid1.SelectedItems.Count<=0)
        {
            Master.ShowError("Select a Joint");
            return;
        }

        string joint_id = "";
        string req_id = "";
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                joint_id= item.GetDataKeyValue("JOINT_ID").ToString();
                req_id = item.GetDataKeyValue("NDE_REQ_ID").ToString();
            }
        }

        //string nde_date = WebTools.GetExpr("NDE_DATE", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_REQ_ID=" +req_id + " AND JOINT_ID=" + joint_id);
        //if (nde_date != "")
        //{
        //    Master.ShowError("NDE Report Already updated,Clear Existing report and update!");
        //    return;
        //}

        //Button btn2 = sender as Button;
        //GridDataItem item1 = btn2.NamingContainer as GridDataItem;
        //string nde_req_id = item1.GetDataKeyValue("NDE_REQ_ID").ToString();
        Response.Redirect("~/PipingNDT/NDE_StatusUpdate.aspx?NDE_REQ_ID="+req_id+"&joint_id="+joint_id);

     
    }

    protected void ddNDE_Type_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        Session["S_NDE_TYPE_ID"] = ddNDE_Type.SelectedValue.ToString();
    }

    protected void btnPenalty_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedItems.Count <= 0)
        {
            Master.ShowError("Select a Joint");
            return;
        }

        string joint_id = "";
        string req_id = "";
        foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
        {
            if (item.Selected)
            {
                joint_id = item.GetDataKeyValue("JOINT_ID").ToString();
                req_id = item.GetDataKeyValue("NDE_REQ_ID").ToString();
            }
        }
        string pass_flg = WebTools.GetExpr("pass_flg_id", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_REQ_ID=" + req_id + " AND JOINT_ID=" + joint_id);
        if(pass_flg!="2")
        {
            Master.ShowError("Only Rejected Joints can have penalty!");
            return;
        }
        if(pass_flg=="2")
        {
            string nde_item_id = WebTools.GetExpr("NDE_ITEM_ID", "PIP_NDE_REQUEST_JOINTS", " WHERE NDE_REQ_ID=" + req_id + " AND JOINT_ID=" + joint_id);
            Response.Redirect("~/PipingNDT/NDE_StatusPenalty.aspx?NDE_REQ_ID=" + req_id + "&joint_id=" + joint_id+"&nde_item_id="+ nde_item_id);
        }


    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
      
            if (e.Item is GridDataItem)
            {
            
            GridDataItem item = (GridDataItem)e.Item;
            string nde_rep_no= item["NDE_REP_NO"].Text;

            string filename = nde_rep_no + ".pdf";
            string nde_type=ddNDE_Type.SelectedValue;
            string pdf_url = "";
            string pdf_asp_url = "";
            switch(nde_type)
            {
                case "1":
                case "2":
                    pdf_url= WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'RT'"); 
                    pdf_asp_url= WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'RT'");
                    break;
                case "12":
                case "13":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'UT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'UT'");
                    break;
                case "3":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PT'");
                    break;
                case "5":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'MT'");
                    break;
                case "7":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PWHT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PWHT'");
                    break;
                case "8":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'HT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'HT'");
                    break;
                case "9":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PMI'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PMI'");
                    break;
                case "10":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'FT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'FT'");
                    break;
                case "11":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'LT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'LT'");
                    break;
                case "15":
                    pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PAUT'");
                    pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'PAUT'");
                    break;
            }

                string full_pdf_path = pdf_url + filename;
                string full_asp_path = pdf_asp_url + filename;
                Label pdf_label = (Label)item.FindControl("pdf");

                if (File.Exists(full_pdf_path))
                {
                    string url = "<a title='Receive PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                    Label pdficon = (Label)item.FindControl("pdf");
                    if (pdficon != null)
                        pdficon.Text = url;
                }
            }
        
    }

    protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
        }
    }
}