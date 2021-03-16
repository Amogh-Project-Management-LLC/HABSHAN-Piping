<%@ Page Title="PO Vendor Data" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POVendorData.aspx.cs" Inherits="Procurement_POVendorData" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnImportIRN" runat="server" Text="Import.." Width="120px">
            <Icon PrimaryIconUrl="../Images/icons/excel.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="80px" OnClick="btnExport_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" PageSize="15" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
           
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="IRN_NO,PO_NO,PO_ITEM,PIPE_NO" DataSourceID="itemsDataSource" >
                <Columns>
                    <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN_NO" ReadOnly="True" SortExpression="IRN_NO" UniqueName="IRN_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CLIENT_IRN" FilterControlAltText="Filter CLIENT_IRN column" HeaderText="CLIENT_IRN" SortExpression="CLIENT_IRN" UniqueName="CLIENT_IRN" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO_NO" ReadOnly="True" SortExpression="PO_NO" UniqueName="PO_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO_ITEM" ReadOnly="True" SortExpression="PO_ITEM" UniqueName="PO_ITEM" >
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LOT_NO" FilterControlAltText="Filter LOT_NO column" HeaderText="LOT_NO" SortExpression="LOT_NO" UniqueName="LOT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MTC_CODE" FilterControlAltText="Filter MTC_CODE column" HeaderText="MTC_CODE" SortExpression="MTC_CODE" UniqueName="MTC_CODE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIPE_NO" FilterControlAltText="Filter PIPE_NO column" HeaderText="PIPE_NO" ReadOnly="True" SortExpression="PIPE_NO" UniqueName="PIPE_NO" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIPE_LENGTH" DataType="System.Decimal" FilterControlAltText="Filter PIPE_LENGTH column" HeaderText="PIPE_LENGTH" SortExpression="PIPE_LENGTH" UniqueName="PIPE_LENGTH" AllowFiltering="false">
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPO_ReportsATableAdapters.PO_VENDOR_DATATableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_IRN_NO" Type="String" />
            <asp:Parameter Name="Original_PO_NO" Type="String" />
            <asp:Parameter Name="Original_PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_PIPE_NO" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="IRN_NO" Type="String" />
            <asp:Parameter Name="CLIENT_IRN" Type="String" />
            <asp:Parameter Name="PO_NO" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="LOT_NO" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="MTC_CODE" Type="String" />
            <asp:Parameter Name="PIPE_NO" Type="String" />
            <asp:Parameter Name="PIPE_LENGTH" Type="Decimal" />
            <asp:Parameter Name="UOM" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="CLIENT_IRN" Type="String" />
            <asp:Parameter Name="LOT_NO" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="MTC_CODE" Type="String" />
            <asp:Parameter Name="PIPE_LENGTH" Type="Decimal" />
            <asp:Parameter Name="UOM" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
            <asp:Parameter Name="Original_IRN_NO" Type="String" />
            <asp:Parameter Name="Original_PO_NO" Type="String" />
            <asp:Parameter Name="Original_PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_PIPE_NO" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDataDownload" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_PO_VENDOR_DATA"></asp:SqlDataSource>
</asp:Content>

