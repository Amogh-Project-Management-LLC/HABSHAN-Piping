<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JointsWeldedByWelder.aspx.cs" Inherits="JointsWeldedByWelder" Title="Joints welded by welder" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= jcGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke; padding: 3px;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnExpExcel" runat="server" Text="Excel" Width="80" CausesValidation="false" OnClick="btnExpExcel_Click" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="itemsDataSource" PageSize="20"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true">
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
            <MasterTableView EditMode="InPlace" DataSourceID="itemsDataSource">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" />
                <Columns>
                    <telerik:GridBoundColumn DataField="WELDER_NO" HeaderText="Welder No" SortExpression="WELDER_NO" AutoPostBackOnFilter="true" FilterControlWidth="70px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_DATE" HeaderText="Weld Date" SortExpression="WELD_DATE" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_PROCESS" HeaderText="Process" SortExpression="WELD_PROCESS" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_PASS" HeaderText="Pass" SortExpression="WELD_PASS" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT ISO_TITLE1, SPOOL, JOINT_NO, TO_CHAR(WELD_DATE, 'DD-MON-YYYY') AS WELD_DATE, WELDER_NO, WELD_PROCESS, WELD_PASS FROM VIEW_JOINT_TITLE_WELDERS WHERE (WELDER_ID = :WELDER_ID) ORDER BY WELD_DATE, ISO_TITLE1, SPOOL, JOINT_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WELDER_ID" QueryStringField="WELDER_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
