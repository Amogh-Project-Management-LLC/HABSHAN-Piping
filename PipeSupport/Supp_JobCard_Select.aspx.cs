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
using dsSupp_BTableAdapters;

public partial class PipeSupport_Supp_JobCard_Select : System.Web.UI.Page
{
    //ArrayList arraylist1 = new ArrayList();
    //ArrayList arraylist2 = new ArrayList();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!WebTools.UserInRole("PIPSUPP_UPDATE"))
            {
                Master.ShowWarn("Access Denied!");
                btnSave.Enabled = false;
            }

            Master.HeadingMessage = "Support Selection <br/>" +
            WebTools.GetExpr("JC_NO", "PIP_SUPP_JC", "JC_ID=" + Request.QueryString["JC_ID"]);
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Supp_JobCard.aspx?Filter=" + Request.QueryString["Filter"]);
    }
    protected void btnMbrs_Click(object sender, EventArgs e)
    {
        if (Selected_Supports.Items.Count == 0)
        {
            Master.ShowMessage("No Support selected!");
            return;
        }

        VIEW_ADP_SUPP_JC_DTTableAdapter supp_jc = new VIEW_ADP_SUPP_JC_DTTableAdapter();

        try
        {
            if (Selected_Supports.Items.Count > 0)
            {
                for (int i = 0; i < Selected_Supports.Items.Count; i++)
                {

                    //Save Support; QTY=1;
                    supp_jc.InsertQuery(decimal.Parse(Request.QueryString["JC_ID"]),
                        decimal.Parse(Selected_Supports.Items[i].Value), decimal.Parse("1"));

                    //if (!arraylist2.Contains(Selected_Supports.Items[i]))
                    //{
                    //    arraylist2.Add(Selected_Supports.Items[i]);
                    //}
                }

                Selected_Supports.Items.Clear();
                btnSave.Enabled = false;
                NotificationBox.show_success("Saved!");
            }
            else
            {
                NotificationBox.show_info("No Support selected!");
                return;
            }
        }
        catch (Exception ex)
        {
            NotificationBox.show_error(ex.Message);
        }
        finally
        {
            supp_jc.Dispose();
        }
    }
    protected void btnApplyFilter_Click(object sender, EventArgs e)
    {
        if (btnSave.Enabled == false)
        {
            btnSave.Enabled = true;
        }

        All_Supports.DataBind();
    }

    protected void PipingJC_CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (PipingJC_CheckBox.Checked == true)
        {
            PipingJC_HiddenField.Value = "Y";
        }
        else
        {
            PipingJC_HiddenField.Value = "N";
        }
    }
}