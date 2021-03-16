<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatExceptionImportMIR.aspx.cs" Inherits="Material_MatExceptionImportMIR" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width:100%">
            <tr>                
                <td >
                    <asp:CheckBox ID="CheckBox2" runat="server" Text="Check All" OnCheckedChanged="CheckBox2_CheckedChanged"
                         AutoPostBack="true" Checked="true"/>
                </td>
                 <td style="text-align:right; padding-right:10px">
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px"></telerik:RadButton>
                </td>
            </tr>
        </table>

    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" DataSourceID="sqlItemSource">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlItemSource">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="CheckColumn">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MIR_ITEM" FilterControlAltText="Filter MIR_ITEM column" HeaderText="MIR_ITEM" SortExpression="MIR_ITEM" UniqueName="MIR_ITEM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO_ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXC_QTY" DataType="System.Decimal" FilterControlAltText="Filter EXC_QTY column" HeaderText="EXC_QTY" SortExpression="EXC_QTY" UniqueName="EXC_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SH_QTY" DataType="System.Decimal" FilterControlAltText="Filter SH_QTY column" HeaderText="SH_QTY" SortExpression="SH_QTY" UniqueName="SH_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DAMAG_QTY" DataType="System.Decimal" FilterControlAltText="Filter DAMAG_QTY column" HeaderText="DAMAG_QTY" SortExpression="DAMAG_QTY" UniqueName="DAMAG_QTY">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PRC_MAT_INSP_DETAIL.MIR_ITEM, PRC_MAT_INSP_DETAIL.PO_ITEM, PRC_MAT_INSP_DETAIL.MAT_ID, 
       PIP_MAT_STOCK.MAT_CODE1, PRC_MAT_INSP_DETAIL.HEAT_NO, PRC_MAT_INSP_DETAIL.EXC_QTY, PRC_MAT_INSP_DETAIL.SH_QTY, 
       PRC_MAT_INSP_DETAIL.DAMAG_QTY 
FROM PRC_MAT_INSP_DETAIL, PIP_MAT_STOCK 
WHERE PRC_MAT_INSP_DETAIL.MAT_ID = PIP_MAT_STOCK.MAT_ID AND PRC_MAT_INSP_DETAIL.MAT_ID = :MIR_ID
AND (PRC_MAT_INSP_DETAIL.EXC_QTY &gt; 0 OR PRC_MAT_INSP_DETAIL.SH_QTY &gt; 0 OR PRC_MAT_INSP_DETAIL.DAMAG_QTY &gt; 0) 
ORDER BY PRC_MAT_INSP_DETAIL.MIR_ITEM, PRC_MAT_INSP_DETAIL.PO_ITEM">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenMIR" DefaultValue="-1" Name="MIR_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenMIR" runat="server" />
</asp:Content>

