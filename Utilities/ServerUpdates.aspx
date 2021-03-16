<%@ Page Title="Server Updates" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ServerUpdates.aspx.cs" Inherits="Utilities_Simulation" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 150px;
            /*background-color: gainsboro;#D8F5FB*/
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript">
        function confirmation() {
            if (confirm('Are you sure to proceed'))
                return true;
            else
                return false;
        }
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= gridUpdHistory.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=gridUpdHistory.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 280 + "px";
            grid.get_element()
            grid.repaint();


            var grid = $find('<%= grdiProgress.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=grdiProgress.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 300 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div class="contact-area">
        <telerik:RadMenu ID="RadMenu9" runat="server" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false" CssClass="RadMenuStyle">
            <Items>
                <telerik:RadMenuItem CssClass="menu-right">
                    <ItemTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td style="text-align: left; width: 100%;">
                                    <td style="text-align: right;">
                                        <asp:LinkButton ID="btnBack" runat="server" Text="Back" Font-Underline="false"
                                            OnClick="btnBack_Click"></asp:LinkButton>
                                    </td>
                                    <td style="text-align: right; width: 100%; padding-left: 20px">
                                        <td style="text-align: right;">
                                            <asp:LinkButton ID="btnProceed" runat="server" Text="Run Update All" Font-Underline="false" OnClientClick="return confirmation()"
                                                OnClick="btnProceed_Click"></asp:LinkButton>
                                        </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" OnTabClick="RadTabStrip1_TabClick" SelectedIndex="3">
            <Tabs>
                <telerik:RadTab Text="Current Progress" ImageUrl="../Images/icons/chart-icon.png"></telerik:RadTab>
                <telerik:RadTab Text="Update Errors" ImageUrl="../Images/icons/icon-error.png"></telerik:RadTab>
                <telerik:RadTab Text="Running History" ImageUrl="../Images/icons/batch-job.png" Selected="True"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="2">
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <telerik:RadGrid ID="grdiProgress" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsSmlProgress"
                    MasterTableView-AllowPaging="true" ClientDataKeyNames="PROCESS_NAME" CellSpacing="-1">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                    </ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="false" ClientDataKeyNames="PROCESS_NAME" DataSourceID="dsSmlProgress" HierarchyLoadMode="Client" PageSize="13"
                        PagerStyle-ShowPagerText="false" AllowPaging="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ACTIVITY_ID" FilterControlAltText="Filter ACTIVITY_ID column" HeaderText="SI No." SortExpression="ACTIVITY_ID" UniqueName="ACTIVITY_ID" DataType="System.Decimal">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PROCESS_NAME" FilterControlAltText="Filter PROCESS_NAME column" HeaderText="PROCESS_NAME" SortExpression="PROCESS_NAME" UniqueName="PROCESS_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PROCESS_STATUS" FilterControlAltText="Filter PROCESS_STATUS column" HeaderText="PROCESS_STATUS" SortExpression="PROCESS_STATUS" UniqueName="PROCESS_STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TIME_IN_SEC" FilterControlAltText="Filter TIME_IN_SEC column" HeaderText="TIME_IN_SEC" SortExpression="TIME_IN_SEC" UniqueName="TIME_IN_SEC" DataType="System.Decimal">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="USER_NAME" SortExpression="USER_NAME" UniqueName="USER_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RUN_DATE" DataType="System.DateTime" FilterControlAltText="Filter RUN_DATE column" HeaderText="RUN TIME" SortExpression="RUN_DATE" UniqueName="RUN_DATE" DataFormatString="{0:dd-MMM-yyyy hh:mm tt}">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>

                <asp:SqlDataSource ID="dsSmlProgress" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM TBL_PACKAGE_TRACKER WHERE PACKAGE_NAME ='PKG_UPDATE_ALL' ORDER BY CASE PROCESS_STATUS WHEN 'RUNNING' THEN 1 WHEN 'COMPLETED' THEN 2 ELSE 99 END, ACTIVITY_ID DESC"></asp:SqlDataSource>
                <telerik:RadButton ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" Text="Refresh"></telerik:RadButton>

            </telerik:RadPageView>

            <telerik:RadPageView ID="RadPageView3" runat="server">
                <telerik:RadGrid ID="gridErrors" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsExceptions"
                    MasterTableView-AllowPaging="true" CellSpacing="-1">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                    </ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="false" DataSourceID="dsExceptions" HierarchyLoadMode="Client" PageSize="15"
                        PagerStyle-ShowPagerText="false" AllowPaging="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="SEARCH_TAG" FilterControlAltText="Filter SEARCH_TAG column" HeaderText="Hint & Header" SortExpression="SEARCH_TAG" UniqueName="SEARCH_TAG">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SQL_ERROR" FilterControlAltText="Filter SQL_ERROR column" HeaderText="Error Details" SortExpression="SQL_ERROR" UniqueName="SQL_ERROR">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>

                <asp:SqlDataSource ID="dsExceptions" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT distinct SEARCH_TAG,SQL_ERROR FROM packaged_exceptions pe
    WHERE pe.package_name = 'PKG_UPDATE_ALL'"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM TBL_PACKAGE_TRACKER WHERE PACKAGE_NAME =CASE WHEN :SML_CAT ='SHOP' THEN 'P_PROCESS_SHOP_SIMULATION' ELSE 'P_PROCESS_SITE_SIMULATION' END ORDER BY ACTIVITY_ID">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="-1" Name="SML_CAT" QueryStringField="SML_CAT" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </telerik:RadPageView>

            <telerik:RadPageView ID="radUpdatePage" runat="server">
                <telerik:RadGrid ID="gridUpdHistory" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsUpdHistory"
                    MasterTableView-AllowPaging="true" ClientDataKeyNames="UPD_HEADER_ID" CellSpacing="-1">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                    </ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="false" ClientDataKeyNames="UPD_HEADER_ID" DataSourceID="dsUpdHistory" HierarchyLoadMode="Client" PageSize="15"
                        PagerStyle-ShowPagerText="false" AllowPaging="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="UPD_HEADER_ID" DataType="System.Decimal" FilterControlAltText="Filter UPD_HEADER_ID column" HeaderText="Header ID" SortExpression="UPD_HEADER_ID" UniqueName="UPD_HEADER_ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UPD_DATE" FilterControlAltText="Filter UPD_DATE column" HeaderText="Run Time" SortExpression="UPD_DATE" UniqueName="UPD_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy hh:mm tt}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="Status" SortExpression="STATUS" UniqueName="STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="Update User" SortExpression="USER_NAME" UniqueName="USER_NAME">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>
                <telerik:RadButton ID="RadButton1" runat="server" OnClick="btnRefresh_Click" Text="Refresh"></telerik:RadButton>
                <telerik:RadLabel ID="lblExportMessage" runat="server"></telerik:RadLabel>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
    <asp:SqlDataSource ID="dsUpdHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_UPD_HISTORY WHERE PROJECT_ID = :PROJECT_ID ORDER BY UPD_DATE DESC">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

