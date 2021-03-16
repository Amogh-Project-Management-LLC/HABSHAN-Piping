<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CustomReport_List.aspx.cs" Inherits="BasicReports_Report_List" Title="Piping Reports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 3px; background-color: gainsboro;">
         <telerik:RadButton ID="btnCreateReport" runat="server" Text="Create Report" Width="120px" OnClick="btnCreateReport_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnViewReport" runat="server" Text="Show Report" Width="120px" OnClick="btnViewReport_Click"></telerik:RadButton>     
    </div>
    <div>
        <telerik:RadGrid DataSourceID="SqlDataSource1" ID="RadGrid1" runat="server" AllowFilteringByColumn="True" 
            AllowSorting="true" Width="1000px" AllowPaging="True" PageSize="18" PagerStyle-AlwaysVisible="true">
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
            </ClientSettings>
            <GroupingSettings CaseSensitive="false" />
            <MasterTableView DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="REPORT_CODE">
                <Columns>
                    <telerik:GridBoundColumn DataField="REPORT_NAME" FilterControlAltText="Filter REPORT_NAME column" HeaderText="Report Title" SortExpression="REPORT_NAME" UniqueName="REPORT_NAME" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="300px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REPORT_GROUP" FilterControlAltText="Filter REPORT_GROUP column" HeaderText="Report Group" ReadOnly="True" SortExpression="REPORT_GROUP" UniqueName="REPORT_GROUP" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REPORT_CODE" FilterControlAltText="Filter REPORT_CODE column" HeaderText="Report Code" ReadOnly="True" SortExpression="REPORT_CODE" UniqueName="REPORT_CODE" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn DataField="CREATED_BY" FilterControlAltText="Filter CREATED_BY column" HeaderText="Created By" ReadOnly="True" SortExpression="CREATED_BY" UniqueName="CREATED_BY" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="CREATED_DATE" FilterControlAltText="Filter CREATED_DATE column" HeaderText="Created Date" ReadOnly="True" SortExpression="CREATED_DATE" UniqueName="CREATED_DATE" CurrentFilterFunction="Contains"  AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False"></FilterMenu>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM CUSTOM_REPORT_INDEX REP"></asp:SqlDataSource>
    <asp:HiddenField ID="Search_HiddenField" runat="server" />
</asp:Content>