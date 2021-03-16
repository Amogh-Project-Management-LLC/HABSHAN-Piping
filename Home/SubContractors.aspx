<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SubContractors.aspx.cs" Inherits="Home_SubContractors" Title="Sub-Contractors" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= subConGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= subConGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnStores" runat="server" Text="Stores" Width="80px" OnClick="btnStores_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnPriority" runat="server" Text="Priority" Width="80px" OnClick="btnPriority_Click" CausesValidation="false"></telerik:RadButton>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>

    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%" runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Subcon ID
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubconID" runat="server" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="subconIdValidator" runat="server" ControlToValidate="txtSubconID"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Subcon Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubconName" runat="server" Width="160px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="subconNameValidator" runat="server" ControlToValidate="txtSubconName"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Short Code
                        </td>
                        <td>
                            <asp:TextBox ID="txtShortCode" runat="server" Width="80px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="shortCodeValidator" runat="server" ControlToValidate="txtShortCode"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Field Subcon
                        </td>
                        <td>
                            <asp:DropDownList ID="ddFieldSC" runat="server" Width="80px">
                                <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                <asp:ListItem Value="N" Text="No" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Fabrication Subcon
                        </td>
                        <td>
                            <asp:DropDownList ID="ddShopSC" runat="server" Width="80px">
                                <asp:ListItem Value="Y" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="N" Text="No"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="subConGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" OnItemCommand="subConGridView_ItemCommand"
                    PagerStyle-AlwaysVisible="true" PageSize="50" CssClass="DataWebControlStyle" DataSourceID="matTypeDataSource"
                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true"
                    Width="100%" DataKeyNames="SUB_CON_ID" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                    </ClientSettings>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>
                    <MasterTableView EditMode="InPlace" DataSourceID="matTypeDataSource" DataKeyNames="SUB_CON_ID">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" />
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete PO" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="SUB_CON_ID" HeaderText="SUB CON ID" SortExpression="SUB_CON_ID" ReadOnly="true" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="SUBCON NAME" SortExpression="SUB_CON_NAME" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="SHORT_NAME" HeaderText="SHORT NAME" SortExpression="SHORT_NAME" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FIELD_SC" HeaderText="FIELD SC" SortExpression="FIELD_SC" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FAB_SC" HeaderText="FAB SC" SortExpression="FAB_SC" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="COMMON_STORE" HeaderText="COMMON STORE" SortExpression="COMMON_STORE" AllowFiltering="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="COMMON_STORE_FOR" HeaderText="COMMON STORE FOR" SortExpression="COMMON_STORE_FOR" AllowFiltering="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USE_COMMON_STORE" HeaderText="USE COMMON STORE" SortExpression="USE_COMMON_STORE" AllowFiltering="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="COMMON_SC_NAME" HeaderText="COMMON SC NAME" SortExpression="COMMON_SC_NAME" AllowFiltering="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                             <telerik:GridBoundColumn DataField="BAL_FLG" HeaderText="BAL SC FLG" SortExpression="BAL_FLG" AllowFiltering="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>

                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </td>
        </tr>

    </table>
    <asp:ObjectDataSource ID="matTypeDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralATableAdapters.VIEW_SUB_CONTRACTORTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SUB_CON_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SUB_CON_NAME" Type="String" />
            <asp:Parameter Name="SHORT_NAME" Type="String" />
            <asp:Parameter Name="FIELD_SC" Type="String" />
            <asp:Parameter Name="FAB_SC" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="COMMON_STORE" Type="String" />
            <asp:Parameter Name="PAINT_SC" Type="String" />
            <asp:Parameter Name="COMMON_STORE_FOR" Type="String" />
            <asp:Parameter Name="USE_COMMON_STORE" Type="String" />
            <asp:Parameter Name="COMMON_SC_NAME" Type="String" />
            <asp:Parameter Name="BAL_FLG" Type="String" />
            
            <asp:Parameter Name="Original_SUB_CON_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
