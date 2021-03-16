using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Isome_DocTrans : System.Web.UI.Page
{
    string lot_no = "";
    string lot_to = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Default PIL
            string proj_code = WebTools.GetExpr("SHORT_CODE", "PROJECT_INFORMATION", "PROJECT_ID=" + Session["PROJECT_ID"].ToString());
            string prefix = proj_code+"-PIL-DCC-ST-";
            txtTransNo.Text = WebTools.NextSerialNo("DCS_TRANS_MASTER", "TRANS_NO", prefix, 4, " WHERE  VENDOR_ID=1");
            Master.HeadingMessage = "Master Transmittal";
        }

    }

    protected void RadMenu1_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        switch (e.Item.Value)
        {
            case "ADD":
              
            case "ITEMS":
               
            case "PREVIEW":
              
                break;
        }
    }
   
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
           
            //if session is not expired
            if (decimal.Parse(Session["PROJECT_ID"].ToString()) >0)
            {
                decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS",
                                 "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'"));
                dsMasterTransTableAdapters.DCS_TRANS_MASTERTableAdapter dcs = new dsMasterTransTableAdapters.DCS_TRANS_MASTERTableAdapter();
                DateTime transDate = DateTime.Parse(txtTransDate.SelectedDate.ToString());
                dcs.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtTransNo.Text, transDate,
                    decimal.Parse(ddlVendorList.SelectedValue.ToString()), txtAttnTo.Text, txtSubject.Text, ddlCategory.SelectedValue.ToString(),ddlPurpose.SelectedValue.ToString(), txtRemarks.Text, user_id);
                RadGrid1.Rebind();

             
                EntryTable.Visible = EntryTable.Visible ? false : true;
                Master.ShowMessage("Transmittal Number " + txtTransNo.Text + " Added.");
            }
            else
            {
                Response.Redirect(Request.RawUrl);
            }
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }


    protected void vendorList_IndexChanged(object sender, EventArgs e)
    {
        lot_to = ddlTo.SelectedValue.ToString();
        string short_name = WebTools.GetExpr("SHORT_NAME", "DCS_TRANS_VENDOR", "VENDOR_ID=" + decimal.Parse(ddlVendorList.SelectedValue));
        string proj_code = WebTools.GetExpr("SHORT_CODE", "PROJECT_INFORMATION", "PROJECT_ID=" + Session["PROJECT_ID"].ToString());
        lot_no = proj_code+"-"+ short_name +"-"+lot_to+"-ST-";
        string new_no = WebTools.NextSerialNo("DCS_TRANS_MASTER", "TRANS_NO", lot_no, 4, " WHERE TRANS_NO LIKE '%" + lot_no + "%'");
        txtTransNo.Text = new_no;
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
      
        EntryTable.Visible = EntryTable.Visible ? false : true;
    
    }  
      
    protected void btnDocList_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count > 0)
            Response.Redirect("DocTransDetail.aspx?Trans_ID=" + RadGrid1.SelectedValue);
       
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (RadGrid1.SelectedIndexes.Count > 0)
            Response.Redirect("ReportViewer_Docs.aspx?ReportiD=1&Arg1=" + RadGrid1.SelectedValue);
    }

    protected void ddlTo_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        lot_to = ddlTo.SelectedValue.ToString();
        string short_name = WebTools.GetExpr("SHORT_NAME", "DCS_TRANS_VENDOR", "VENDOR_ID=" + decimal.Parse(ddlVendorList.SelectedValue));
        string proj_code = WebTools.GetExpr("SHORT_CODE", "PROJECT_INFORMATION", "PROJECT_ID=" + Session["PROJECT_ID"].ToString());
        lot_no = proj_code+"-" + short_name + "-" + lot_to + "-ST-";
        string new_no = WebTools.NextSerialNo("DCS_TRANS_MASTER", "TRANS_NO", lot_no, 4, " WHERE TRANS_NO LIKE '%"+lot_no+"%'");  
        txtTransNo.Text = new_no;
    }
}