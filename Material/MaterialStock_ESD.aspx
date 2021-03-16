<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_ESD.aspx.cs" Inherits="Material_MaterialStock_ESD" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
            OnClick="btnBack_Click">
        </telerik:RadButton>

        <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px" OnClick="btnDWN_Click"> </telerik:RadButton>
    </div>
    <div style="margin-top: 5px;">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="MatRequisitonDS"
            AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="MatRequisitonDS">
                <Columns>
                    <telerik:GridBoundColumn DataField="REP_NO" AllowFiltering="true" FilterControlAltText="Filter REP_NO column" HeaderText="Exception Report" SortExpression="REP_NO" UniqueName="REP_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REP_DATE" AllowFiltering="false" FilterControlAltText="Filter REP_DATE column" HeaderText="Report Date" SortExpression="REP_DATE" UniqueName="REP_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" AllowFiltering="false" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="Mat Rcv No" SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXCP_FLG" AllowFiltering="false" FilterControlAltText="Filter EXCP_FLG column" HeaderText="Excp Flag" SortExpression="EXCP_FLG" UniqueName="EXCP_FLG">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXCP_QTY" AllowFiltering="false" FilterControlAltText="Filter EXCP_QTY column" HeaderText="Excp QTY" SortExpression="EXCP_QTY" UniqueName="EXCP_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" AllowFiltering="false" FilterControlAltText="Filter HEAT_NO column" HeaderText="Heat No" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" AllowFiltering="false" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO_ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" AllowFiltering="false"  FilterControlAltText="Filter CREATE_DATE column" HeaderText="Create Date" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CLEAR_DATE" AllowFiltering="false" FilterControlAltText="Filter CLEAR_DATE column" HeaderText="CLEAR_DATE" SortExpression="CLEAR_DATE" UniqueName="CLEAR_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXCP_ITEM_REMARKS" AllowFiltering="false" FilterControlAltText="Filter EXCP_ITEM_REMARKS column" HeaderText="Remarks" SortExpression="EXCP_ITEM_REMARKS" UniqueName="EXCP_ITEM_REMARKS">
                    </telerik:GridBoundColumn>
                   
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="MatRequisitonDS" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT *FROM VIEW_ADAPTER_MAT_EXCP  WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

