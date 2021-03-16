using System;
using System.Web.UI;
using Telerik.Web.UI;

public partial class Home_UploadFileManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "File Explorer";
            string root_path = WebTools.GetExpr("PATH", "DIR_OBJECTS", "DIR_OBJ='ROOT'");
            string[] viewPaths = new string[] { root_path};           
            RadFileExplorer1.Configuration.ViewPaths = viewPaths;
            RadFileExplorer1.Configuration.SearchPatterns = new[] { "*.*" };
            RadFileExplorer1.Configuration.ContentProviderTypeName = typeof(CustomFileSystemProvider).AssemblyQualifiedName;
        }
    }

    protected Telerik.Web.UI.FileExplorer.FileExplorerControls GetVisibleControls()
    {
        Telerik.Web.UI.FileExplorer.FileExplorerControls explorerControls = 0;

        //explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.AddressBox;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.Grid;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.ListView;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.Toolbar;

        explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.TreeView;

        //explorerControls |= Telerik.Web.UI.FileExplorer.FileExplorerControls.ContextMenus;

        return explorerControls;
    }
    protected void RadFileExplorer1_ItemCommand(object sender, Telerik.Web.UI.RadFileExplorerEventArgs e)
    {
        if (e.Command == "Delete")
        {
            //e.Cancel = true;
        }
    }
}