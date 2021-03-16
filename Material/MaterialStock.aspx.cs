using System;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using dsMainTablesATableAdapters;

public partial class Isome_MaterialStock : System.Web.UI.Page
{
    bool modechanged = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string mat_id = Request.QueryString["MAT_ID"];
            if (mat_id != null)
            {
                //ListBoxDataSource.SelectParameters.Clear();
                //ListBoxDataSource.SelectCommand = "SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK WHERE MAT_ID=" + mat_id;
                //txtItemCode.Enabled = false;
                //ListBox1.Visible = false;
            }
            Master.HeadingMessage = "Material Catalog";
            string mat_code = Session["STK_MAT_CODE"].ToString();
            if (mat_code != "") txtItemCode.Text = mat_code;

            Master.RadGridList = "";
            Master.AddModalPopup("~/Material/MaterialStockRegister.aspx", btnRegister.ClientID, 650, 750);
        }
    }

    protected void ListBox1_DataBound(object sender, EventArgs e)
    {
        if (ListBox1.Items.Count > 1)
        {
            ListBox1.SelectedIndex = 1;
        }
        save_filter();
    }

    protected void StockDetailsView_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString["MAT_ID"] != null & !IsPostBack)
        {
            ListBox1.Visible = false;
        }

        if (StockDetailsView.CurrentMode == DetailsViewMode.Edit & modechanged == true)
        {
            string size1 = WebTools.GetExpr("size1", "PIP_MAT_STOCK", " WHERE MAT_ID=" + ListBox1.SelectedValue.ToString());
            if (size1 != "")
            {
                RadAutoCompleteBox txtSize1 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSize1");
                txtSize1.Entries.Add(new AutoCompleteBoxEntry(size1));
            }
            string size2 = WebTools.GetExpr("size2", "PIP_MAT_STOCK", " WHERE MAT_ID=" + ListBox1.SelectedValue.ToString());
            if (size2 != "")
            {
                RadAutoCompleteBox txtSize2 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSize2");
                txtSize2.Entries.Add(new AutoCompleteBoxEntry(size2));
            }

            string thk1 = WebTools.GetExpr("thk1", "PIP_MAT_STOCK", " WHERE MAT_ID=" + ListBox1.SelectedValue.ToString());
            if (thk1 != "")
            {
                RadAutoCompleteBox txtSch1 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSch1");
                txtSch1.Entries.Add(new AutoCompleteBoxEntry(thk1));
            }
            string thk2 = WebTools.GetExpr("thk2", "PIP_MAT_STOCK", " WHERE MAT_ID=" + ListBox1.SelectedValue.ToString());
            if (thk2 != "")
            {
                RadAutoCompleteBox txtSch2 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSch2");
                txtSch2.Entries.Add(new AutoCompleteBoxEntry(thk2));
            }

        }
        modechanged = false;
    }

    protected void txtItemCode_TextChanged(object sender, EventArgs e)
    {
        clear_listbox();
        txtItemCode.Text = txtItemCode.Text.ToUpper().Trim();
        MatListDataSource.DataBind();
    }

    private void clear_listbox()
    {
        ListBox1.Items.Clear();
        ListBox1.Items.Add(new RadListBoxItem("(Select One)", "-1"));
    }

    protected void StockDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE") && e.NewMode == DetailsViewMode.Edit)
        {
            Master.ShowWarn("Access Denied - Error 403.");
            e.Cancel = true;
        }

        modechanged = true;

    }

    protected void btnPOdepend_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnRecvd_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Received.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnHeatNos_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_HeatNo.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnMTC_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex < 0)
        {
            Master.ShowMessage("No material selected!");
            return;
        }
        Response.Redirect("MaterialStock_MTC.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnJC_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_JC.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void save_filter()
    {
        Session["STK_MAT_CODE"] = txtItemCode.Text;
        Session["STK_LIST_INDEX"] = ListBox1.SelectedIndex.ToString();
    }

    protected void btnJoints_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Joints.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        // tip();
    }



    protected void btnAddIssue_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex < 0)
        {
            Master.ShowMessage("No material selected!");
            return;
        }
        Response.Redirect("MaterialStock_Additional.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        Response.Redirect("MaterialStockRegister.aspx");
    }

    protected void btnSummary_Click(object sender, EventArgs e)
    {
        Response.Redirect("MaterialStock_Recon_A.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnBOM_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_BOM_QTY.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }
    protected void btnInventoryAlloc_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Alloc.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }


    protected void Item_Click_MIR()
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_PO.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnMRIR_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_MRIR.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnTrans_Click(object sender, EventArgs e)
    {
        if (ListBox1.SelectedIndex > 0)
            Response.Redirect("MaterialStock_Transfer.aspx?MAT_ID=" + ListBox1.SelectedValue.ToString());
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        WebTools.ExportDataSetToExcel(sqlExport, "TOTAL_MATERIAL_LIST.xls");
    }

    protected string getSize()
    {
        TextBox txtsizeDesc = (TextBox)StockDetailsView.FindControl("txtSizeDesc");
        string size_desc = "";
        RadAutoCompleteBox txtSize1 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSize1");
        RadAutoCompleteBox txtSize2 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSize2");
        if (txtSize1.Entries.Count > 0)
            size_desc = txtSize1.Entries[0].Text;
        if (txtSize2.Entries.Count > 0)
        {
            if (txtSize1.Entries.Count < 1)
            {
                size_desc = txtSize2.Entries[0].Text;
            }
            else
            {
                size_desc = size_desc + " X " + txtSize2.Entries[0].Text;
            }
        }
        txtsizeDesc.Text = "";
        txtsizeDesc.Text = size_desc;
        return size_desc;
    }

    protected string getSch()
    {
        TextBox txtSchDesc = (TextBox)StockDetailsView.FindControl("txtSchDesc");
        string sch_desc = "";
        RadAutoCompleteBox txtSch1 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSch1");
        RadAutoCompleteBox txtSch2 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSch2");

        if (txtSch1.Entries.Count > 0)
            sch_desc = string.IsNullOrEmpty(txtSch1.Entries[0].Text) ? txtSch1.Text : txtSch1.Entries[0].Text;
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
        return sch_desc;
    }

    protected void txtSize_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {
        getSize();
        getSch();
    }
    protected void txtSch_TextChanged(object sender, Telerik.Web.UI.AutoCompleteTextEventArgs e)
    {

    }

    protected void txtlen_TextChanged(object sender, EventArgs e)
    {
        decimal leng = 0;
        TextBox txtlength = (TextBox)StockDetailsView.FindControl("txtlength");
        TextBox txtlen1 = (TextBox)StockDetailsView.FindControl("txtlen1");
        TextBox txtlen2 = (TextBox)StockDetailsView.FindControl("txtlen2");

        if (txtlen1.Text != "")
            leng = leng + (decimal.Parse(txtlen1.Text));
        if (txtlen2.Text != "")
            leng = leng + (decimal.Parse(txtlen2.Text));

        txtlength.Text = leng + "";

    }




    protected void StockDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        PIP_MAT_STOCKTableAdapter stock_adapter = new PIP_MAT_STOCKTableAdapter();
        //dsMainTablesATableAdapters.PIP_MAT_STOCKTableAdapter stock = new PIP_MAT_STOCKTableAdapter();
        TextBox matcode1 = (TextBox)StockDetailsView.FindControl("txtMatcode1");
        TextBox matcode2 = (TextBox)StockDetailsView.FindControl("txtMatcode2");
        TextBox sizeDesc = (TextBox)StockDetailsView.FindControl("txtSizeDesc");

        RadAutoCompleteBox txtSize1 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSize1");
        RadAutoCompleteBox txtSize2 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSize2");

        RadAutoCompleteBox txtSch1 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSch1");
        RadAutoCompleteBox txtSch2 = (RadAutoCompleteBox)StockDetailsView.FindControl("txtSch2");
        TextBox schDesc = (TextBox)StockDetailsView.FindControl("txtSchDesc");
        TextBox unitwt = (TextBox)StockDetailsView.FindControl("txtUnitwt");

        TextBox length = (TextBox)StockDetailsView.FindControl("txtlength");
        TextBox len1 = (TextBox)StockDetailsView.FindControl("txtlen1");
        TextBox len2 = (TextBox)StockDetailsView.FindControl("txtlen2");

        RadDropDownList profile = (RadDropDownList)StockDetailsView.FindControl("ddlProfile");
        DropDownList item = (DropDownList)StockDetailsView.FindControl("ddlitem");
        DropDownList uom = (DropDownList)StockDetailsView.FindControl("ddlUOM");

        TextBox mat_type = (TextBox)StockDetailsView.FindControl("txtMatType");
        TextBox ptCode = (TextBox)StockDetailsView.FindControl("txtPtCode");
        TextBox mClass = (TextBox)StockDetailsView.FindControl("txtClass");
        TextBox shortDesc = (TextBox)StockDetailsView.FindControl("txtShortDescr");
        TextBox matDescr = (TextBox)StockDetailsView.FindControl("txtMatDescr");

        string sch = getSch();
        string size = getSize();
        stock_adapter.UpdateQuery(matcode1.Text, matcode2.Text, size, txtSize1.Entries[0].Text, txtSize2.Entries[0].Text, sch, txtSch1.Entries[0].Text,
            txtSch2.Entries[0].Text, decimal.Parse(unitwt.Text), decimal.Parse(item.SelectedValue.ToString()), decimal.Parse(uom.SelectedValue.ToString()), mat_type.Text,
            mClass.Text, ptCode.Text, shortDesc.Text, matDescr.Text, length.Text, decimal.Parse(len1.Text), decimal.Parse(len2.Text), profile.SelectedValue.ToString(), decimal.Parse(ListBox1.SelectedValue.ToString()));



        e.Cancel = true;

        StockDetailsView.ChangeMode(StockDetailsView.DefaultMode);
        StockDetailsView.DataBind();



    }

}
