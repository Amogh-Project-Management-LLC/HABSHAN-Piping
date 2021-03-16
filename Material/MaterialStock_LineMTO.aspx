<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_LineMTO.aspx.cs" Inherits="Material_MaterialStock_LineMTO" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
             OnClick="btnBack_Click"></telerik:RadButton>
          <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px"
            OnClick="btnDWN_Click">
        </telerik:RadButton>
    </div>
    <div style="margin-top:5px;">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="LineMTODataSource"
         AllowFilteringByColumn="true">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
        <MasterTableView AutoGenerateColumns="False" DataSourceID="LineMTODataSource">
            <Columns>
                <telerik:GridBoundColumn DataField="LINE_NO" AllowFiltering="true" FilterControlAltText="Filter LINE_NO column" HeaderText="LINE_NO" SortExpression="LINE_NO" UniqueName="LINE_NO">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AREA_L1" AllowFiltering="false" FilterControlAltText="Filter AREA_L1 column" HeaderText="AREA_L1" SortExpression="AREA_L1" UniqueName="AREA_L1">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LINE_CLASS" AllowFiltering="false" FilterControlAltText="Filter LINE_CLASS column" HeaderText="LINE_CLASS" SortExpression="LINE_CLASS" UniqueName="LINE_CLASS">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MAIN_MAT" AllowFiltering="false" FilterControlAltText="Filter MAIN_MAT column" HeaderText="MAIN_MAT" SortExpression="MAIN_MAT" UniqueName="MAIN_MAT">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LINE_SIZE" AllowFiltering="false" FilterControlAltText="Filter LINE_SIZE column" HeaderText="LINE_SIZE" SortExpression="LINE_SIZE" UniqueName="LINE_SIZE">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PRIORITY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter PRIORITY column" HeaderText="PRIORITY" SortExpression="PRIORITY" UniqueName="PRIORITY">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PART_NO" AllowFiltering="false" FilterControlAltText="Filter PART_NO column" HeaderText="PART_NO" SortExpression="PART_NO" UniqueName="PART_NO">
                </telerik:GridBoundColumn>              
                <telerik:GridBoundColumn DataField="MTO_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MTO_QTY column" HeaderText="MTO_QTY" SortExpression="MTO_QTY" UniqueName="MTO_QTY">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PO_AVL" AllowFiltering="false" FilterControlAltText="Filter PO_AVL column" HeaderText="PO_AVL" SortExpression="PO_AVL" UniqueName="PO_AVL">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MR_AVL" AllowFiltering="false" FilterControlAltText="Filter MR_AVL column" HeaderText="MR_AVL" SortExpression="MR_AVL" UniqueName="MR_AVL">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ETA_MONTH" AllowFiltering="false" FilterControlAltText="Filter ETA_MONTH column" HeaderText="ETA_MONTH" SortExpression="ETA_MONTH" UniqueName="ETA_MONTH">
                </telerik:GridBoundColumn>
           
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="LineMTODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_LINE_MTO
WHERE PART_NO = :PART_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" DefaultValue="XXX" Name="PART_NO" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>

