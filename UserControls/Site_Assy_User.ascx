<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Site_Assy_User.ascx.cs" Inherits="UserControls_Site_Assy_User" %>

<table  id="spgSiteassy"  runat="server"  style="width:100%" >
    <tr id="Tr1"  runat="server" style="vertical-align:top;font-family:Calibri;font-weight:bold;width:120px;">
        <td>
            <asp:Label  runat="server" ID="lblSiteAssy"  Text="SITE ASSY" ></asp:Label>
        </td>
        <td>
            <telerik:RadAsyncUpload  ID="Sg_Site_Assy_file"  runat="server"  ToolTip="Select text file(s)"  
                MultipleFileSelection="Automatic"  AllowedFileExtensions="txt,TXT" OnFileUploaded="Sg_Site_Assy_file_FileUploaded"   
                UploadedFilesRendering="BelowFileInput"   ></telerik:RadAsyncUpload>
        </td>
    </tr>
</table>