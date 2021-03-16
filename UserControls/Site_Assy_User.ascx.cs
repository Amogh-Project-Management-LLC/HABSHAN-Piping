using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_Site_Assy_User : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string target_path = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\"; //WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT'");
        Sg_Site_Assy_file.TargetFolder = target_path + "SITEASSY\\";
    }

    protected void Sg_Site_Assy_file_FileUploaded(object sender, Telerik.Web.UI.FileUploadedEventArgs e)
    {

    }
}