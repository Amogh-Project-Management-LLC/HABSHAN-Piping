<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Received.aspx.cs" Inherits="HeatNo_HeatNo_Received" Title="Material - MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px" OnClick="btnDWN_Click"> </telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="ReceiveGridView" runat="server" AutoGenerateColumns="False"
            DataSourceID="receiveDataSource" Width="100%" AllowPaging="True" PageSize="12">
            <MasterTableView DataSourceID="receiveDataSource" AutoGenerateColumns="false">
                <Columns>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" HeaderText="Receive No" SortExpression="MAT_RCV_NO" />
                    <telerik:GridBoundColumn DataField="RECV_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Receive Date"
                        HtmlEncode="False" SortExpression="RECV_DATE" />
                    <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thick" SortExpression="WALL_THK" />
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM" />
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat Number" SortExpression="HEAT_NO" />
                    <telerik:GridBoundColumn DataField="RECEIVED" HeaderText="Received" SortExpression="RECEIVED" />
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="receiveDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM VIEW_MAT_RECV_SUMMARY WHERE (PROJECT_ID = :PROJECT_ID) AND (MAT_ID= :MAT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
