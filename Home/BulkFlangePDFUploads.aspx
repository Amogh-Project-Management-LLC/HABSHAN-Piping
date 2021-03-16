<%@ Page Title="Bulk Flange PDF Upload" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BulkFlangePDFUploads.aspx.cs" Inherits="BulkFlangePDFUploads" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .fontClass {
            font-weight: 500;
            font-size: medium;
            color: black
        }
    </style>
    <script type="text/javascript">
            function DeleteFiles()
            {
             var upload = $find("<%= RadAsyncUpload1.ClientID %>");
             var inputs = upload.getUploadedFiles().length;
              for (i = 0; i <= inputs; i++)
             {
              upload.deleteFileInputAt(i);
             }
            }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <div>
        <div style="background-color: #E2E2E2; color: darkgrey; height: 30px; padding-top: 5px; padding-left: 5px">
            <asp:Label ID="Label1" runat="server" Text="Select Category to Upload" CssClass="fontClass"></asp:Label>
        </div>
        <div style="margin-top: 3px;">
            <table style="width: 100%" cellspacing="0">
                <tr style="background-color: #E2E2E2; height: 25px; color: black; text-align: center; font-weight: 500">
                    <td>Flange PDF</td>
                </tr>
                <tr>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckFlange" runat="server" RepeatDirection="Vertical" Width="100%" Height="170px"
                            Enabled="true" AutoPostBack="true">
                            <asp:ListItem Value="PIDHC">PID Hcopy</asp:ListItem>
                            <asp:ListItem Value="PIDMARKUP">PID Markup</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>                    
                </tr>
            </table>
        </div>
        <div style="background-color: #E2E2E2; padding-left: 5px">
            <table>
                <tr>
                    <td>Select File:
                    </td>
                    <td>
                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Automatic" UploadedFilesRendering="BelowFileInput"></telerik:RadAsyncUpload>
                    </td>
                    <td style="vertical-align:top;padding-left:200px">
                        <telerik:RadButton ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"></telerik:RadButton>
                    </td>
                    <td style="vertical-align:top;padding-left:10px">
                        <telerik:RadButton ID="btnClear"  runat="server" Text="Clear" OnClientClick="DeleteFiles(); return false;"></telerik:RadButton>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 200px" colspan="4">
                        <telerik:RadLabel ID="lblMessage" Text="" runat="server" ForeColor="Red"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <%--   </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

