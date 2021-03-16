<%@ Page Title="Spool Receive Items" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolReceiveImport.aspx.cs" Inherits="SpoolMove_SpoolReceiveImport" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 220 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
        <telerik:RadDropDownList ID="ddlSubStore" runat="server" DataSourceID="dsSubStore" SelectedText="Select SubStore" SelectedValue="-1" DataTextField="STORE_L1" DataValueField="SUBSTORE_ID" AppendDataBoundItems="true">
            <Items>
                <telerik:DropDownListItem Selected="true" Value="-1" Text="Select SubStore" />
            </Items>
        </telerik:RadDropDownList>
        <asp:SqlDataSource ID="dsSubStore" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM STORES_SUB WHERE STORE_ID = :STORE_ID">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenStoreID" DefaultValue="-1" Name="STORE_ID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlItemsSource" GridLines="None" AllowMultiRowSelection="true"
            Height="600px" AllowPaging="true" PageSize="30" PagerStyle-AlwaysVisible="true"  AllowFilteringByColumn="true" >
            <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlItemsSource" DataKeyNames="SPL_ID">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="AREA_L2" FilterControlAltText="Filter AREA_L2 column" HeaderText="AREA_L2" SortExpression="AREA_L2" UniqueName="AREA_L2">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO_TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_REV" FilterControlAltText="Filter SPL_REV column" HeaderText="SPL_REV" SortExpression="SPL_REV" UniqueName="SPL_REV">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SCR" FilterControlAltText="Filter SPL_SCR column" HeaderText="SPL_SCR" SortExpression="SPL_SCR" UniqueName="SPL_SCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_FCR" FilterControlAltText="Filter SPL_FCR column" HeaderText="SPL_FCR" SortExpression="SPL_FCR" UniqueName="SPL_FCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHOP_ID" DataType="System.Decimal" FilterControlAltText="Filter SHOP_ID column" HeaderText="SHOP_ID" SortExpression="SHOP_ID" UniqueName="SHOP_ID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SIZE" FilterControlAltText="Filter SPL_SIZE column" HeaderText="SPL_SIZE" SortExpression="SPL_SIZE" UniqueName="SPL_SIZE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAIN_MAT" FilterControlAltText="Filter MAIN_MAT column" HeaderText="MAIN_MAT" SortExpression="MAIN_MAT" UniqueName="MAIN_MAT">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:HiddenField ID="HiddenTransID" runat="server" />
    <asp:HiddenField ID="HiddenStoreID" runat="server" />
    <asp:SqlDataSource ID="sqlItemsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_SPL_TRANSFER_DETAIL
WHERE TRANS_ID = (SELECT TRANS_ID FROM PIP_SPL_RECEIVE WHERE RCV_ID = :RCV_ID)
AND SPL_ID NOT IN (SELECT SPL_ID FROM PIP_SPL_RECEIVE_DETAIL WHERE RCV_ID = :RCV_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

