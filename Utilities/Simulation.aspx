<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Simulation.aspx.cs" Inherits="Utilities_Simulation" %>

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
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= gridSmlHistory.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            grid.get_element().style.height = (height) - 280 + "px";
            grid.get_element()
            grid.repaint();


            var grid = $find('<%= grdiProgress.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;        
            grid.get_element().style.height = (height) - 250 + "px";
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
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" OnTabClick="RadTabStrip1_TabClick" SelectedIndex="3">
            <Tabs>
                <telerik:RadTab Text="Simulation Setting" ImageUrl="../Images/icons/sim.png"></telerik:RadTab>
                <telerik:RadTab Text="Current Progress" ImageUrl="../Images/icons/chart-icon.png"></telerik:RadTab>
                <telerik:RadTab Text="Simulation Errors" ImageUrl="../Images/icons/icon-error.png"></telerik:RadTab>
                <telerik:RadTab Text="Running History" ImageUrl="../Images/icons/batch-job.png" Selected="True"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="3">

            <telerik:RadPageView ID="RadPageView1" runat="server">
                <table>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">Last Run User</td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="lblSmlUser" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Last Run Time&nbsp;</td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="lblSmlTime" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">Source of Material&nbsp;</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoMaterialSource" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="MRIR" Value="MRIR" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="MRV" Value="MRV"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>Use Common Store Material</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoUseCommonStore" runat="server" RepeatDirection="Horizontal"  >
                                <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="N"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                     <%--<tr>
                        <td style="background-color: Gainsboro; width: 200px;">Select Area Group</td>
                        <td>:</td>
                        <td>
                             <telerik:RadDropDownList ID="ddAreagroup" runat="server" 
                           Width="200px" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddAreagroup_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="Select Area Group" Value="-1"/>
                            <telerik:DropDownListItem  Value="1" Text="FOI1/FOI2"></telerik:DropDownListItem>
                            <telerik:DropDownListItem Value="2" Text="OTHERS"></telerik:DropDownListItem>
                        </Items>
                    </telerik:RadDropDownList>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">Select Spool SUBCON</td>
                        <td>:</td>
                        <td>
                            <telerik:RadComboBox ID="ddSubConForSml" runat="server" CheckBoxes="true"
                                EnableCheckAllItemsCheckBox="true" Width="200"
                                DataSourceID="dsSubContractor" DataTextField="SUB_CON_NAME"
                                DataValueField="SUB_CON_ID" Localization-AllItemsCheckedString="ALL SUBCON">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Drawing Status</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoDwgStatus" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Mat Check & Back Check Done" Value="MCBC" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Transmitted" Value="TRANSMITTED"></asp:ListItem>
                                <asp:ListItem Text="No Filter" Value="ALL"></asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">Hold & SWN</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoHoldStatus" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Exclude" Value="Y" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Include " Value="N"></asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td>SFR or Spool Priority</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoSpoolSFR" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="SFR First" Value="Y" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Spool First " Value="N"></asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">AGUG Status</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoAGUG" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Both" Value="BOTH" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Above Ground" Value="AG"></asp:ListItem>
                                <asp:ListItem Text="Under Ground" Value="UG"></asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td>Priority Option</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoPriority" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Priority Simulation" Value="Y" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Normal Simulation" Value="N"></asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">Area</td>
                        <td>:</td>
                        <td>
                            <telerik:RadComboBox ID="ddAreaForSml" runat="server" CheckBoxes="True"
                                EnableCheckAllItemsCheckBox="True" Width="200px"
                                DataSourceID="dsArea" DataTextField="AREA_L2"
                                DataValueField="AREA_L2" Localization-AllItemsCheckedString="ALL AREA">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Select Spool List</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoSelectedSpools" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rdoSelectedSpools_SelectedIndexChanged">
                                <asp:ListItem Text="All Eligible Spools" Value="N" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="On Selected Spool List" Value="Y"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Select Isometric List</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdoSelectedIsos" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rdoSelectedIsos_SelectedIndexChanged">
                                <asp:ListItem Text="All Eligible Isometrics" Value="N" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="On Selected Iso List" Value="Y"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
                <table id="rowSelectedSpl" runat="server" style="border: inset">
                    <tr>
                        <td colspan="3">
                            <div style="font-weight:bold;text-align:center;text-decoration:underline">Spool Uploader</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FileUpload Skin="Default" ID="splUploader" runat="server" ToolTip="Select an Excel File" /></td>

                        <td style="text-align: left;">
                            <telerik:RadButton ID="btnSplUpload" runat="server" Text="Upload" OnClick="btnSplUpload_Click" Skin="Outlook"></telerik:RadButton>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rdoUploadOption" runat="server" RepeatDirection="Vertical">
                                <asp:ListItem Text="Overwrite Existing & Upload" Value="APPEND"></asp:ListItem>
                                <asp:ListItem Text="Delete Existing & Upload" Value="DELETE" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList></td>
                        <td>
                            <telerik:RadButton ID="btnExportSpools" runat="server" Text="Export Exisitng" OnClick="btnExportSpools_Click" Skin="Default"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left;"><a href="../Import_Format/SimulationSpools.xlsx">Sample Spool File</a></td>
                    </tr>
                </table>
                <table id="rowSelectedIso" runat="server" visible="false" style="border: inset">
                    <tr>
                        <td colspan="3">
                            <div style="font-weight:bold;text-align:center;text-decoration:underline">ISO Uploader</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FileUpload Skin="Default" ID="isoUploader" runat="server" ToolTip="Select an Excel File" /></td>

                        <td style="text-align: left;">
                            <telerik:RadButton ID="btnIsoUpload" runat="server" Text="Upload" OnClick="btnIsoUpload_Click" Skin="Outlook"></telerik:RadButton>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Vertical">
                                <asp:ListItem Text="Append to old list" Value="APPEND"></asp:ListItem>
                                <asp:ListItem Text="Delete Old and Fresh Upload" Value="DELETE" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList></td>
                        <td>
                            <telerik:RadButton ID="btnExportIso" runat="server" Text="Export Exisitng" OnClick="btnExportIso_Click" Skin="Default"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left;"><a href="../Import_Format/SimulationIsomes.xlsx">Sample Iso File</a></td>
                    </tr>
                </table>
                <div style="text-align: center">
                    <table style="padding-top: 10px; text-align: center">
                        <tr>
                            <td>
                                <telerik:RadMenu ID="menuDefaultButton" runat="server" Skin="Default" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menu-right">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDefault" runat="server" Text="Restore Default" Font-Underline="false"
                                                    OnClick="btnDefault_Click"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </td>
                            <td>
                                <telerik:RadMenu ID="menuSaveButton" runat="server" Skin="Default" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menu-right">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnSaveSettings" runat="server" Text="Save Settings" Font-Underline="false"
                                                    OnClick="btnSaveSettings_Click"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </td>
                            <td>
                                <telerik:RadMenu ID="menuRunSimulation" runat="server" Skin="Default" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menu-right">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnRunSimulation" runat="server" Text="Run" Font-Underline="false"
                                                    OnClick="btnRunSimulation_Click"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </td>
                        </tr>
                    </table>
                </div>
            </telerik:RadPageView>

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
                            <telerik:GridBoundColumn DataField="ACTIVITY_ID" DataType="System.Decimal" FilterControlAltText="Filter ACTIVITY_ID column" HeaderText="Si No." SortExpression="ACTIVITY_ID" UniqueName="ACTIVITY_ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PROCESS_NAME" FilterControlAltText="Filter PROCESS_NAME column" HeaderText="Process" SortExpression="PROCESS_NAME" UniqueName="PROCESS_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PROCESS_STATUS" FilterControlAltText="Filter PROCESS_STATUS column" HeaderText="Status" SortExpression="PROCESS_STATUS" UniqueName="PROCESS_STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TIME_IN_SEC" DataType="System.Decimal" FilterControlAltText="Filter TIME_IN_SEC column" HeaderText="Time (Sec)" SortExpression="TIME_IN_SEC" UniqueName="TIME_IN_SEC">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RUN_DATE" DataType="System.DateTime" FilterControlAltText="Filter RUN_DATE column" HeaderText="Run Time" SortExpression="RUN_DATE" UniqueName="RUN_DATE" DataFormatString="{0:dd-MMM-yyyy HH:mm tt}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="User" SortExpression="USER_NAME" UniqueName="USER_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PACKAGE_NAME" FilterControlAltText="Filter PACKAGE_NAME column" HeaderText="Module" SortExpression="PACKAGE_NAME" UniqueName="PACKAGE_NAME">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>

                <asp:SqlDataSource ID="dsSmlProgress" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM TBL_PACKAGE_TRACKER WHERE PACKAGE_NAME =CASE WHEN :SML_CAT ='SHOP' THEN 'P_PROCESS_SHOP_SIMULATION' ELSE 'P_PROCESS_SITE_SIMULATION' END ORDER BY ACTIVITY_ID">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="SHOP" Name="SML_CAT" QueryStringField="SML_CAT" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <telerik:RadButton ID="RadButton1" runat="server" OnClick="btnRefresh_Click" Text="Refresh"></telerik:RadButton>

            </telerik:RadPageView>

            <telerik:RadPageView ID="RadPageView3" runat="server">
                <telerik:RadGrid ID="gridErrors" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsExceptions"
                    MasterTableView-AllowPaging="true" ClientDataKeyNames="SML_HEADER_ID" CellSpacing="-1">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                    </ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="false" ClientDataKeyNames="SML_HEADER_ID" DataSourceID="dsExceptions" HierarchyLoadMode="Client" PageSize="15"
                        PagerStyle-ShowPagerText="false" AllowPaging="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="SML_HEADER_ID" DataType="System.Decimal" FilterControlAltText="Filter SML_HEADER_ID column" HeaderText="SML_HEADER_ID" SortExpression="SML_HEADER_ID" UniqueName="SML_HEADER_ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SQL_ERROR" FilterControlAltText="Filter SQL_ERROR column" HeaderText="SQL_ERROR" SortExpression="SQL_ERROR" UniqueName="SQL_ERROR">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ERROR_TO_SHOW" FilterControlAltText="Filter ERROR_TO_SHOW column" HeaderText="ERROR_TO_SHOW" SortExpression="ERROR_TO_SHOW" UniqueName="ERROR_TO_SHOW">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>

                <asp:SqlDataSource ID="dsExceptions" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM SIMULATION_ERROR WHERE SML_HEADER_ID IN (SELECT I.SML_HEADER_ID FROM SIMULATION_HEADER I WHERE I.SML_CAT_ID=CASE WHEN :SML_CAT='SHOP' THEN 1 ELSE 2 END)">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="SHOP" Name="SML_CAT" QueryStringField="SML_CAT" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM TBL_PACKAGE_TRACKER WHERE PACKAGE_NAME =CASE WHEN :SML_CAT ='SHOP' THEN 'P_PROCESS_SHOP_SIMULATION' ELSE 'P_PROCESS_SITE_SIMULATION' END ORDER BY ACTIVITY_ID">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="-1" Name="SML_CAT" QueryStringField="SML_CAT" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </telerik:RadPageView>

            <telerik:RadPageView ID="radUpdatePage" runat="server">
                <telerik:RadGrid ID="gridSmlHistory" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsSmlHistory"
                    MasterTableView-AllowPaging="true" ClientDataKeyNames="SML_HEADER_ID" CellSpacing="-1">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="false" ClientDataKeyNames="SML_HEADER_ID" DataSourceID="dsSmlHistory" HierarchyLoadMode="Client" PageSize="15"
                        PagerStyle-ShowPagerText="false" AllowPaging="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="SML_HEADER_ID" DataType="System.Decimal" FilterControlAltText="Filter SML_HEADER_ID column" HeaderText="SML_HEADER_ID" SortExpression="SML_HEADER_ID" UniqueName="SML_HEADER_ID">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="Status" SortExpression="STATUS" UniqueName="STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SML_CAT" FilterControlAltText="Filter SML_CAT column" HeaderText="CATEGORY" SortExpression="SML_CAT" UniqueName="SML_CAT">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SML_DATE" FilterControlAltText="Filter SML_DATE column" HeaderText="Date Time" SortExpression="SML_DATE" UniqueName="SML_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy hh:mm tt}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="User" SortExpression="USER_NAME" UniqueName="USER_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EXCLUDE_HOLD" FilterControlAltText="Filter EXCLUDE_HOLD column" HeaderText="Exclude Hold" SortExpression="EXCLUDE_HOLD" UniqueName="EXCLUDE_HOLD">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DWG_STATUS" FilterControlAltText="Filter DWG_STATUS column" HeaderText="Dwg Status" SortExpression="DWG_STATUS" UniqueName="DWG_STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SFR_FIRST" FilterControlAltText="Filter ON_SFR_FIRST column" HeaderText="SFR First" SortExpression="ON_SFR_FIRST" UniqueName="ON_SFR_FIRST">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AGUG" FilterControlAltText="Filter AGUG column" HeaderText="AGUG" SortExpression="AGUG" UniqueName="AGUG">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SML_PRIORITY" FilterControlAltText="Filter SML_PRIORITY column" HeaderText="Priority" SortExpression="SML_PRIORITY" UniqueName="SML_PRIORITY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SELECTED_SPOOLS" FilterControlAltText="Filter ON_SELECTED_SPOOLS column" HeaderText="Selected Spool" SortExpression="ON_SELECTED_SPOOLS" UniqueName="ON_SELECTED_SPOOLS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SELECTED_ISOME" FilterControlAltText="Filter ON_SELECTED_ISOME column" HeaderText="Selected Iso" SortExpression="ON_SELECTED_ISOME" UniqueName="ON_SELECTED_ISOME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USE_COMMON_STORE" FilterControlAltText="Filter USE_COMMON_STORE column" HeaderText="Use Common Store" SortExpression="USE_COMMON_STORE" UniqueName="USE_COMMON_STORE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MATERIAL_SOURCE" FilterControlAltText="Filter MATERIAL_SOURCE column" HeaderText="Material Source" SortExpression="MATERIAL_SOURCE" UniqueName="MATERIAL_SOURCE">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>
                <telerik:RadDropDownList ID="rdoSmlDownload" runat="server" Width="350px" ExpandDirection="Up" DataSourceID="dsSimulationExportType" DataTextField="SML_EXPORT_DESCR" DataValueField="SML_EXPORT_ID" SelectedText="SIMULATION RESULT SPOOLS AVAILABLE" SelectedValue="1">
                </telerik:RadDropDownList>
                <asp:SqlDataSource ID="dsSimulationExportType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM SIMULATION_EXPORT_TYPE WHERE IS_ACTIVE='Y' AND SML_CAT=:SML_CAT">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="~" Name="SML_CAT" QueryStringField="SML_CAT" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <telerik:RadButton ID="btnExportSmlResult" runat="server" OnClick="btnExportSmlResult_Click" Text="Download"></telerik:RadButton>
                <telerik:RadButton ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" Text="Refresh"></telerik:RadButton>
                <telerik:RadLabel ID="lblExportSmlResult" runat="server"></telerik:RadLabel>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
    <asp:SqlDataSource ID="dsSmlResult" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSubContractor" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsArea" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &quot;AREA_L2&quot; FROM &quot;IPMS_AREA&quot; ORDER BY AREA_L2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSmlSelectedSpools" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  PIP_SML_SPOOL.LIST_NAME, ISO.ISO_TITLE1, SPL.SPOOL 
FROM PIP_SML_SPOOL,PIP_ISOMETRIC ISO,PIP_SPOOL SPL
WHERE PIP_SML_SPOOL.SPL_ID=SPL.SPL_ID AND SPL.ISO_ID = ISO.ISO_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSmlSelectedIso" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * from PIP_SML_ISOME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSmlHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_SML_HISTORY WHERE PROJECT_ID = :PROJECT_ID AND SML_CAT= :SML_CAT ORDER BY SML_DATE DESC">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SML_CAT" QueryStringField="SML_CAT" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

