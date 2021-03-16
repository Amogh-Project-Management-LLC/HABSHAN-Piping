<%@ Page Title="Material Status Report" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStatusReport.aspx.cs" Inherits="Material_MaterialStatusReport" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 180 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <style type="text/css">
        .MenuItemCenter {
            text-align: center !important;
            min-width: 70px;
        }
    </style>
    <div style="background-color: whitesmoke">
        <telerik:RadMenu ID="RadMenu1" runat="server" OnItemClick="RadMenu1_ItemClick">
            <Items>
                <telerik:RadMenuItem Text="Line MTO" Value="LINE_MTO" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="ISO MTO" Value="ISO_MTO" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Mat Requisition" Value="MR" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="PO" Value="PO" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Material Receive">
                    <Items>
                        <telerik:RadMenuItem Text="Material Receive (MRV)" Value="MRV"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Material Receive & Inspection (MRIR)" Value="MRIR"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="ESD Reports" Value="ESD"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Material Issue">
                    <Items>
                        <telerik:RadMenuItem Text="Job Cards" Value="JC"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Job Card MIV" Value="JC_MIV"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Site MIV" Value="SITE_MIV"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Add Issue" Value="ADD_ISSUE"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Transfer" Value="TRANSF" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Heat Nos" Value="HEAT_NO" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="MTC" Value="MTC" CssClass="MenuItemCenter"></telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Piping" Value="LINE_MTO">
                    <Items>
                        <telerik:RadMenuItem Text="Bill of Material" Value="BOM"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Joint List" Value="JOINT_LIST"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
                <telerik:RadMenuItem Text="Downloads">
                    <Items>
                        <telerik:RadMenuItem Text="Download All" Value="DOWNLOAD"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Text="Download Shortage" Value="SHORTAGE"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
        <%-- <telerik:RadButton ID="btnMTO" runat="server" Text="Line MTO" Width="80px" OnClick="btnMTO_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnBOM" runat="server" Text="ISO MTO" Width="80px" OnClick="btnBOM_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPO" runat="server" Text="PO" Width="80px" OnClick="btnPO_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnReceived" runat="server" Text="MRV" Width="80px" OnClick="btnReceived_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnMRIR" runat="server" Text="MRIR" Width="80px" OnClick="btnMRIR_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnJCIssued" runat="server" Text="Job Card" Width="80px" OnClick="btnJCIssued_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSiteMIV" runat="server" Text="SITE MIV" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="RadButton1" runat="server" Text="Transfer" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="RadButton2" runat="server" Text="Add Issue" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="RadButton3" runat="server" Text="Heat Nos" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="RadButton4" runat="server" Text="MTC" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="RadButton5" runat="server" Text="Piping" Width="80px">            
        </telerik:RadButton>--%>
    </div>
    <div style="margin-top: 5px;">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
            AllowPaging="True" PageSize="20" AllowFilteringByColumn="True">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="MAT_ID">
                <Columns>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAME" AllowFiltering="false" FilterControlAltText="Filter ITEM_NAME column" HeaderText="ITEM NAME" SortExpression="ITEM_NAME" UniqueName="ITEM_NAME">
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" AllowFiltering="false" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MTO_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MTO_QTY column" HeaderText="LINE MTO" SortExpression="MTO_QTY" UniqueName="MTO_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOM_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter BOM_QTY column" HeaderText="ISO MTO" SortExpression="BOM_QTY" UniqueName="BOM_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FAB_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter FAB_QTY column" HeaderText="FAB QTY" SortExpression="FAB_QTY" UniqueName="FAB_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EREC_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter EREC_QTY column" HeaderText="EREC QTY" SortExpression="EREC_QTY" UniqueName="EREC_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MR_QTY column" HeaderText="MR QTY" SortExpression="MR_QTY" UniqueName="MR_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO QTY" SortExpression="PO_QTY" UniqueName="PO_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_SHORT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter PO_SHORT_QTY column" HeaderText="PO SHORT QTY" SortExpression="PO_SHORT_QTY" UniqueName="PO_SHORT_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter SRN_QTY column" HeaderText="SRN QTY" SortExpression="SRN_QTY" UniqueName="SRN_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCVD_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter RCVD_QTY column" HeaderText="RCVD QTY" SortExpression="RCVD_QTY" UniqueName="RCVD_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JC_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter JC_QTY column" HeaderText="JC QTY" SortExpression="JC_QTY" UniqueName="JC_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EREC_ISSUED" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter EREC_ISSUED column" HeaderText="ADDL ISSUED" SortExpression="EREC_ISSUED" UniqueName="EREC_ISSUED">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ADD_ISSUE" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter ADD_ISSUE column" HeaderText="EREC ISSUED" SortExpression="ADD_ISSUE" UniqueName="ADD_ISSUE">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SD_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter SD_QTY column" HeaderText="SHORT/DAMAGE QTY" SortExpression="SD_QTY" UniqueName="SD_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BAL_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="BALANCE" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                        <ItemStyle HorizontalAlign="Right" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA1" AllowFiltering="false" FilterControlAltText="Filter ETA1 column" HeaderText="ETA1" SortExpression="ETA1" UniqueName="ETA1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA2" AllowFiltering="false" FilterControlAltText="Filter ETA2 column" HeaderText="ETA2" SortExpression="ETA2" UniqueName="ETA2" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA3" AllowFiltering="false" FilterControlAltText="Filter ETA3 column" HeaderText="ETA3" SortExpression="ETA3" UniqueName="ETA3" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <%-- <div style="margin-top: 5px; background-color: whitesmoke">
        <telerik:RadButton ID="btnDownload" runat="server" Text="Download" Width="100px" OnClick="btnDownload_Click"></telerik:RadButton>
        <telerik:RadButton ID="btndownShort" runat="server" Text="Download Shortage" Width="150px" OnClick="btndownShort_Click"></telerik:RadButton>    
    </div>--%>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralBTableAdapters.VIEW_MAT_STATUS_REPTableAdapter"></asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDownloadSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_MAT_STATUS_REP"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDownShort" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_MAT_STATUS_REP
WHERE po_short_qty &gt; 0"></asp:SqlDataSource>
</asp:Content>

