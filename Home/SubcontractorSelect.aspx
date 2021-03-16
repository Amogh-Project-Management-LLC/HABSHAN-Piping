<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SubcontractorSelect.aspx.cs" Inherits="SubcontractorSelect" Title="Subcontractors selection" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        

        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }

        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var NavPanelDivWidth = document.getElementById("NavPanelDiv").clientWidth
            var HeaderHeight = document.getElementById("PageHeader").clientHeight
            var footerHeight = document.getElementById("PageFooter").clientHeight
            var divHeaderHeight = document.getElementById("HeaderDiv").clientHeight
            grid.get_element().style.height = (height) - HeaderHeight - footerHeight - divHeaderHeight - 60 + "px";
            grid.get_element().style.width = width - NavPanelDivWidth - 40 + "px";
            grid.repaint();
        }

    </script>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="90px" />
                        </td>
                        
                </table>
  <table>
       
      
        <tr>
            <td>
                <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="MAIN_SUB_CON_ID,SUB_CON_ID" DataSourceID="itemsDataSource" 
                    PageSize="50" AllowSorting="true" onkeypress="handleSpace(event)"
                    PagerStyle-AlwaysVisible="true" OnItemCommand="itemsGridView_ItemCommand">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
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
                    <MasterTableView DataSourceID="itemsDataSource" DataKeyNames="MAIN_SUB_CON_ID,SUB_CON_ID" AutoGenerateColumns="False" PageSize="50"
                        AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" EditMode="InPlace"
                        AllowMultiColumnSorting="true" ClientDataKeyNames="MAIN_SUB_CON_ID,SUB_CON_ID" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>
                   
                            <telerik:GridBoundColumn DataField="MAIN_SUB_CON" HeaderText="MAIN SUBCON" SortExpression="MAIN_SUB_CON" ReadOnly="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SUB_CON" HeaderText="SUBCON" SortExpression="SUB_CON" ReadOnly="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SEQ" HeaderText="SEQ" SortExpression="SEQ" AutoPostBackOnFilter="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DEL_SUB_CON_FLG" HeaderText="DEL SUB CON FLG" SortExpression="DEL_SUB_CON_FLG" AutoPostBackOnFilter="true">
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

    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SUBCON_PRIORITY WHERE MAIN_SUB_CON_ID=:SC_ID"
        DeleteCommand="DELETE FROM AMOGH.SUB_CONTRACTOR_PRIORITY WHERE (MAIN_SUB_CON_ID = :MAIN_SUB_CON_ID AND SUB_CON_ID =:SUB_CON_ID)"
        UpdateCommand="UPDATE AMOGH.SUB_CONTRACTOR_PRIORITY
                        SET SEQ=:SEQ,DEL_SUB_CON_FLG=:DEL_SUB_CON_FLG
                        WHERE (MAIN_SUB_CON_ID = :MAIN_SUB_CON_ID AND SUB_CON_ID =:SUB_CON_ID)">

        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="SC_ID" QueryStringField="SC_ID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="MAIN_SUB_CON_ID" Type="Decimal" />
             <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DEL_SUB_CON_FLG" Type="String" />
            <asp:Parameter Name="SEQ" Type="Decimal" />
            <asp:Parameter Name="MAIN_SUB_CON_ID" Type="Decimal" />
              <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
