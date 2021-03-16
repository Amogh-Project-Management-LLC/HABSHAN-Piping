<%@ Page Title="Shop Simulation" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShopSimulation.aspx.cs" Inherits="Utilities_ShopSimulation" %>

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
            var masterTable = $find("<%=gridSmlHistory.ClientID %>").get_masterTableView();
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
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" OnTabClick="RadTabStrip1_TabClick">
            <Tabs>
                <telerik:RadTab Text="Setting" ImageUrl="../Images/icons/sim.png"></telerik:RadTab>
                <telerik:RadTab Text="Progress" ImageUrl="../Images/icons/batch-job.png"></telerik:RadTab>
                <telerik:RadTab Text="History" ImageUrl="../Images/icons/db_update.png"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server">

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
                            <asp:RadioButtonList ID="rdoUseCommonStore" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="N"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: Gainsboro; width: 200px;">Subcon for Simulation</td>
                        <td>:</td>
                        <td>
                            <telerik:RadComboBox ID="ddSubConSelect" runat="server" CheckBoxes="true"
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

                    <%--<tr>
            <td>Remain Simulation</td>
            <td>:</td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rdoSelectedSpools_SelectedIndexChanged">
                    <asp:ListItem Text="Yes" Value="REMAIN"></asp:ListItem>
                    <asp:ListItem Text="No" Value="SHOP" Selected="True"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="font-size: 11px; color: Red">Note :- Remain Simulation will consider Pipes only from Remain. It won't take pipe quantities from stock.
            </td>
        </tr>--%>
                </table>
                <table id="rowSelectedSpl" runat="server">
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
                            <telerik:RadButton ID="btnExport" runat="server" Text="Export Exisitng" OnClick="btnExport_Click" Skin="Default"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left;"><a href="../Import_Format/SimulationSpools.xlsx">Sample File</a></td>
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

            <telerik:RadPageView ID="RadPageView3" runat="server">
                <telerik:RadLabel runat="server" ID="RadLabel2" Text="Progress bar will be activated soon...."></telerik:RadLabel>
            </telerik:RadPageView>

            <telerik:RadPageView ID="radUpdatePage" runat="server">
                <telerik:RadGrid ID="gridSmlHistory" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsSmlHistory"
                    OnSelectedIndexChanged="gridSmlHistory_SelectedIndexChanged" MasterTableView-AllowPaging="true">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="false" ClientDataKeyNames="SML_DETAIL_ID" DataSourceID="dsSmlHistory" HierarchyLoadMode="Client" PageSize="10"
                        PagerStyle-ShowPagerText="false" AllowPaging="true">
                        <Columns>
                            <telerik:GridBoundColumn DataField="SML_DATE" FilterControlAltText="Filter SML_DATE column" HeaderText="Run Time" SortExpression="SML_DATE" UniqueName="SML_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy HH:MI}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="Run By" SortExpression="USER_NAME" UniqueName="USER_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EXCLUDE_HOLD" FilterControlAltText="Filter EXCLUDE_HOLD column" HeaderText="Exclude Hold" SortExpression="EXCLUDE_HOLD" UniqueName="EXCLUDE_HOLD">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DWG_STATUS" FilterControlAltText="Filter DWG_STATUS column" HeaderText="Dwg Status" SortExpression="DWG_STATUS" UniqueName="DWG_STATUS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SFR_FIRST" FilterControlAltText="Filter ON_SFR_FIRST column" HeaderText="SFR First?" SortExpression="ON_SFR_FIRST" UniqueName="ON_SFR_FIRST">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SML_SUBCON" FilterControlAltText="Filter SML_SUBCON column" HeaderText="Subcon" SortExpression="SML_SUBCON" UniqueName="SML_SUBCON">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AGUG" FilterControlAltText="Filter AGUG column" HeaderText="AGUG" SortExpression="AGUG" UniqueName="AGUG">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SML_PRIORITY" FilterControlAltText="Filter SML_PRIORITY column" HeaderText="Priority" SortExpression="SML_PRIORITY" UniqueName="SML_PRIORITY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SELECTED_ISOME" FilterControlAltText="Filter ON_SELECTED_ISOME column" HeaderText="Custom ISO" SortExpression="ON_SELECTED_ISOME" UniqueName="ON_SELECTED_ISOME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SELECTED_SPOOLS" FilterControlAltText="Filter ON_SELECTED_SPOOLS column" HeaderText="Custom Spool" SortExpression="ON_SELECTED_SPOOLS" UniqueName="ON_SELECTED_SPOOLS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ON_SELECTED_AREA" FilterControlAltText="Filter ON_SELECTED_AREA column" HeaderText="Custom Area" SortExpression="ON_SELECTED_AREA" UniqueName="ON_SELECTED_AREA">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="USE_COMMON_STORE" FilterControlAltText="Filter USE_COMMON_STORE column" HeaderText="Use Common Store" SortExpression="USE_COMMON_STORE" UniqueName="USE_COMMON_STORE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MATERIAL_SOURCE" FilterControlAltText="Filter MATERIAL_SOURCE column" HeaderText="Material Source" SortExpression="MATERIAL_SOURCE" UniqueName="MATERIAL_SOURCE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn Visible="false" DataField="SML_DETAIL_ID" DataType="System.Decimal" FilterControlAltText="Filter SML_DETAIL_ID column" HeaderText="SML_DETAIL_ID" SortExpression="SML_DETAIL_ID" UniqueName="SML_DETAIL_ID">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                        <PagerStyle ShowPagerText="False" />
                    </MasterTableView>
                </telerik:RadGrid>
                <telerik:RadDropDownList ID="rdoSmlDownload" runat="server" Width="350px" ExpandDirection="Up">
                    <Items>
                        <telerik:DropDownListItem Text="SIMULATION RESULT SPOOLS AVAILABLE" Value="1" Selected="true" />
                        <telerik:DropDownListItem Text="SIMULATION RESULT ONE ITEM SHORTAGE" Value="2" />
                        <telerik:DropDownListItem Text="SHOP SIMULATION RESULT ALLOCATION" Value="3" />
                    </Items>
                </telerik:RadDropDownList>
                <telerik:RadButton ID="btnExportSmlResult" runat="server" OnClick="btnExportSmlResult_Click" Text="Download"></telerik:RadButton>
                <telerik:RadLabel ID="lblExportSmlResult" runat="server"></telerik:RadLabel>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
    <asp:SqlDataSource ID="dsSubContractor" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  SUB_CON_NAME, SUB_CON_ID FROM SUB_CONTRACTOR WHERE FAB_SC='Y' ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsArea" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &quot;AREA_L2&quot; FROM &quot;IPMS_AREA&quot; ORDER BY AREA_L2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsExport" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  PIP_SML_SPOOL.LIST_NAME, ISO.ISO_TITLE1, SPL.SPOOL 
FROM PIP_SML_SPOOL,PIP_ISOMETRIC ISO,PIP_SPOOL SPL
WHERE PIP_SML_SPOOL.SPL_ID=SPL.SPL_ID AND SPL.ISO_ID = ISO.ISO_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSmlHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_SML_HISTORY WHERE PROJECT_ID = :PROJECT_ID ORDER BY SML_DATE DESC">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

