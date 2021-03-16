<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RepairWeldingEntry.aspx.cs" Title="Repair Welding"
    MasterPageFile="~/MasterPage.master" Inherits="WeldingInspec_RepairWeldingEntry" %>


<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth;
            grid.get_element().style.height = (height) - document.getElementById("grad").clientHeight - document.getElementById("MasterHeader").clientHeight
                - document.getElementById("headerButtons").clientHeight
                - document.getElementById("MasterFooter").clientHeight - 20 + "px";
            grid.get_element().style.width = width - 25 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <div class="right_content">
        <%-- GRID VIEW EDIT COLUMN --%>
        <div class="menu-div">
            <telerik:RadMenu ID="HeaderMenu" runat="server" OnItemClick="HeaderMenu_ItemClick" Width="100%" Visible="false">
                <Items>

                    <telerik:RadMenuItem Text="Entry" Value="entry"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Text="Back" Value="back"></telerik:RadMenuItem>
                </Items>
            </telerik:RadMenu>
        </div>
        <div id="headerButtons">
            <telerik:RadButton ID="Entry" runat="server" Text="Entry" Width="80px" OnClick="Entry_Click" CausesValidation="false"></telerik:RadButton>
        </div>
        <%--GRID VIEW START--%>

        <div class="contact-area" style="width: 100%;">
            <asp:Panel ID="entryPanel" runat="server" DefaultButton="btnSave" Visible="false">
                <table>
                    <tr>
                        <td class="auto-style1">Subcon</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <telerik:RadComboBox ID="cboSubcon" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                OnDataBound="cboSubcon_DataBound" Width="160px" CausesValidation="false" DropDownWidth="200px" Height="300px">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Subcon)" Value="99" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                        <td>&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="auto-style1">ISO-Joint No.</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <telerik:RadComboBox ID="cboJoints" runat="server" AutoPostBack="True" DataSourceID="jointsDataSource" ValidationGroup="submit" CausesValidation="false" DropDownWidth="200px" Height="300px"
                                DataTextField="JOINT_TITLE" DataValueField="JOINT_ID" AppendDataBoundItems="True" OnSelectedIndexChanged="cboJoints_SelectedIndexChanged" Filter="Contains" AllowCustomText="true">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Selected="True" Text="(Select Joint)" Value="-1" />
                                </Items>
                            </telerik:RadComboBox>
                            <asp:CompareValidator ValidationGroup="submit" ID="jointValidator" runat="server" ControlToValidate="cboJoints"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red" SetFocusOnError="true"></asp:CompareValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">WPS Number:</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <telerik:RadComboBox ID="cboWps" runat="server" AppendDataBoundItems="True" DataSourceID="wpsDataSource" DropDownWidth="200px" Height="300px"
                                DataTextField="WPS_NO1" DataValueField="WPS_ID" AutoPostBack="True" OnDataBinding="cboWps_DataBinding1" AllowCustomText="true" Filter="Contains">
                            </telerik:RadComboBox>
                            <telerik:RadTextBox ID="txtJoint_size" runat="server" Visible="False">
                            </telerik:RadTextBox>
                            <telerik:RadTextBox ID="txtJoint_thk" runat="server" Visible="False">
                            </telerik:RadTextBox>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Repair Code<br />
                        </td>
                        <td class="auto-style2">:</td>

                        <td class="auto-style3">
                            <telerik:RadDropDownList ID="drpRepairCode" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DropDownWidth="200px" Height="300px"
                                DataSourceID="RepairCodeDataSource" DataTextField="NEXT_DWR_REPAIR_CODE" DataValueField="NEXT_DWR_REPAIR_CODE"
                                Width="160px" CausesValidation="False">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Selected="True" Text="(Select Repair Code)" Value="-1" />
                                </Items>
                            </telerik:RadDropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="drpRepairCode"
                                ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Repair Welder (Root)</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">

                            <telerik:RadComboBox ID="drpWelder1" runat="server" AppendDataBoundItems="True" DataSourceID="weldersDataSource" Height="150px"
                                DataTextField="WELDER_NO" DataValueField="WELDER_ID" AutoPostBack="True" AllowCustomText="true" Filter="Contains">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="consmValidator" runat="server" ControlToValidate="drpWelder1"
                                ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>

                    </tr>
                    <tr>
                        <td class="auto-style1">Repair Welder (Hot)</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">

                            <telerik:RadComboBox ID="drpWelder2" runat="server" AppendDataBoundItems="True" DataSourceID="weldersDataSource" Height="150px"
                                DataTextField="WELDER_NO" DataValueField="WELDER_ID" AutoPostBack="True" AllowCustomText="true" Filter="Contains">
                            </telerik:RadComboBox>
                        </td>

                    </tr>
                    <tr>
                        <td class="auto-style1">Repair Welder (Fill)</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <telerik:RadComboBox ID="drpWelder3" runat="server" AppendDataBoundItems="True" DataSourceID="weldersDataSource" Height="150px"
                                DataTextField="WELDER_NO" DataValueField="WELDER_ID" AutoPostBack="True" AllowCustomText="true" Filter="Contains">
                            </telerik:RadComboBox>
                        </td>

                    </tr>
                    <tr>
                        <td class="auto-style1">Repair Welder (Cap)</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <telerik:RadComboBox ID="drpWelder4" runat="server" AppendDataBoundItems="True" DataSourceID="weldersDataSource" Height="150px"
                                DataTextField="WELDER_NO" DataValueField="WELDER_ID" AutoPostBack="True" AllowCustomText="true" Filter="Contains">
                            </telerik:RadComboBox>
                        </td>

                    </tr>
                    <tr>
                        <td class="auto-style1">Weld Report No.</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <asp:TextBox ID="txtWeldRepNo" runat="server" ValidationGroup="submit" Width="150px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtWeldRepNo" ValidationGroup="submit"
                                ErrorMessage="*" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Repair Date</td>
                        <td class="auto-style2">:</td>
                        <td class="auto-style3">
                            <telerik:RadDatePicker ID="txtRepDate" runat="server">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Bisque" />
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRepDate" ValidationGroup="submit"
                                ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <%-- <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                    <td class="auto-style3">
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>--%>
                    <tr>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style2">&nbsp;</td>
                        <td class="auto-style3">
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="89px" ValidationGroup="submit" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <%--GRID VIEW START--%>
                <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" AutoGenerateColumns="False"
                    AllowAutomaticUpdates="True" DataSourceID="HistoryDataSource" AllowAutomaticDeletes="True" AllowPaging="True"
                    AllowFilteringByColumn="True" OnItemCommand="RadGrid1_ItemCommand" PagerStyle-AlwaysVisible="true" PageSize="50"
                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowSorting="true" OnItemDataBound="RadGrid1_ItemDataBound">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                        
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                    </ClientSettings>
                    <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                        <Resizing AllowColumnResize="true" AllowRowResize="false" ResizeGridOnColumnResize="false"
                            ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                    </ClientSettings>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="JOINT_ID,REPAIR_CODE" DataSourceID="HistoryDataSource" PageSize="50" HierarchyLoadMode="Client"
                        AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed" EditMode="InPlace">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" ItemStyle-Width="20px">
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="IsoTitle1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" ReadOnly="true" AllowFiltering="true" AndCurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="50%">
                                <ItemStyle Width="140px" />
                                <HeaderStyle Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="Spool" SortExpression="SPOOL" UniqueName="SPOOL" ReadOnly="true" AllowFiltering="true" AndCurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="50%">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JOINT_NO" FilterControlAltText="Filter JOINT_NO column" HeaderText="Joint No." SortExpression="JOINT_NO" UniqueName="JOINT_NO" ReadOnly="true" AndCurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="50%">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JOINT_SIZE" FilterControlAltText="Filter JOINT_SIZE column" HeaderText="Size" SortExpression="JOINT_SIZE" UniqueName="JOINT_SIZE" ReadOnly="true" AllowFiltering="false" AndCurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />

                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REV_CODE" FilterControlAltText="Filter REV_CODE column" HeaderText="Rev Code" SortExpression="REV_CODE" UniqueName="REV_CODE" ReadOnly="true" AllowFiltering="false" AndCurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowSorting="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REPAIR_CODE" FilterControlAltText="Filter REPAIR_CODE column" HeaderText="Repair Code" SortExpression="REPAIR_CODE" UniqueName="REPAIR_CODE" ReadOnly="true" AllowFiltering="false">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="REPAIR_DATE" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter REPAIR_DATE column" HeaderText="Repair Date" SortExpression="REPAIR_DATE" UniqueName="REPAIR_DATE" AllowFiltering="false">
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="WELD_REPORT_NO" FilterControlAltText="Filter WELD_REPORT_NO column" HeaderText="WeldRepNo." SortExpression="WELD_REPORT_NO" UniqueName="WELD_REPORT_NO" FilterControlWidth="50%" AutoPostBackOnFilter="true">
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridBoundColumn>



                            <%--                        <telerik:GridTemplateColumn DataField="WPS_NO" FilterControlAltText="Filter WPS_NO column" HeaderText="WPS No." SortExpression="WPS_NO" UniqueName="WPS_NO" AllowFiltering="false" >
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="wpsDataSource" 
                                     DataTextField="WPS_NO1" DataValueField="WPS_NO1" Height="16px" 
                                     SelectedValue='<%# Bind("WPS_NO") %>' 
                                     Width="300px" AppendDataBoundItems="true">
                                    <asp:ListItem Value="" Text="Select Welder"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="WPS_NOLabel" runat="server" Text='<%# Bind("WPS_NO") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                            <telerik:GridBoundColumn DataField="WPS_NO" FilterControlAltText="Filter WPS_NO column" HeaderText="WPS_NO" SortExpression="WPS_NO" UniqueName="WPS_NO" AllowFiltering="false">
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="REPAIR_WELDER1_NO" FilterControlAltText="Filter REPAIR_WELDER1_NO column" HeaderText="Welder(1)" SortExpression="REPAIR_WELDER1_NO" UniqueName="REPAIR_WELDER1_NO" FilterControlWidth="50%">
                                <EditItemTemplate>
                                    <%--  <asp:Label ID="REPAIR_WELDER1_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER1_NO") %>'></asp:Label>--%>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="WELDER_NO" DataValueField="WELDER_ID" SelectedValue='<%# Bind("REPAIR_WELDER1_ID") %>' Width="103px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="REPAIR_WELDER1_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER1_NO") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridTemplateColumn>


                            <telerik:GridTemplateColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="REPAIR_WELDER2_NO" FilterControlAltText="Filter REPAIR_WELDER2_NO column" HeaderText="Welder(2)" SortExpression="REPAIR_WELDER2_NO" UniqueName="REPAIR_WELDER2_NO" FilterControlWidth="50%">
                                <EditItemTemplate>
                                    <%--  <asp:Label ID="REPAIR_WELDER2_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER2_NO") %>'></asp:Label>--%>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="WELDER_NO" DataValueField="WELDER_ID" SelectedValue='<%# Bind("REPAIR_WELDER2_ID") %>' Width="103px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="REPAIR_WELDER2_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER2_NO") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="REPAIR_WELDER3_NO" FilterControlAltText="Filter REPAIR_WELDER3_NO column" HeaderText="Welder(3)" SortExpression="REPAIR_WELDER3_NO" UniqueName="REPAIR_WELDER3_NO" FilterControlWidth="50%">
                                <EditItemTemplate>
                                    <%--  <asp:Label ID="REPAIR_WELDER3_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER3_NO") %>'></asp:Label>--%>
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="WELDER_NO" DataValueField="WELDER_ID" SelectedValue='<%# Bind("REPAIR_WELDER3_ID") %>' Width="103px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="REPAIR_WELDER3_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER3_NO") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="REPAIR_WELDER4_NO" FilterControlAltText="Filter REPAIR_WELDER4_NO column" HeaderText="Welder(4)" SortExpression="REPAIR_WELDER4_NO" UniqueName="REPAIR_WELDER4_NO" FilterControlWidth="50%">
                                <EditItemTemplate>
                                    <%--   <asp:Label ID="REPAIR_WELDER4_NOLabel"  runat="server" Text='<%# Bind("REPAIR_WELDER4_NO") %>'></asp:Label>--%>
                                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSource4" DataTextField="WELDER_NO" DataValueField="WELDER_ID" SelectedValue='<%# Bind("REPAIR_WELDER4_ID") %>' Width="103px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="REPAIR_WELDER4_NOLabel" runat="server" Text='<%# Bind("REPAIR_WELDER4_NO") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="NDE_REP_NO" FilterControlAltText="Filter NDE_REP_NO column" ReadOnly="true" HeaderText="RT Rep No." SortExpression="NDE_REP_NO" UniqueName="NDE_REP_NO" AllowFiltering="false" FilterControlWidth="50%" AutoPostBackOnFilter="true">
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridDateTimeColumn DataField="NDE_DATE" FilterControlAltText="Filter NDE_DATE column" ReadOnly="true" HeaderText="RT Date" SortExpression="NDE_DATE" UniqueName="NDE_DATE" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="70%" AutoPostBackOnFilter="true">
                                <ItemStyle Width="140px" />
                                <HeaderStyle Width="140px" />
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="PASS_FLG" FilterControlAltText="Filter PASS_FLG column" ReadOnly="true" HeaderText="RT Status" SortExpression="PASS_FLG" UniqueName="PASS_FLG" AllowFiltering="false">
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="Remarks" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>



        <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="RepairHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_TITLE1, SPOOL, JOINT_NO, JOINT_ID, REPAIR_CODE, CREATE_DATE, WELD_REPORT_NO, REPAIR_DATE, REPAIR_WELDER1_ID, REPAIR_WELDER2_ID, REPAIR_WELDER3_ID, REPAIR_WELDER4_ID, PASS1_ID, PASS2_ID, PASS3_ID, PASS4_ID, REPAIR_WELDER1_NO, REPAIR_WELDER2_NO, REPAIR_WELDER3_NO, REPAIR_WELDER4_NO FROM VIEW_JOINTS_REPAIR_DWR WHERE (JOINT_ID = :JOINT_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboJoints" DefaultValue="-1" Name="JOINT_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="jointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT DISTINCT ISO_ID,ISO_TITLE1||'\'||JOINT_NO||'\'||CRW_CODE JOINT_TITLE,JOINT_ID,JOINT_NO FROM VIEW_ADAPTER_NDE_STATUS WHERE ((PASS_FLG_ID = 2) AND (NDE_TYPE_ID IN (1, 12, 9,15,2)) AND (SC_ID = :SC_ID))">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>



        <asp:SqlDataSource ID="WelderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID,WELDER_NO FROM PIP_WELDERS ORDER BY WELDER_NO"></asp:SqlDataSource>

        <asp:SqlDataSource ID="dsWelderPassDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM PIP_WELDING_PASS"></asp:SqlDataSource>
        <asp:SqlDataSource ID="wpsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WPS_ID, WPS_NO1 FROM PIP_WPS_NO WHERE (PROJECT_ID = :PROJECT_ID) AND (:JOINT_SIZE_DEC BETWEEN SIZE_FROM AND SIZE_TO) AND (:JOINT_THK BETWEEN THK_FROM AND THK_TO) ORDER BY WPS_NO1">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="txtJoint_size" DefaultValue="-1" Name="JOINT_SIZE_DEC" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtJoint_thk" DefaultValue="-1" Name="JOINT_THK" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="weldersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS"></asp:SqlDataSource>
        <asp:SqlDataSource ID="RepairCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>

        <asp:ObjectDataSource ID="HistoryDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsWeldingBTableAdapters.VIEW_JOINTS_REPAIR_DTTableAdapter" UpdateMethod="UpdateQueryNew">
            <DeleteParameters>
                <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
                <asp:Parameter Name="Original_REPAIR_CODE" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="WELD_REPORT_NO" Type="String" />
                <asp:Parameter Name="REPAIR_DATE" Type="DateTime" />
                <asp:Parameter Name="REPAIR_WELDER1_ID" Type="Decimal" />
                <asp:Parameter Name="REPAIR_WELDER2_ID" Type="Decimal" />
                <asp:Parameter Name="REPAIR_WELDER3_ID" Type="Decimal" />
                <asp:Parameter Name="REPAIR_WELDER4_ID" Type="Decimal" />
                <asp:Parameter Name="REMARKS" Type="String" />
                <asp:Parameter Name="WPS_NO" Type="String" />
                <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
                <asp:Parameter Name="Original_REPAIR_CODE" Type="String" />
            </UpdateParameters>
        </asp:ObjectDataSource>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS"></asp:SqlDataSource>

        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="HiddenField2" runat="server" />
        <asp:HiddenField ID="HiddenField3" runat="server" />

    </div>

</asp:Content>
