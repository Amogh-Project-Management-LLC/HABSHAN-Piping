<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LOM_User.ascx.cs" Inherits="UserControls_LOM_User" %>
<table id="spgMtoTextRow" runat="server" style="width: 100%">
    <tr runat="server" style="vertical-align:top;font-family:Calibri;font-weight:bold;width:120px;">
        <td>
            <asp:Label ID="lblLOM" runat="server" Text="LOM"></asp:Label></td>
        <td>
            <telerik:RadAsyncUpload ID="Sg_LOM_file" runat="server" ToolTip="Select text file(s)"
                MultipleFileSelection="Automatic" AllowedFileExtensions="txt,TXT"
                OnFileUploaded="Sg_LOM_file_FileUploaded" UploadedFilesRendering="BelowFileInput">
            </telerik:RadAsyncUpload>
        </td>
    </tr>
</table>
