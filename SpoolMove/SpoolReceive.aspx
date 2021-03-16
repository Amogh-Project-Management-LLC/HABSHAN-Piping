<%@ Page Title="Spool Receive" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolReceive.aspx.cs" Inherits="SpoolMove_SpoolReceive" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= GridItems.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth
            var masterTable = $find("<%=GridItems.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke;">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnNew" Text="Register" Width="80px"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnSpools" Text="Spools" Width="80px" OnClick="btnSpools_Click"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnPreview" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" OnClick="btnBulkImport_Click"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="200px" EmptyMessage="Search...." AutoPostBack="true">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="GridItems" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
            AllowPaging="True" PageSize="50" OnItemDataBound="GridItems_ItemDataBound" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
                DataKeyNames="RCV_ID" EditMode="InPlace">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridTemplateColumn AllowFiltering="false">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="50px" />
                        <HeaderStyle Width="50px" />

                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="RCV_NO" FilterControlAltText="Filter RCV_NO column" HeaderText="RECEIVE NO" SortExpression="RCV_NO" UniqueName="RCV_NO" AutoPostBackOnFilter="true" AllowFiltering="true">
                        <HeaderStyle Width="220px" />
                        <ItemStyle Width="220px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP/TRAILER NO" SortExpression="SHIP_NO" UniqueName="SHIP_NO" AutoPostBackOnFilter="true" AllowFiltering="true">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RCV_DATE" DataType="System.DateTime" FilterControlAltText="Filter RCV_DATE column" HeaderText="RECEIVE DATE" SortExpression="RCV_DATE" UniqueName="RCV_DATE" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlWidth="50px">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtEditRCVDate" runat="server" SelectedDate='<%# Bind("RCV_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RCV_DATELabel" runat="server" Text='<%# Eval("RCV_DATE","{0:dd-MMM-yy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="RCV_BY" ReadOnly="true" FilterControlAltText="Filter RCV_BY column" HeaderText="RECEIVE BY" SortExpression="RCV_BY" UniqueName="RCV_BY" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlWidth="50px">
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" ReadOnly="true" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="RECEIVE SUBCON" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME" AutoPostBackOnFilter="true" AllowFiltering="true">
                        <HeaderStyle Width="180px" />
                        <ItemStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" ReadOnly="true" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE" SortExpression="STORE_NAME" UniqueName="STORE_NAME" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlWidth="40px">
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANS_NO" ReadOnly="true" FilterControlAltText="Filter TRANS_NO column" HeaderText="TRANSFER NO" SortExpression="TRANS_NO" UniqueName="TRANS_NO" AutoPostBackOnFilter="true" AllowFiltering="true">
                        <HeaderStyle Width="220px" />
                        <ItemStyle Width="220px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANSFER_REASON" ReadOnly="true" FilterControlAltText="Filter TRANSFER_REASON column" HeaderText="REASON" SortExpression="TRANSFER_REASON" UniqueName="TRANSFER_REASON" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlWidth="50px">
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CONTAINER_NO" ReadOnly="true" FilterControlAltText="Filter CONTAINER_NO column"
                        HeaderText="Container No" SortExpression="CONTAINER_NO" UniqueName="CONTAINER_NO" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlWidth="50px">
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AutoPostBackOnFilter="true" AllowFiltering="true" FilterControlWidth="50px">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSpoolReportsDTableAdapters.VIEW_SPOOL_RECEIVETableAdapter" DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="RCV_NO" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RCV_NO" Type="String" />
            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="RCV_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>
