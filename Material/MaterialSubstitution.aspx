<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitution.aspx.cs" Inherits="Material_MaterialSubstitution" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script type="text/javascript">
        //<![CDATA[
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("REQ_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=1&REF_ID=" + id, "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any Transmittal!";
                alert(txt);
            }
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
        <telerik:RadButton ID="btnAdd" runat="server" Text="Create" Width="80px"></telerik:RadButton>

        <telerik:RadButton ID="btnDetails" runat="server" Text="Material List" Width="100px" OnClick="btnDetails_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnImport" runat="server" Text="Bulk Import.." Width="100px" Visible="false"></telerik:RadButton>
        <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
            <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
        </asp:LinkButton>

    </div>
    <div style="margin-top: 5px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"  PageSize="50"  PagerStyle-AlwaysVisible="true"
            AllowPaging="True"  AllowAutomaticUpdates="True" AllowAutomaticDeletes="True"
            AllowFilteringByColumn="True" OnItemCommand="itemsGrid_ItemCommand" OnItemDataBound="itemsGrid_ItemDataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
           <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="REQ_ID" ClientDataKeyNames="REQ_ID">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton">
                         <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                         <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn HeaderText="PDF" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                        </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="REQ_NO" AllowFiltering="true" AllowSorting="true" FilterControlAltText="Filter REQ_NO column" HeaderText="REQUEST NO" SortExpression="REQ_NO" UniqueName="REQ_NO">
                         <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="REQ_DATE" DataType="System.DateTime" FilterControlAltText="Filter REQ_DATE column" HeaderText="REQUEST DATE" SortExpression="REQ_DATE" UniqueName="REQ_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtEditReqDate" runat="server" SelectedDate='<%# Bind("REQ_DATE") %>'></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REQ_DATELabel" runat="server" Text='<%# Eval("REQ_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                         <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REQ_BY" AllowFiltering="false" FilterControlAltText="Filter REQ_BY column" HeaderText="REQUEST BY" SortExpression="REQ_BY" UniqueName="REQ_BY">
                         <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                         <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_MAT_SUBSTITUTETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_REQ_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REQ_NO" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="REQ_BY" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_REQ_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID AS SC_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF ORDER BY STORE_NAME"></asp:SqlDataSource>
</asp:Content>

