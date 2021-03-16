<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_MRIR.aspx.cs" Inherits="Material_MaterialStock_MRIR" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnExport" Text="Export" Width="80px" OnClick="btnExport_Click"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="sqlDataSource" GridLines="None">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUB_CON_NAME" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MIR_NO" FilterControlAltText="Filter MIR_NO column" HeaderText="MIR_NO" SortExpression="MIR_NO" UniqueName="MIR_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_DATE" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter INSP_DATE column" HeaderText="INSP_DATE" SortExpression="INSP_DATE" UniqueName="INSP_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO_NO" SortExpression="PO_NO" UniqueName="PO_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRV_NUMBER" FilterControlAltText="Filter MRV_NUMBER column" HeaderText="MRV_NUMBER" SortExpression="MRV_NUMBER" UniqueName="MRV_NUMBER">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE_NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV_QTY" SortExpression="RCV_QTY" UniqueName="RCV_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACPT_QTY" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACPT_QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TC_CODE" FilterControlAltText="Filter TC_CODE column" HeaderText="TC_CODE" SortExpression="TC_CODE" UniqueName="TC_CODE">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOB_CODE, MIR_NO, SRN_NO, INSP_DATE, SUB_CON_NAME, PO_NO, SHIP_NO, MRV_NUMBER, STORE_NAME, MAT_CODE1,
MAT_CODE2, SIZE_DESC, RANGE_A, RANGE_B, SIZE1, SIZE2, WALL_THK, ITEM_NAM, SG_GROUP, MAT_DESCR, UOM,
RCV_QTY, ACPT_QTY, AS_PER_PL_QTY, HEAT_NO, PAINT_SYS, PO_ITEM, MIR_ITEM, TC_CODE, PDF_FLG, STORE_L1, REMARKS, MRIR_REMARKS, TOTAL_WT, SUPPLIER_VENDORNAME FROM VIEW_MAT_MRIR_SUMMARY
WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

