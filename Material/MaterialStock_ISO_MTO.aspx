<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_ISO_MTO.aspx.cs" Inherits="Material_MaterialStock_ISO_MTO" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px" OnClick="btnDWN_Click"> </telerik:RadButton>
    </div>
    <div style="margin-top:5px">
        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="IsoMTODataSource" GridLines="None"
              AllowPaging="true" PageSize="15">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="IsoMTODataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PT_NO" FilterControlAltText="Filter PT_NO column" HeaderText="PT NO" SortExpression="PT_NO" UniqueName="PT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE DESCR" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NET_QTY" DataType="System.Decimal" FilterControlAltText="Filter NET_QTY column" HeaderText="NET QTY" SortExpression="NET_QTY" UniqueName="NET_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_AVAILABLE" FilterControlAltText="Filter PO_AVAILABLE column" HeaderText="PO AVAILABLE" SortExpression="PO_AVAILABLE" UniqueName="PO_AVAILABLE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRIR_AVAILABLE" FilterControlAltText="Filter MRIR_AVAILABLE column" HeaderText="MRIR AVAILABLE" SortExpression="MRIR_AVAILABLE" UniqueName="MRIR_AVAILABLE">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:SqlDataSource ID="IsoMTODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_IDF_MTO
WHERE mat_code1 = :part_no">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" DefaultValue="XXX" Name="part_no" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

