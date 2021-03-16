using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utilities_UnregisteredIDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Remove Unregistered/Deleted IDF MTO");

            string count = WebTools.CountExpr("1", "VIEW_UNREGIS_IDF", " WHERE 1=1");

            lblStatus.Text = "Total IDFs : " + count;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string sql = "DELETE FROM TBL_IDF_MTO WHERE ISO_TITLE IN (SELECT ISO_TITLE FROM VIEW_UNREGIS_IDF)";
        WebTools.ExeSql(sql);
        RadGrid1.Rebind();
    }
}