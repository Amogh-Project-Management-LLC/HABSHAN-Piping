<%@ Page Title="Spool Transfer" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolTransfer.aspx.cs" Inherits="SpoolMove_SpoolTransfer" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

            var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }

        function DocDetail() {
            try {
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("TRANS_ID");
                radopen("SpoolTransferDocNo.aspx?TRANS_ID=" + id, "RadWindow1", 750, 570);
            }
            catch (err) {
                txt = "Select any Row!";
                alert(txt);
            }
        }
    </script>
    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>

                    <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnNew" runat="server" Text="Register" Width="80px"></telerik:RadButton>
                    <telerik:RadButton ID="btnSpool" runat="server" Text="Spools" Width="120px" OnClick="btnSpool_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnSpoolPreview" runat="server" Text="Spool Preview" Width="120px" OnClick="btnSpoolPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnMatPreview" runat="server" Text="Material Preview" Width="120px"></telerik:RadButton>
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" OnClick="btnBulkImport_Click"></telerik:RadButton>
                    <asp:LinkButton ID="linkDoc" runat="server" OnClientClick="DocDetail(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton ID="btnDoc" runat="server" Text="Document Numbers" Width="150px"></telerik:RadButton>
                    </asp:LinkButton>

                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowFilteringByColumn="true" PagerStyle-AlwaysVisible="true" AllowSorting="true"
            AllowAutomaticDeletes="True" AllowPaging="True" ClientSettings-Scrolling-AllowScroll="true" PageSize="50" OnItemDataBound="itemsGrid_ItemDataBound"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <ClientSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="TRANS_ID" AllowAutomaticUpdates="true" EditMode="InPlace"
                ClientDataKeyNames="TRANS_ID">
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

                    <telerik:GridBoundColumn DataField="TRANS_NO" ReadOnly="true" FilterControlAltText="Filter TRANS_NO column" HeaderText="TRANSFER NO" SortExpression="TRANS_NO" UniqueName="TRANS_NO" AutoPostBackOnFilter="true" FilterControlWidth="200">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />

                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP NO" SortExpression="SHIP_NO" UniqueName="SHIP_NO" AutoPostBackOnFilter="true" FilterControlWidth="50">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CONTAINER_NO" FilterControlAltText="Filter CONTAINER_NO column" HeaderText="CONTAINER NO" SortExpression="CONTAINER_NO" UniqueName="CONTAINER_NO"
                        AutoPostBackOnFilter="true" FilterControlWidth="50">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="TRANS_DATE" DataType="System.DateTime" FilterControlAltText="Filter TRANS_DATE column"
                        HeaderText="TRANSFER DATE" SortExpression="TRANS_DATE" UniqueName="TRANS_DATE" >
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtTRANS_DATEedit" runat="server" DbSelectedDate='<%# Bind("TRANS_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TRANS_DATELabel" runat="server" Text='<%# Eval("TRANS_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="TRANS_BY" ReadOnly="true" FilterControlAltText="Filter TRANS_BY column" HeaderText="TRANSFER BY" SortExpression="TRANS_BY" UniqueName="TRANS_BY" AutoPostBackOnFilter="true" FilterControlWidth="80">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn HeaderText="FROM SUBCON" SortExpression="FROM_SUBCON" DataField="FROM_SUBCON"
                        AutoPostBackOnFilter="true" UniqueName="FROM_SUBCON" AllowFiltering="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddFromSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("FROM_SC") %>'
                                Width="180px" DropDownHeight="200px">
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("FROM_SUBCON") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="TO SUBCON" SortExpression="TO_SUBCON" DataField="TO_SUBCON" AutoPostBackOnFilter="true"
                        UniqueName="TO_SUBCON" AllowFiltering="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddToSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("TO_SC") %>'
                                Width="180px" DropDownHeight="200px">
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("TO_SUBCON") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="REASON" SortExpression="TRANSFER_REASON">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlReason" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Bind("TRANSFER_REASON") %>'
                                Width="180px" DropDownHeight="200px">
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                    <telerik:DropDownListItem Text="For Coating" Value="For Coating" />
                                    <telerik:DropDownListItem Text="For Painting" Value="For Painting" />
                                    <telerik:DropDownListItem Text="For Site/SRN" Value="For Site/SRN" />
                                    <telerik:DropDownListItem Text="For Erection" Value="For Erection" />
                                    <telerik:DropDownListItem Text="Others.." Value="Others" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTransReason" runat="server" Text='<%# Bind("TRANSFER_REASON") %>' Width="126px"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="DOC_REF_NO" FilterControlAltText="Filter DOC_REF_NO column" HeaderText="DOC REF NO" SortExpression="DOC_REF_NO" UniqueName="DOC_REF_NO" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>


    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SPL_TRANSFER WHERE (PROJECT_ID = :PROJECT_ID)"
        DeleteCommand="DELETE FROM PIP_SPL_TRANSFER WHERE (TRANS_ID = :TRANS_ID)"
        UpdateCommand="UPDATE PIP_SPL_TRANSFER 
                        SET      SHIP_NO =:SHIP_NO, CONTAINER_NO = :CONTAINER_NO, TRANS_DATE = :TRANS_DATE, FROM_SC=:FROM_SC, TO_SC=:TO_SC ,
                       TRANSFER_REASON=:TRANSFER_REASON ,REMARKS =: REMARKS
                       WHERE (TRANS_ID = :TRANS_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="TRANS_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>


            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="CONTAINER_NO" Type="String" />
            <asp:Parameter Name="TRANS_DATE" Type="DateTime" />
            <asp:Parameter Name="FROM_SC" Type="Decimal" />
            <asp:Parameter Name="TO_SC" Type="Decimal" />
            <asp:Parameter Name="TRANSFER_REASON" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="TRANS_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "SUB_CON_ID", "SUB_CON_NAME" FROM "SUB_CONTRACTOR" ORDER BY "SUB_CON_NAME"'></asp:SqlDataSource>
</asp:Content>
