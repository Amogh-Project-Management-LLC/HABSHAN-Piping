<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialLengthUpd.aspx.cs" Inherits="Utilities_MaterialLengthUpd" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnImport" runat="server" Text="Import..." Width="80" OnClick="btnImport_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1">
            <Tabs>
                <telerik:RadTab Text="Catalog File"></telerik:RadTab>
                <telerik:RadTab Text="CIF File"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
            <telerik:RadPageView ID="RadPageView1" runat="server">
                <table style="margin-top:3px;">
                    <tr>
                        <td>Select Catalog Files:</td>
                        <td>
                           <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" AllowedFileExtensions=".cat"></telerik:RadAsyncUpload>
                        </td>
                    </tr>
                </table>               
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <table style="margin-top:3px;">
                    <tr>
                        <td>Select Catalog Files:</td>
                        <td>
                           <telerik:RadAsyncUpload ID="RadAsyncUpload2" runat="server" AllowedFileExtensions=".cif"></telerik:RadAsyncUpload>
                        </td>
                    </tr>
                </table>                 
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server"></asp:ObjectDataSource>
</asp:Content>

