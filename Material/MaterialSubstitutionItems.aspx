<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitutionItems.aspx.cs" Inherits="Material_MaterialSubstitutionItems" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGridDetail.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }


    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Items" Width="100px"></telerik:RadButton>
    </div>
    <div>

        <telerik:RadGrid ID="itemsGridDetail" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="True" AllowSorting="True"
            DataSourceID="itemsDataSource" PageSize="50" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" DataKeyNames="BOM_ID,SEC_KEY" onkeypress="handleSpace(event)"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            PagerStyle-AlwaysVisible="true" OnItemDataBound="RadGrid1_ItemDataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="BOM_ID,SEC_KEY" EditMode="InPlace">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>

                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="BOM_ITEM" FilterControlAltText="Filter BOM_ITEM column" HeaderText="OLD MATERIAL" SortExpression="BOM_ITEM" UniqueName="BOM_ITEM" ReadOnly="True" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OLD_QTY" DataType="System.Decimal" DataFormatString="{0:#0.00}" FilterControlAltText="Filter OLD_QTY column" HeaderText="OLD QTY" SortExpression="OLD_QTY" UniqueName="OLD_QTY" ReadOnly="True" AllowFiltering="False">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NEW_MAT_CODE" FilterControlAltText="Filter NEW_MAT_CODE column" HeaderText="NEW MATERIAL" SortExpression="NEW_MAT_CODE" UniqueName="NEW_MAT_CODE" ReadOnly="True" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NEW_SIZE" FilterControlAltText="Filter NEW_SIZE column" DataFormatString="{0:#0.00}" HeaderText="NEW SIZE" SortExpression="NEW_SIZE" UniqueName="NEW_SIZE" ReadOnly="True" AllowFiltering="False">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NEW_WT" FilterControlAltText="Filter NEW_WT column" HeaderText="NEW WT" DataFormatString="{0:#0.00}" SortExpression="NEW_WT" UniqueName="NEW_WT" ReadOnly="True" AllowFiltering="False">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="NEW_QTY" DataType="System.Decimal" DataFormatString="{0:#0.00}" FilterControlAltText="Filter NEW_QTY column" HeaderText="NEW QTY" SortExpression="NEW_QTY" UniqueName="NEW_QTY" AllowFiltering="False">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="SS_FLAG" FilterControlAltText="Filter SS_FLAG column" HeaderText="FLAG" SortExpression="SS_FLAG" UniqueName="SS_FLAG" AllowFiltering="False">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="flagDataSource"
                                DataTextField="SS_FLAG" DataValueField="FLAG_ID" SelectedValue='<%# Bind("FLAG_ID") %>'>
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("SS_FLAG") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>

    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_ADP_SUBSTITUTE_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SEC_KEY" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="req_id" QueryStringField="REQ_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="NEW_QTY" Type="Decimal" />
            <asp:Parameter Name="FLAG_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SEC_KEY" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="flagDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT FLAG_ID, SS_FLAG FROM PIP_SUBSTITUTE_FLAG ORDER BY SS_FLAG"></asp:SqlDataSource>

    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
</asp:Content>

