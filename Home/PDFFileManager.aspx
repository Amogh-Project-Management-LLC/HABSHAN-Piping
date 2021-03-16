<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PDFFileManager.aspx.cs" Inherits="Home_UploadFileManager" Title="Upload Files" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <script type="text/javascript">
       function OnClientFileOpen(oExplorer, args) {
           if (!args.get_item().isDirectory()) {
               args.set_cancel(true);

               var requestFile = "FileSystemHandler.ashx?path=" + args.get_path();
               document.location = requestFile;
           }
        }
  </script>
    <div class="demo-container size-medium">
        <telerik:RadFileExplorer RenderMode="Lightweight" runat="server" ID="RadFileExplorer1" Width="100%" OnClientFileOpen="OnClientFileOpen"
            EnableCopy="true" FilterTextBoxLabel="Find File" EnableFilteringOnEnterPressed="true" EnableFilterTextBox="true" PageSize="10" AllowPaging="true">
            <Configuration AllowMultipleSelection="true" />
        </telerik:RadFileExplorer>
    </div>  
</asp:Content>