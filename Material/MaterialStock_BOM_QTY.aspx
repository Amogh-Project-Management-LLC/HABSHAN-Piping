<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_BOM_QTY.aspx.cs" Inherits="MaterialStock_BOM_QTY" Title="Material - BOM" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
            OnClick="btnBack_Click">
        </telerik:RadButton>
        <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px"
            OnClick="btnDWN_Click">
        </telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" PageSize="10" Width="100%">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                    <telerik:GridBoundColumn DataField="JC_NO" HeaderText="JC Number" SortExpression="JC_NO" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool Piece" SortExpression="SPOOL" />
                    <telerik:GridBoundColumn DataField="MAT_AVL" HeaderText="Spl Avl." SortExpression="MAT_AVL" />
                    <telerik:GridBoundColumn DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                    <telerik:GridBoundColumn DataField="SF_FLG" HeaderText="SF" SortExpression="SF_FLG" />
                    <telerik:GridBoundColumn DataField="AVAILABLE" HeaderText="Avl. (Inv)" SortExpression="AVAILABLE" />
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                    <telerik:GridBoundColumn DataField="NET_QTY" HeaderText="Net Qty" SortExpression="NET_QTY" />
                    <telerik:GridBoundColumn DataField="ETA_DATE" HeaderText="ETA Date" SortExpression="ETA_DATE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JC_NO, SUB_CON, ISO_TITLE1, SPOOL, MAT_AVL, MAT_TYPE, MAT_CLASS, SML_DATE, PT_NO, ITEM_NAM, MAT_CODE1, SIZE_DESC, WALL_THK, MAT_DESCR, SF_FLG, HEAT_NO, AVAILABLE, PAINT_AVL, NET_QTY, PIPE_EP1, PIPE_EP2, PO_NO, ETA_DATE, UOM FROM VIEW_BOM_TOTAL WHERE (MAT_ID = :MAT_ID) ORDER BY ISO_TITLE1, SPOOL, MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
