<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Cut_List_User.ascx.cs" Inherits="UserControls_Cut_List_User" %>
<table id="spgcutTextRow" runat="server" style="width: 100%">
    <tr id="Tr1" runat="server" style="vertical-align:top;font-family:Calibri;font-weight:bold;width:120px;">
        <td>
            <asp:Label ID="lblCUT" runat="server" Text="CUT LIST"></asp:Label>
        </td>
        <td>
            <telerik:RadAsyncUpload ID="Sg_CUTLIST_file" runat="server" ToolTip="Select text file(s)"
                MultipleFileSelection="Automatic"
                AllowedFileExtensions="txt,TXT" OnFileUploaded="Sg_CUTLIST_file_FileUploaded"
                UploadedFilesRendering="BelowFileInput">
            </telerik:RadAsyncUpload>
        </td>
    </tr>
</table>