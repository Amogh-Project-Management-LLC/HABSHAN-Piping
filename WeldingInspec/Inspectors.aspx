<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inspectors.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="WeldingInspec_Inspectors" Title="Inspector" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="80"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>


    <div class="right_content">

        <telerik:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowFilteringByColumn="True" AllowPaging="True"
            AllowSorting="True" CellSpacing="0" GridLines="None" PageSize="20" AutoGenerateColumns="False" DataSourceID="WelderDataSource"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                <Selecting AllowRowSelect="True"></Selecting>
                <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                <Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="100" ItemsPerView="100" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <MasterTableView DataKeyNames="INSP_ID" DataSourceID="WelderDataSource" EditMode="InPlace">
                <Columns>
                    <%-- GRID VIEW EDIT COLUMN --%>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="20" />
                    </telerik:GridEditCommandColumn>
                    <%-- GRID VIEW COLUMN END --%>

                    <%-- GRID VIEW DELETE COLUMN --%>
                    <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20" />
                    </telerik:GridButtonColumn>
                    <%-- GRID VIEW DELETE COLUMN END --%>

                    <telerik:GridBoundColumn DataField="INSP_CODE" FilterControlAltText="Filter INSP_CODE column" HeaderText="INSPECTOR CODE" SortExpression="INSP_CODE" UniqueName="INSP_CODE" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_NAME" FilterControlAltText="Filter INSP_NAME column" HeaderText="INSPECTOR NAME" SortExpression="INSP_NAME" UniqueName="INSP_NAME"  AutoPostBackOnFilter="true">
                        <ItemStyle Width="100" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUBCON NAME" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME"  AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddSubconEdit" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SUB_CON_ID") %>'
                                Width="120px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>

                        <ItemTemplate>
                            <asp:Label ID="lblSubconGrid" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="INSP_TYPE" FilterControlAltText="Filter INSP_TYPE column" HeaderText="INSPECTOR TYPE" SortExpression="INSP_TYPE" UniqueName="INSP_TYPE"  AutoPostBackOnFilter="true">
                        <EditItemTemplate>

                            <asp:DropDownList ID="ddInspTypeEdit" runat="server" DataSourceID="InspecTypeDataSource"
                                DataTextField="INSP_TYPE" DataValueField="TYPE_ID" SelectedValue='<%# Bind("TYPE_ID") %>'
                                Width="100px">
                            </asp:DropDownList>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("INSP_TYPE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />


            <FilterMenu EnableImageSprites="False">
            </FilterMenu>

        </telerik:RadGrid>
    </div>

    <%--GRID DATA SOURCE--%>
    <asp:ObjectDataSource ID="WelderDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsWeldersTableAdapters.VIEW_INSPECTORTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="INSP_CODE" Type="String" />
            <asp:Parameter Name="INSP_NAME" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
            <asp:Parameter Name="TYPE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_INSP_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_INSP_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <%--GRID DATA SOURCE END--%>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME 
                        FROM SUB_CONTRACTOR 
                        WHERE (PROJ_ID = :PROJECT_ID) 
                        ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="InspecTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TYPE_ID, INSP_TYPE FROM INSPECTOR_TYPE ORDER BY INSP_TYPE"></asp:SqlDataSource>
    <asp:HiddenField ID="FilterValue" runat="server" />
</asp:Content>
