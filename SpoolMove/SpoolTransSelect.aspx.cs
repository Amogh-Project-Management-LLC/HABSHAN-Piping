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

public partial class SpoolMove_SpoolTransSelect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Spool Activity";
            if (Session["SELECTED_SPL_TRANS_CAT"] != null)
            {
                transCatList.SelectedValue = Session["SELECTED_SPL_TRANS_CAT"].ToString();
            }
        }
    }

    protected void btnContinue_Click(object sender, EventArgs e)
    {
        if (transCatList.SelectedIndex < 0)
        {
            Master.ShowMessage("Select Activity.");
            return;
        }

        var cat_id = transCatList.SelectedValue.ToString();
        Session["SELECTED_SPL_TRANS_CAT"] = cat_id;

        switch (cat_id)
        {
            case "8":
                Response.Redirect("SpoolSRN.aspx?CAT_ID=" + cat_id);
                break;
            case "14":
                Response.Redirect("SpoolTransfer.aspx");
                break;
            case "13":
                Response.Redirect("SpoolReceive.aspx");
                break;
            default:
                Response.Redirect("SpoolTrans.aspx?CAT_ID=" + cat_id);
                break;
        }

    }


    //protected void btnUpdateSpools_Click(object sender, EventArgs e)
    //{
    //    General_Functions.Update_Spool_Transmittal();
    //    Master.ShowMessage("Update done successfully!");
    //}

    protected void transCatList_DataBound(object sender, EventArgs e)
    {
        if (transCatList.Items.Count > 0)
        {
            transCatList.SelectedIndex = 0;
        }
    }
}