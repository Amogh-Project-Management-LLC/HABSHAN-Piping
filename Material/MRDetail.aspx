<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MRDetail.aspx.cs" Inherits="Material_MRDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnAdd" Text="Add" Width="80px" OnClick="btnAdd_Click"></telerik:RadButton>

                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
            AllowPaging="true" PageSize="15" AllowFilteringByColumn="true" AllowAutomaticDeletes="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="MR_ITEM_ID" DataSourceID="itemsDataSource">
                <Columns>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this ?"
                         ConfirmDialogType="RadWindow"></telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM" ReadOnly="True" SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO">
                    <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SEC_KEY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter SEC_KEY column" HeaderText="SEQ" ReadOnly="True" SortExpression="SEC_KEY" UniqueName="SEC_KEY">
                    <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TAG_NO" FilterControlAltText="Filter TAG_NO column" HeaderText="TAG NO" SortExpression="TAG_NO" UniqueName="TAG_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="CLIENT PART NO" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MR_QTY column" HeaderText="QTY" DataFormatString="{0:N2}" 
                        ItemStyle-HorizontalAlign="Right" SortExpression="MR_QTY" UniqueName="MR_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PREV_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter PREV_QTY column" HeaderText="PREV QTY" DataFormatString="{0:N2}" 
                        ItemStyle-HorizontalAlign="Right" SortExpression="PREV_QTY" UniqueName="PREV_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DELTA_QTY" AllowFiltering="false" DataType="System.Decimal" DataFormatString="{0:N2}" 
                        ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter DELTA_QTY column" HeaderText="DELTA QTY" SortExpression="DELTA_QTY" UniqueName="DELTA_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DELIVERY_POINT" FilterControlAltText="Filter DELIVERY_POINT column" HeaderText="DELIVERY POINT" SortExpression="DELIVERY_POINT" UniqueName="DELIVERY_POINT">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CONST_AREA" FilterControlAltText="Filter CONST_AREA column" HeaderText="CONSTRUCTION AREA" SortExpression="CONST_AREA" UniqueName="CONST_AREA">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialDTableAdapters.PIP_MAT_REQUISITION_DETAILTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_MR_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MR_ID" QueryStringField="MR_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MR_ITEM_NO" Type="Decimal" />
            <asp:Parameter Name="TAG_NO" Type="String" />
            <asp:Parameter Name="MAT_CODE1" Type="String" />
            <asp:Parameter Name="MR_QTY" Type="Decimal" />
            <asp:Parameter Name="PREV_QTY" Type="Decimal" />
            <asp:Parameter Name="UOM" Type="String" />
            <asp:Parameter Name="DELIVERY_POINT" Type="String" />
            <asp:Parameter Name="CONST_AREA" Type="String" />
            <asp:Parameter Name="original_MR_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

