<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Spl_Info_User.ascx.cs" Inherits="UserControls_Spl_Info_User" %>

<table id="spgsplinfoTextRow" runat="server" style="width: 100%">
    <tr id="Tr1" runat="server" style="vertical-align:top;font-family:Calibri;font-weight:bold;width:120px;">
        <td>
            <asp:Label ID="lblSplInfo" runat="server" Text="SPOOL INFO"></asp:Label>
        </td>
        <td>
            <telerik:RadAsyncUpload ID="Sg_Spl_Info_file" runat="server"
                ToolTip="Select text file(s)" MultipleFileSelection="Automatic"
                AllowedFileExtensions="txt,TXT" OnFileUploaded="Sg_Spl_Info_file_FileUploaded"
                UploadedFilesRendering="BelowFileInput">
            </telerik:RadAsyncUpload>
        </td>
    </tr>
</table>