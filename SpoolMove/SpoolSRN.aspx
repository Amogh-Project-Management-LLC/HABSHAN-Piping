<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="SpoolSRN.aspx.cs" Inherits="SpoolMove_SpoolSRN" Title="Spool SRN" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= TransGridView.ClientID %>')
           var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
           var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

           var masterTable = $find("<%=TransGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="Register" Width="80" ></telerik:RadButton>
                    <telerik:RadButton ID="btnViewSpools" runat="server" Text="Spools" Width="80" OnClick="btnViewSpools_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="110" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" OnClick="btnBulkImport_Click"></telerik:RadButton>
                    <telerik:RadLabel ID="lblWarning" runat="server" Text=""></telerik:RadLabel>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Search.." AutoPostBack="True" Width="200px" Visible="false">
                    </telerik:RadTextBox>
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px" Visible="false">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="TransGridView" runat="server" CellSpacing="-1" DataSourceID="splTransDataSource"
            AllowPaging="True" PageSize="50" OnDataBound="TransGridView_DataBound" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true"
            OnItemDataBound="itemsGrid_ItemDataBound" >
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="splTransDataSource" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
                DataKeyNames="TRANS_ID" EditMode="PopUp" EditFormSettings-PopUpSettings-Modal="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridTemplateColumn  AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                        </telerik:GridTemplateColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this Spool?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="SER_NO" FilterControlAltText="Filter SER_NO column" HeaderText="SERIAL NUMBER"
                        SortExpression="SER_NO" UniqueName="SER_NO" AutoPostBackOnFilter="true" FilterControlWidth="120px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="ISSUE_DATE" DataType="System.DateTime" HeaderText="ISSUE DATE" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtIssueDateEdit" runat="server" SelectedDate='<%# Bind("ISSUE_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" >
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblIssueDate" runat="server" Text='<%# Eval("ISSUE_DATE", "{0:dd-MMM-yy}") %>' ></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="USER NAME"
                        SortExpression="USER_NAME" UniqueName="USER_NAME" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn HeaderText="SUBCONTRACTOR" SortExpression="SUB_CON_NAME" AutoPostBackOnFilter="true" FilterControlWidth="100px" DataField="SUB_CON_NAME">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddSubCon" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>' >
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSubCon" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP NUMBER" AutoPostBackOnFilter="true" FilterControlWidth="80px"
                        SortExpression="SHIP_NO" UniqueName="SHIP_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AREA_L1" FilterControlAltText="Filter AREA_L1 column" HeaderText="PCWBS" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                        SortExpression="AREA_L1" UniqueName="AREA_L1">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn HeaderText="DELIVERY LOCATION" SortExpression="DELIVERY_LOCATION" AutoPostBackOnFilter="true" FilterControlWidth="80px" DataField="DELIVERY_LOCATION">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddDelLoc" runat="server" AppendDataBoundItems="True" DataSourceID="deliveryLocDataSource"
                                DataTextField="DELIVERY_LOCATION" DataValueField="DELIVERY_LOCATION" SelectedValue='<%# Bind("DELIVERY_LOCATION") %>'>
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblDelLoc" runat="server" Text='<%# Bind("DELIVERY_LOCATION") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="ETA_DATE" DataType="System.DateTime" HeaderText="ETA DATE" SortExpression="ETA_DATE" UniqueName="ETA_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtETADate" runat="server" DbSelectedDate='<%# Bind("ETA_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" >
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblETADate" runat="server" Text='<%# Eval("ETA_DATE", "{0:dd-MMM-yy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="SHIPPING_DATE" DataType="System.DateTime" HeaderText="SHIPPING DATE" SortExpression="SHIPPING_DATE" UniqueName="SHIPPING_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtShipDate" runat="server" DbSelectedDate='<%# Bind("SHIPPING_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblShipDate" runat="server" Text='<%# Eval("SHIPPING_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="SPLS_COUNT" FilterControlAltText="Filter SPLS_COUNT column" HeaderText="SPOOLS" ReadOnly="true"
                        SortExpression="SPLS_COUNT" UniqueName="SPLS_COUNT"  AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" AllowFiltering="false"
                        SortExpression="REMARKS" UniqueName="REMARKS">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="splTransDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsSpoolMoveTableAdapters.VIEW_ADAPTER_SPL_TRANSTableAdapter"
        UpdateMethod="UpdateQuerySRN" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_TRANS_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SER_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="ETA_DATE" Type="DateTime" />
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="DELIVERY_LOCATION" Type="String" />
            <asp:Parameter Name="SHIPPING_DATE" Type="DateTime" />
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="original_TRANS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="CAT_ID" QueryStringField="CAT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="deliveryLocDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DELIVERY_LOCATION FROM PIP_SRN_DEL_LOCATION WHERE PROJECT_ID = :PROJECT_ID ORDER BY DELIVERY_LOCATION">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
