<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="UnregisteredIDF.aspx.cs" Inherits="Utilities_UnregisteredIDF" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete All" Width="80px" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td style="text-align: right; padding-right: 10px">
                    <asp:Label ID="lblStatus" runat="server" Font-Bold="true" Font-Size="11pt"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="sqlIDFSource" GridLines="None"
             Height="300px" ClientSettings-Scrolling-AllowScroll="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlIDFSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="ISO_TITLE" FilterControlAltText="Filter ISO_TITLE column" HeaderText="ISO_TITLE" SortExpression="ISO_TITLE" UniqueName="ISO_TITLE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <div style="margin-top: 3px">
    </div>
    <asp:SqlDataSource ID="sqlIDFSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_UNREGIS_IDF
ORDER BY ISO_TITLE"></asp:SqlDataSource>
</asp:Content>

