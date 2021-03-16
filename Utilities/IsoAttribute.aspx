<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="IsoAttribute.aspx.cs" Inherits="Utilities_IsoAttribute" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading{
            width:125px;
            background-color:whitesmoke;
            padding-left:10px;
        }
    </style>
    <table>
        <tr>
            <td class="Heading">
                Select File :
            </td>
            <td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </td>                    
            <td>
                <telerik:RadButton ID="btnImport" runat="server" Text="Import.." Width="90px" OnClick="btnImport_Click"></telerik:RadButton>
            </td>
            <td>
                <asp:HyperLink ID="hyperlinkImport" runat="server" NavigateUrl="~/Import_Format/ISO_ATTRIBUTE_DATA.xlsx">Sample File</asp:HyperLink>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:LinkButton ID="linkDownloadError" runat="server" OnClick="linkDownloadError_Click" Visible="false">Download Error Details</asp:LinkButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM TBL_ISO_ATTRIB_IMP
WHERE ISO_ID IS NULL OR ERROR_MSG IS NOT NULL"></asp:SqlDataSource>
</asp:Content>

