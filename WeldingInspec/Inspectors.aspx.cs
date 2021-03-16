using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WeldingInspec_Inspectors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.AddModalPopup("~/WeldingInspec/InspectorRegister.aspx", btnRegister.ClientID, 450, 550);
            Master.RadGridList = RadGrid1.ClientID;
        }

    }
}