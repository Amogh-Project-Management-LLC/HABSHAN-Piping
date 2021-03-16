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
using dsMainTablesATableAdapters;

public partial class Erection_ErectionRepRegister : System.Web.UI.Page
{
    string size_desc = string.Empty;
    string size_a = string.Empty;
    string size_b = string.Empty;
    string sch_desc = string.Empty;
    string sch_a = string.Empty;
    string sch_b = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("New");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string bolt_len;
        if (txtBoltLength.Text == "")
        {
            bolt_len = "0";
        }
        else
        {
            bolt_len = txtBoltLength.Text;
        }
        PIP_MAT_STOCKTableAdapter stock = new PIP_MAT_STOCKTableAdapter();
        try
        {
            stock.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()),
                txtMatCode1.Text, txtMatCode2.Text,
                txtsizeDesc.Text.Trim(), txtSize1.Text, txtSize2.Text, txtSchDesc.Text,
                txtSch1.Text, txtSch2.Text, decimal.Parse(cboItem.SelectedValue.ToString()),
                decimal.Parse(cboUOM.SelectedValue.ToString()), decimal.Parse(bolt_len), txtDesc.Text, txtlength.Text,decimal.Parse(txtlen1.Text),decimal.Parse(txtlen2.Text),ddlProfile.SelectedValue.ToString());
            Master.show_success(txtMatCode1.Text + " Saved!");

          
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
        finally
        {
            stock.Dispose();
        }
    }

 

    protected void txtAutoSize_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        //if (txtAutoSize.Entries.Count > 0)
        //{
        //    string size_desc = txtAutoSize.Entries[0].Text;
        //    string[] size;
        //    if (size_desc.ToUpper().Contains("X"))
        //    {
        //        size = size_desc.Split('X');

        //        txtSize1.Text = size[0].Trim();
        //        txtSize2.Text = size[1].Trim();
        //    }
        //    else
        //    {
        //        txtSize1.Text = size_desc.Trim();
        //        txtSize2.Text = "";
        //    }
        //}
        //else
        //{
        //    txtSize1.Text = "";
        //    txtSize2.Text = "";
        //}
    }

    protected void txtSize_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        if(txtSize1.Entries.Count>0)
        size_desc = txtSize1.Entries[0].Text;
        if (txtSize2.Entries.Count>0)
        {
            if(txtSize1.Entries.Count <1)
            {
                size_desc = txtSize2.Entries[0].Text;
            }
            else
            {
                size_desc=size_desc+" X "+ txtSize2.Entries[0].Text; 
            }
        }
        txtsizeDesc.Text = "";
        txtsizeDesc.Text = size_desc;
    }





    protected void txtSch_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        if (txtSch1.Entries.Count > 0)
            sch_desc = txtSch1.Entries[0].Text;
        if (txtSch2.Entries.Count > 0)
        {
            if (txtSch1.Entries.Count < 1)
            {
                sch_desc = txtSch2.Entries[0].Text;
            }
            else
            {
                sch_desc = sch_desc + " X " + txtSch2.Entries[0].Text;
            }
        }
        txtSchDesc.Text = "";
        txtSchDesc.Text = sch_desc;
    }


    protected void txtlen_TextChanged(object sender, EventArgs e)
    {
        decimal leng=0;
           if (txtlen1.Text != "")
            leng = leng + (decimal.Parse(txtlen1.Text));
           if(txtlen2.Text!="")
            leng=leng+ (decimal.Parse(txtlen2.Text));

        txtlength.Text = leng+"";

    }
}