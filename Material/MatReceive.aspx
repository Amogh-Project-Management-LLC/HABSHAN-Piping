<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceive.aspx.cs" Inherits="Material_MatReceive" Title="MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .RadMenuStyle {
            z-index: 10;
            /*position:absolute;*/
        }
    </style>
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= MatReceiveGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=MatReceiveGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 180 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="New" Width="80" OnClick="btnNewTrans_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="Materials" Width="80" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Import.." Width="100" OnClick="btnImport_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                </td>

                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"
                        EmptyMessage="Search.." Width="200px">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="MatReceiveGridView" runat="server" DataSourceID="MatReceiveDataSource" MasterTableView-EditMode="PopUp">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" EnablePostBackOnRowClick="false" Scrolling-EnableColumnClientFreeze="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="MatReceiveDataSource" DataKeyNames="MAT_RCV_ID" AllowAutomaticUpdates="true" PageSize="30" AllowPaging="true" AllowAutomaticDeletes="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" ButtonType="ImageButton" ConfirmTitle="Confirm Delete" ConfirmText="Are you sure you want to Delete this record ?"
                        CommandName="Delete">
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MRV No" SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RECV_DATE" DataType="System.DateTime" FilterControlAltText="Filter RECV_DATE column" HeaderText="Receive Date" SortExpression="RECV_DATE" UniqueName="RECV_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("RECV_DATE") %>'></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RECV_DATELabel" runat="server" Text='<%# Eval("RECV_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="RECV_BY" FilterControlAltText="Filter RECV_BY column" HeaderText="Receive By" SortExpression="RECV_BY" UniqueName="RECV_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DELIVERY_POINT" FilterControlAltText="Filter DELIVERY_POINT column" HeaderText="Delivery Point" SortExpression="DELIVERY_POINT" UniqueName="DELIVERY_POINT">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="Ship No" SortExpression="SHIP_NO" UniqueName="SHIP_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="Store Name" SortExpression="STORE_NAME" UniqueName="STORE_NAME">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList3" runat="server" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                                Width="135px" AppendDataBoundItems="True">
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="STORE_NAMELabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="PO_NO" ReadOnly="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO No" SortExpression="PO_NO" UniqueName="PO_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUPPLIER" FilterControlAltText="Filter SUPPLIER column" HeaderText="Supplier" SortExpression="SUPPLIER" UniqueName="SUPPLIER">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_NO" FilterControlAltText="Filter SRN_NO column" HeaderText="SRN No" SortExpression="SRN_NO" UniqueName="SRN_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_DESCR" FilterControlAltText="Filter ITEM_DESCR column" HeaderText="Item Description" SortExpression="ITEM_DESCR" UniqueName="ITEM_DESCR">
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="MatReceiveDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsPO_ShipmentATableAdapters.PIP_MAT_RECEIVETableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_MAT_RCV_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_RCV_NO" Type="String" />
            <asp:Parameter Name="RECV_DATE" Type="DateTime" />
            <asp:Parameter Name="RECV_BY" Type="String" />
            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SRN_NO" Type="String" />
            <asp:Parameter Name="ITEM_DESCR" Type="String" />
            <asp:Parameter Name="SUPPLIER" Type="String" />
            <asp:Parameter Name="DELIVERY_POINT" Type="String" />
            <asp:Parameter Name="original_MAT_RCV_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
