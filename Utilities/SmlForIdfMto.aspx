<%@ Page Title="ISO MTO Simulation" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SmlForIdfMto.aspx.cs" Inherits="Utilities_SmlForIdfMto" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contact-area" id="divPage" runat="server">
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
        <table>
            <tr>
                <td colspan="2">
                    <asp:RadioButtonList ID="IDFselectOption" runat="server" RepeatDirection="Vertical" AutoPostBack="true" OnSelectedIndexChanged="IDFselectOption_SelectedIndexChanged">
                        <asp:ListItem Text="All Main Store" Value="ALL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Subcon Wise (PO Delivery Point)" Value="SUBCON"></asp:ListItem>
                        <asp:ListItem Text="Custom SRNs" Value="CUSTOM_SRN"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnIDFMtoSmlRun" runat="server" Text="Proceed" Font-Underline="false"
                        OnClick="btnIDFMtoSmlRun_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Font-Underline="false" Visible="false" OnClick="btnYes_Click" EnableViewState="false">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Font-Underline="false" Visible="false" EnableViewState="false">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
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
 
        <table id="gridPODlvryPoint" runat="server" visible="false">
            <tr style="vertical-align: top;">
                <td>
                    <asp:Label Text="Registered PO Delivery Points" runat="server" Font-Bold="true"></asp:Label>
                    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" Width="600px"
                        CssClass="DataWebControlStyle" DataSourceID="dsPODelvryPoint" PageSize="15" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                        DataKeyNames="DEL_POINT">
                        <ClientSettings>
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
                        <MasterTableView DataSourceID="dsPODelvryPoint" DataKeyNames="DEL_POINT" EditMode="InPlace">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                    <ItemStyle CssClass="MyImageButton" Width="10px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn HeaderText="Delivery Point" SortExpression="DEL_POINT" ReadOnly="true">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("DEL_POINT") %>' Width="50px"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("DEL_POINT") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Subcon Name" SortExpression="SUB_CON_NAME">
                                    <EditItemTemplate>
                                        <telerik:RadDropDownList ID="ddSubconlists" runat="server" SelectedValue='<%# Bind("DEL_POINT_SC_ID") %>'
                                            Width="120px" DataSourceID="subconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" AppendDataBoundItems="true">
                                            <Items>
                                                <telerik:DropDownListItem />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
                <td>
                    <asp:Label Text="Un-Registered PO Delivery Points" runat="server" Font-Bold="true"></asp:Label>
                    <telerik:RadGrid ID="RadGrid2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="dsUnregdDelvryPoint"
                        MasterTableView-AllowPaging="true" ClientDataKeyNames="DEL_POINT" CellSpacing="-1" MasterTableView-EditMode="InPlace" AllowAutomaticUpdates="true" MasterTableView-DataKeyNames="DEL_POINT">
                        <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                        <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                            <Selecting AllowRowSelect="True" />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                        </ClientSettings>
                        <MasterTableView AllowAutomaticUpdates="false" ClientDataKeyNames="DEL_POINT" DataKeyNames="DEL_POINT" DataSourceID="dsUnregdDelvryPoint" HierarchyLoadMode="Client" PageSize="15"
                            PagerStyle-ShowPagerText="false" AllowPaging="true">
                            <Columns>
                                <telerik:GridBoundColumn DataField="DEL_POINT" FilterControlAltText="Filter DEL_POINT column" HeaderText="Delivery Point" SortExpression="DEL_POINT" UniqueName="DEL_POINT">
                                </telerik:GridBoundColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                            <PagerStyle ShowPagerText="False" />
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
                <td>
                    <asp:Label Text="Register" runat="server" Font-Bold="true"></asp:Label>
                    <telerik:RadDropDownList runat="server" ID="ddSubcon" DataSourceID="subconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" ExpandDirection="Down" AppendDataBoundItems="true">
                        <Items>
                            <telerik:DropDownListItem Value="" Text="Select a Subcon" Selected="true" />
                        </Items>
                    </telerik:RadDropDownList>
                    <telerik:RadButton ID="btnSave" OnClick="btnSave_Click" runat="server" Text="Save"></telerik:RadButton>
                    <br />
                    <asp:Label ID="lblRegisterMessage" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:ObjectDataSource ID="dsPODelvryPoint" runat="server" SelectMethod="GetData"
            TypeName="dsGeneralBTableAdapters.PO_DELIVERY_POINTTableAdapter" OldValuesParameterFormatString="{0}"
            UpdateMethod="UpdateQuery">
            <UpdateParameters>
                <asp:Parameter Name="DEL_POINT_SC_ID" Type="Decimal" />
                <asp:Parameter Name="DEL_POINT" Type="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                    Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:SqlDataSource ID="dsUnregdDelvryPoint" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT    DISTINCT    DEL_POINT FROM            PIP_PO_SPLIT_DETAIL WHERE        (DEL_POINT IS NOT NULL) AND (NOT EXISTS
                             (SELECT        NULL AS EXPR1
                               FROM            PO_DELIVERY_POINT
                               WHERE        (DEL_POINT = PIP_PO_SPLIT_DETAIL.DEL_POINT)))"></asp:SqlDataSource>
        <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID,SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsSmlProgress" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM TBL_PACKAGE_TRACKER WHERE PACKAGE_NAME='IDF_MTO_SIMULATION' ORDER BY ACTIVITY_ID">           
                </asp:SqlDataSource>
        <asp:Label ClientIDMode="AutoID" runat="server" ID="lblMessage" ForeColor="Green" EnableViewState="false" Text="" Height="10px" Width="100%"></asp:Label>
    </div>
</asp:Content>

