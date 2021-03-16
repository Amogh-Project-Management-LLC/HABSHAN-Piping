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
using dsWeldersTableAdapters;
using Telerik.Web.UI;
using System.IO;

public partial class WeldingInspec_WelderProducJoints : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Welder Production Joints";
            WELDER_CODE_HiddenField.Value =
                WebTools.GetExpr("WELDER_NO", "PIP_WELDERS", "WELDER_ID=" + Request.QueryString["WELDER_ID"]);

            string JOINT_ID = WebTools.GetExpr("JOINT_ID", "PIP_WELDERS_PROD_JNTS", "WELDER_ID=" + Request.QueryString["WELDER_ID"]);
            if (!string.IsNullOrEmpty(JOINT_ID))
            {
                btnAuto.Enabled = false;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("WelderRegistration.aspx");
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        PIP_WELDER_PROD_JNTSTableAdapter joints = new PIP_WELDER_PROD_JNTSTableAdapter();
        try
        {
            joints.InsertQuery(Decimal.Parse(Request.QueryString["WELDER_ID"]),
                Decimal.Parse(cboJoints.SelectedValue.ToString()), txtSelBy.Text,
                txtRemarks.Text);
            jointsGridView.DataBind();
            Master.ShowMessage("Production joint created.");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
        finally
        {
            joints.Dispose();
        }
    }

    protected void btnEntry_Click(object sender, EventArgs e)
    {
        if (EntryTable.Visible == false)
        {
            EntryTable.Visible = true;
            btnRegister.Visible = true;
        }
        else
        {
            EntryTable.Visible = false;
            btnRegister.Visible = false;
        }
    }

    protected void cboJoints_DataBinding(object sender, EventArgs e)
    {
        cboJoints.Items.Clear();
        cboJoints.Items.Add(new Telerik.Web.UI.DropDownListItem("(Select)", "-1"));
    }
    protected void btnAuto_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowError("Access Denied!");
            return;
        }

        try
        {
            string RET_VAL = WebTools.GetExpr(String.Format("FNC_PROD_JOINTS_A({0},{1})", Request.QueryString["WELDER_ID"], 5), "DUAL", string.Empty);
            jointsGridView.DataBind();
            Master.ShowMessage("Updated!");
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void jointsGridView_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {

            GridDataItem item = (GridDataItem)e.Item;
            string nde_rep_no = item["NDE_REP_NO"].Text;
            string filename = nde_rep_no + ".pdf";
            string pdf_url = "";
            string pdf_asp_url = "";
            pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'RT'");
            pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'RT'");
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
}