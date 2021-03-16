using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Isome_DocTransDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string trans_no = WebTools.GetExpr("TRANS_NO", "DCS_TRANS_MASTER", " WHERE TRANS_ID = '" + Request.QueryString["TRANS_ID"] + "'");
           
            Master.HeadingMessage = "Document List for Transmittal (" + trans_no + ")";
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            //check session expired
            if (decimal.Parse(Session["PROJECT_ID"].ToString()) > 0)
            {
                decimal user_id = decimal.Parse(WebTools.GetExpr("USER_ID", "USERS",
                                  "UPPER(USER_NAME)='" + Session["USER_NAME"].ToString().ToUpper() + "'"));
                var collection = ddlDocList.CheckedItems;
                string msg = "Below Documents were already added: </br> ";
                int doc_count = 0;
                int err_count = 0;
                foreach (var item in collection)
                {
                    string doc_value = item.Value;
                    string trans_id = WebTools.GetExpr("trans_id", "DCS_TRANS_MASTER_DT", " WHERE rev_no='" + txtRevNo.Text + "' and  doc_no = '" + doc_value + "'");
                    //condition to check doc and rev already exists
                    if (trans_id == string.Empty)
                    {
                        doc_count++;
                        string cat_id = WebTools.GetExpr("cat_id", "view_master_doc_no_src", " WHERE doc_no = '" + doc_value + "'");
                        dsMasterTransTableAdapters.DCS_TRANS_MASTER_DTTableAdapter trans = new dsMasterTransTableAdapters.DCS_TRANS_MASTER_DTTableAdapter();
                        trans.InsertQuery(Convert.ToDecimal(Request.QueryString["TRANS_ID"]), doc_value,
                            txtRevNo.Text, txtDocTitle.Text, txtCode.Text, Convert.ToDecimal(cat_id), user_id);
                    }
                    else
                    {
                        err_count++;
                        msg = msg + item.Text + " <br/> ";
                    }

                }
                RadGrid1.Rebind();
                msg = msg + "<br/> Documents  Added : " + doc_count;
                //If all the documents were added
                if (err_count == 0)
                {
                    Master.ShowMessage("Documents  Added : " + doc_count);
                }
                //if any doc with same already exists
                else
                {
                    Master.ShowError(msg);
                }
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
    







    protected void btnAddDoc_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;

    }

}