<%@ Page Title="View Reports" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewReports.aspx.cs" Inherits="Home_ViewReports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .fontClass {
            font-weight: 500;
            font-size: medium;
            color: black
        }
    </style>

    <div class="right_content">

        <%--  <div class="menu-div">
            <telerik:RadMenu ID="HeaderMenu" Style="z-index: 2900" runat="server" OnItemClick="HeaderMenu_ItemClick" Skin="Office2010Blue" Width="100%">
                <Items>
                    <telerik:RadMenuItem Text="Back" Value="back" ImageUrl="~/App_Themes/BlueTheme/images/icons/back_menu.png"></telerik:RadMenuItem>
                </Items>
            </telerik:RadMenu>
        </div>--%>

        <div class="menu-div">
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="txtSearch" runat="server" Width="150px" BackColor="#ffffcc" BorderColor="#99CCFF"
                            BorderWidth="1px" Height="21px" AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlIsome" runat="server" Height="21px" BackColor="#FFFFCC" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_ID" OnDataBinding="ddlIsome_DataBinding"></asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSpool" runat="server" Height="21px" BackColor="#FFFFCC" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlSpolSource" DataTextField="SPOOL" DataValueField="SPL_ID" OnDataBinding="ddlSpool_DataBinding"></asp:DropDownList>
                    </td>
                    <%-- <td>
                        <asp:DropDownList ID="ddlJoint" runat="server" Height="21px" BackColor="#FFFFCC" AppendDataBoundItems="True" DataSourceID="sqlJointsSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID" OnDataBinding="ddlJoint_DataBinding"  AutoPostBack="true"></asp:DropDownList>
                    </td>--%>
                    <td>
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                            AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                            <asp:ListItem Value="1">Spool Reports</asp:ListItem>
                            <asp:ListItem Value="2">Joint Reports</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="splView" runat="server">

                    <h3>Spool Reports</h3>
                    <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Office2007" DataSourceID="ReportSource" CellSpacing="-1" GridLines="Both" OnItemDataBound="RadGrid1_ItemDataBound" OnPreRender="RadGrid1_PreRender">
                        <GroupingSettings ShowUnGroupButton="True" />
                        <MasterTableView AutoGenerateColumns="False" DataSourceID="ReportSource">
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>

                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <GroupByExpressions>
                                <telerik:GridGroupByExpression>
                                    <SelectFields>
                                        <telerik:GridGroupByField FieldName="REPORT_TYPE" HeaderText="REPORT_TYPE" />
                                    </SelectFields>
                                    <GroupByFields>
                                        <telerik:GridGroupByField FieldName="REPORT_TYPE" />
                                    </GroupByFields>
                                </telerik:GridGroupByExpression>
                            </GroupByExpressions>
                            <Columns>
                                 <telerik:GridBoundColumn DataField="SHOP_SUB_CON" FilterControlAltText="Filter SHOP_SUB_CON column" HeaderText="SHOP SUBCON" SortExpression="SHOP_SUB_CON" UniqueName="SHOP_SUB_CON">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FIELD_SUB_CON" FilterControlAltText="Filter FIELD_SUB_CON column" HeaderText="FIELD SUBCON" SortExpression="FIELD_SUB_CON" UniqueName="FIELD_SUB_CON">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO_TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="REPORT_NO" FilterControlAltText="Filter REPORT_NO column" HeaderText="REPORT_NO" SortExpression="REPORT_NO" UniqueName="REPORT_NO">
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="FILE_LINK1" FilterControlAltText="Filter FILE_LINK1 column" HeaderText="FILELINK" SortExpression="FILE_LINK1" UniqueName="FILE_LINK1" >
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FILE_PATH" FilterControlAltText="Filter FILE_PATH column" HeaderText="FILEPATH" SortExpression="FILE_PATH" UniqueName="FILE_PATH" >
                                </telerik:GridBoundColumn>
                                 <telerik:GridTemplateColumn EnableHeaderContextMenu="false">
                                    <ItemTemplate>
                                        <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="35px" />
                                    <HeaderStyle Width="35px" />
                                </telerik:GridTemplateColumn>
                            </Columns>

                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                            </EditFormSettings>
                        </MasterTableView>

                        <FilterMenu EnableImageSprites="False"></FilterMenu>
                    </telerik:RadGrid>
                </asp:View>
                <asp:View ID="jointView" runat="server">

                    <h3>Joint Reports</h3>
                    <telerik:RadGrid ID="RadGrid2" runat="server" DataSourceID="joinReportSource" Skin="Office2007" CellSpacing="-1" GridLines="Both" OnItemDataBound="RadGrid2_ItemDataBound" OnPreRender="RadGrid2_PreRender">
                        <GroupingSettings ShowUnGroupButton="True" />
                        <MasterTableView  AutoGenerateColumns="False" DataSourceID="joinReportSource" >
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>

                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <GroupByExpressions>
                                <telerik:GridGroupByExpression>
                                    <SelectFields>
                                        <telerik:GridGroupByField FieldName="REPORT_TYPE" HeaderText="REPORT_TYPE" />
                                    </SelectFields>
                                    <GroupByFields>
                                        <telerik:GridGroupByField FieldName="SORT_ORDER" SortOrder="Ascending" />
                                        <telerik:GridGroupByField FieldName="REPORT_TYPE"/>                                     
                                    </GroupByFields>
                                </telerik:GridGroupByExpression>
                            </GroupByExpressions>
                            <Columns>
                                <telerik:GridBoundColumn DataField="SHOP_SUB_CON" FilterControlAltText="Filter SHOP_SUB_CON column" HeaderText="SHOP SUBCON" SortExpression="SHOP_SUB_CON" UniqueName="SHOP_SUB_CON">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FIELD_SUB_CON" FilterControlAltText="Filter FIELD_SUB_CON column" HeaderText="FIELD SUBCON" SortExpression="FIELD_SUB_CON" UniqueName="FIELD_SUB_CON">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO_TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JOINT_NO" FilterControlAltText="Filter JOINT_NO column" HeaderText="JOINT_NO" SortExpression="JOINT_NO" UniqueName="JOINT_NO">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="REPORT_NO" FilterControlAltText="Filter REPORT_NO column" HeaderText="REPORT_NO" SortExpression="REPORT_NO" UniqueName="REPORT_NO">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FILE_LINK1" FilterControlAltText="Filter FILE_LINK1 column" HeaderText="FILELINK" SortExpression="FILE_LINK1" UniqueName="FILE_LINK1"  >
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FILE_PATH" FilterControlAltText="Filter FILE_PATH column" HeaderText="FILEPATH" SortExpression="FILE_PATH" UniqueName="FILE_PATH" >
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn EnableHeaderContextMenu="false">
                                    <ItemTemplate>
                                        <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="35px" />
                                    <HeaderStyle Width="35px" />
                                </telerik:GridTemplateColumn>
                            </Columns>

                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                            </EditFormSettings>
                        </MasterTableView>

                        <FilterMenu EnableImageSprites="False"></FilterMenu>
                    </telerik:RadGrid>
                </asp:View>
            </asp:MultiView>
        </div>

        <asp:SqlDataSource ID="ReportSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *FROM VIEW_SPOOL_PDF_REPORT WHERE (ISO_ID = :ISO_ID) AND (SPL_ID = :SPL_ID OR :SPL_ID = - 99)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlIsome" DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlSpool" DefaultValue="-99" Name="SPL_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="joinReportSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_JOINT_PDF_REPORT WHERE (ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1)) AND (SPL_ID = :SPL_ID OR :SPL_ID = - 99) ORDER BY SORT_ORDER">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlSpool" DefaultValue="-99" Name="SPL_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_TITLE1, ISO_ID FROM PIP_ISOMETRIC WHERE (ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLEL1)) ORDER BY ISO_TITLE1">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="ISO_TITLEL1" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlSpolSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPOOL FROM PIP_SPOOL WHERE (ISO_ID = :ISO_ID) ORDER BY SPOOL">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlIsome" DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlJointsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_NO || REPLACE (CRW_CODE, '-', '') AS JOINT_TITLE, JOINT_ID FROM PIP_SPOOL_JOINTS WHERE (SPL_ID = :SPL_ID) ORDER BY JOINT_NO || CRW_CODE">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSpool" DefaultValue="-1" Name="SPL_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>


</asp:Content>

