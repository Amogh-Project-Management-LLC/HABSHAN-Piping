using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_Spl_Info_User : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string target_path = HttpContext.Current.Server.MapPath(".") + "\\SG_IMPORT\\"; //WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='SG_DATA_TEXT'");
            Sg_Spl_Info_file.TargetFolder = target_path + "SPOOLINFO\\";
        }
        catch (Exception)
        {

        }
    }

    protected void Sg_Spl_Info_file_FileUploaded(object sender, Telerik.Web.UI.FileUploadedEventArgs e)
    {

    }
}