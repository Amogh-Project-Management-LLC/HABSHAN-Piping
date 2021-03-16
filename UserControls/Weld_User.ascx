<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Weld_User.ascx.cs" Inherits="UserControls_Weld_User" %>
<table id="spgweldTextRow" runat="server" style="width: 100%">
    <tr id="Tr1" runat="server" style="vertical-align:top;font-family:Calibri;font-weight:bold;width:120px;">
        <td>
            <asp:Label ID="lblWeld" runat="server" Text="WELDING"></asp:Label>
        </td>
        <td>
            <telerik:RadAsyncUpload ID="Sg_WELD_file" runat="server" ToolTip="Select  text file(s)"
                MultipleFileSelection="Automatic" AllowedFileExtensions="txt,TXT" OnFileUploaded="Sg_WELD_file_FileUploaded"
                UploadedFilesRendering="BelowFileInput">
            </telerik:RadAsyncUpload>
        </td>
    </tr>
</table>