<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard_Dashboard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .BoxHeading {
            background-color: #96E6F0;
            font-weight: bold;
            font-size: 11pt;
            padding-top: 5px;
            height: 25px;
            padding-left: 3px;
        }

        .BoxHeading1 {
            background-color: #96E6F0;
            font-weight: bold;
            font-size: 11pt;
            height: 30px;
            padding-left: 3px;
        }

        .BoxHeading2 {
            background-color: #AEDEE7;
            font-weight: bold;
            font-size: 11pt;
            padding-top: 5px;
            height: 25px;
            padding-left: 3px;
        }
    </style>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            (function (global, undefined) {
                global.OnClientSeriesClicked = function (sender, args) {
                    var ajaxManager = global.getAjaxManager();

                    if (args.get_seriesName() !== "Months") {
                        ajaxManager.ajaxRequest(args.get_category());
                    }
                }
            })(window);
            //]]>
        </script>

    </telerik:RadCodeBlock>
    <div>
        <table>
            <tr>
                <td>
                    <div class="BoxHeading">
                        Project Summary
                    </div>
                    <table>
                        <tr>
                            <td>
                                <div>
                                    <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="SqlDataSource1" Height="300px" Width="400px">
                                        <ChartTitle Text="PROJECT FABRICATION SCOPE (INCH DIA %)">
                                            <Appearance BackgroundColor="255, 255, 204" Visible="True">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance BackgroundColor="255, 255, 204" Visible="True">
                                            </Appearance>
                                        </Legend>

                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="SHOP_ID_PRCNT" Name="PieSeries1" NameField="SUB_CON_NAME" StartAngle="90">
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>

                                    </telerik:RadHtmlChart>
                                </div>
                                <div>
                                    <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource1" Width="400px" ShowFooter="true">
                                        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="FABRICATOR" SortExpression="SUB_CON_NAME"
                                                    UniqueName="SUB_CON_NAME" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SHOP_ID_SCOPE" DataFormatString="{0:N0}" DataType="System.Decimal" FooterAggregateFormatString="{0:N0}" Aggregate="Sum"
                                                    FilterControlAltText="Filter SHOP_ID_SCOPE column" HeaderText="SHOP ID SCOPE" SortExpression="SHOP_ID_SCOPE" UniqueName="SHOP_ID_SCOPE">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SHOP_ID_PRCNT" DataType="System.Decimal" FilterControlAltText="Filter SHOP_ID_PRCNT column" HeaderText="SCOPE (%)"
                                                    SortExpression="SHOP_ID_PRCNT" UniqueName="SHOP_ID_PRCNT" FooterAggregateFormatString="{0:N0}" Aggregate="Sum">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <FooterStyle Font-Bold="true" ForeColor="White" />
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                            <td style="vertical-align: top">
                                <div>
                                    <telerik:RadHtmlChart ID="RadHtmlFieldChart" runat="server" Height="300px" Width="400px" DataSourceID="SqlDataSource2">
                                        <ChartTitle Text="PROJECT ERECTION SCOPE (INCH DIA %)">
                                            <Appearance BackgroundColor="255, 255, 204">
                                            </Appearance>
                                        </ChartTitle>

                                        <Legend>
                                            <Appearance Visible="True" BackgroundColor="255, 255, 204"></Appearance>
                                        </Legend>

                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="FIELD_ID_PRCNT" Name="PieSeries1" NameField="SUB_CON_NAME" StartAngle="90">
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>

                                    </telerik:RadHtmlChart>
                                </div>
                                <div>
                                    <telerik:RadGrid ID="RadGrid2" runat="server" Width="400px" DataSourceID="SqlDataSource2" ShowFooter="true">
                                        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" FooterText="Total" HeaderText="ERECTION SUBCON" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="FIELD_ID_SCOPE" DataFormatString="{0:N0}" DataType="System.Decimal" FilterControlAltText="Filter FIELD_ID_SCOPE column"
                                                    HeaderText="FIELD ID SCOPE" SortExpression="FIELD_ID_SCOPE" UniqueName="FIELD_ID_SCOPE" FooterAggregateFormatString="{0:N0}" Aggregate="Sum">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="FIELD_ID_PRCNT" DataType="System.Decimal" FilterControlAltText="Filter FIELD_ID_PRCNT column" HeaderText="SCOPE (%)"
                                                    SortExpression="FIELD_ID_PRCNT" UniqueName="FIELD_ID_PRCNT" FooterAggregateFormatString="{0:N0}" Aggregate="Sum">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <FooterStyle Font-Bold="true" ForeColor="White" />
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="vertical-align: top">
                    <div class="BoxHeading">
                        Isometric Drawing Status
                    </div>
                    <div>
                        <telerik:RadHtmlChart ID="RadHtmlIsoStatus" runat="server" DataSourceID="sqlIsomeStatus" Height="400px" Width="500px">
                            <ClientEvents OnSeriesClick="OnClientSeriesClicked" />
                            <PlotArea>
                                <Series>
                                    <telerik:BarSeries DataFieldY="ISO_COUNT" Name="Isometric Status" Stacked="False" VisibleInLegend="false">
                                    </telerik:BarSeries>
                                </Series>
                                <XAxis DataLabelsField="ISO_STATUS">
                                    <LabelsAppearance RotationAngle="0">
                                    </LabelsAppearance>
                                </XAxis>

                            </PlotArea>

                        </telerik:RadHtmlChart>

                        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
                            <AjaxSettings>
                                <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                                    <UpdatedControls>
                                        <telerik:AjaxUpdatedControl ControlID="RadHtmlIsoStatus" LoadingPanelID="LoadingPanel1"></telerik:AjaxUpdatedControl>
                                    </UpdatedControls>
                                </telerik:AjaxSetting>
                                <telerik:AjaxSetting AjaxControlID="Refresh">
                                    <UpdatedControls>
                                        <telerik:AjaxUpdatedControl ControlID="RadHtmlIsoStatus" LoadingPanelID="LoadingPanel1"></telerik:AjaxUpdatedControl>
                                    </UpdatedControls>
                                </telerik:AjaxSetting>
                            </AjaxSettings>
                        </telerik:RadAjaxManager>
                        <telerik:RadAjaxLoadingPanel ID="LoadingPanel1" Height="77px" Width="113px" runat="server">
                        </telerik:RadAjaxLoadingPanel>
                        <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
                            <script type="text/javascript">
                                function getAjaxManager() {
                                    return $find("<%=RadAjaxManager1.ClientID%>");
                                }
                            </script>
                        </telerik:RadCodeBlock>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <div class="BoxHeading1">
                                <table style="width: 100%">
                                    <tr>
                                        <td>Fabrication Status
                                        </td>
                                        <td>
                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DynamicLayout="true">
                                                <ProgressTemplate>
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/index.progress-bar.gif" Height="25px" />
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:DropDownList ID="ddlSubconList" runat="server" Height="20px" AutoPostBack="True" DataSourceID="sqlSubconSource" AppendDataBoundItems="true"
                                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBinding="ddlSubconList_DataBinding" Width="200px"
                                                OnSelectedIndexChanged="ddlSubconList_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="text-align: right; width: 200px">
                                            <asp:RadioButtonList ID="radFabStatus" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="radFabStatus_SelectedIndexChanged"
                                                AutoPostBack="true">
                                                <asp:ListItem Selected="True" Text="Inch Dia" Value="INCH_DIA"></asp:ListItem>
                                                <asp:ListItem Text="Spool Count" Value="SPL_COUNT"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <table>

                                    <tr>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="Spoolgen Progress"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N2} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart3" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="Material Available"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N2} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart4" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="Job Card Issued"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N0} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart5" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="Welding Progress"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N0} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart6" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="NDE Progress"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N0} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart7" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="Spool Painting"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N0} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>
                                        <td>
                                            <telerik:RadHtmlChart ID="RadHtmlChart8" runat="server" Height="180px" Width="180px" Font-Size="10pt"
                                                ChartTitle-Appearance-TextStyle-FontSize="10pt">
                                                <ChartTitle Text="Sent to Site"></ChartTitle>
                                                <Appearance />
                                                <Legend>
                                                    <Appearance Position="Bottom" Visible="False"></Appearance>
                                                </Legend>
                                                <PlotArea>
                                                    <Series>
                                                        <telerik:DonutSeries DataFieldY="SCOPE_VALUE" Name="DonutSeries1" NameField="SCOPE_TEXT" StartAngle="90" HoleSize="30" ColorField="COLOR_CODE">
                                                            <LabelsAppearance DataField="SCOPE_VALUE" DataFormatString="{0:N0} %" Visible="True" Position="Center">
                                                            </LabelsAppearance>
                                                        </telerik:DonutSeries>
                                                    </Series>
                                                </PlotArea>
                                            </telerik:RadHtmlChart>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td colspan="7">
                                            <telerik:RadGrid ID="gridFabStatus" runat="server" OnItemDataBound="gridFabStatus_ItemDataBound"></telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:SqlDataSource ID="sqlFabProgress" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT (SUM(SHOP_ID_SCOPE)) AS &quot;SHOP ID SCOPE&quot;,
       SUM(SHOP_ID) AS &quot;SG SHOP ID&quot;, SUM(MAT_AVL_SHOP_ID) AS &quot;MAT AVL SHOP ID&quot;, SUM(JC_ISSUED_SHOP_ID) AS &quot;JC ISSUED SHOP ID&quot;,
       SUM(WELD_DONE_SHOP_ID) AS &quot;WELD DONE SHOP ID&quot;, SUM(NDE_DONE_SHOP_ID) AS &quot;NDE DONE SHOP ID&quot;, SUM(PAINT_CLR_SHOP_ID) AS &quot;PAINT CLR SHOP ID&quot;,
       SUM(SENT_TO_SITE) AS &quot;SENT TO SITE&quot;
FROM VIEW_FAB_STATUS_DB
"></asp:SqlDataSource>
                        </ContentTemplate>

                        <Triggers>

                            <asp:AsyncPostBackTrigger ControlID="ddlSubconList" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="radFabStatus" EventName="SelectedIndexChanged" />
                        </Triggers>

                    </asp:UpdatePanel>



                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="BoxHeading">
                        Spool / Support Installation Status
                    </div>
                    <div>
                        <table style="width: 100%">
                            <tr>
                                <td style="border: solid; border-color: #96E6F0; border-width: 1px">
                                    <div class="BoxHeading2">
                                        Spool Installation Status
                                    </div>
                                    <table>
                                        <tr>
                                            <td>Received At Site</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar1" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Installed At Site</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar2" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Site Welding</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar3" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Site NDE Done</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar4" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <telerik:RadGrid ID="RadGrid3" runat="server"></telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="border: solid; border-color: #96E6F0; border-width: 1px">
                                    <div class="BoxHeading2">
                                        Support Status
                                    </div>
                                    <table>
                                        <tr>
                                            <td>Total Support</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar5" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Installed At Site</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar6" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Site Welding</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar7" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Site NDE Done</td>
                                            <td>
                                                <div>
                                                    <telerik:RadProgressBar ID="RadProgressBar8" runat="server" MinValu="0" MaxValue="100" Value="60"
                                                        Skin="Web20" BarType="Percent">
                                                    </telerik:RadProgressBar>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_NAME, SHOP_ID_SCOPE, (SELECT Round((A.SHOP_ID_SCOPE * 100 /Sum(SHOP_ID_SCOPE)), 2) FROM VIEW_PROJ_SCOPE_DASHBOARD) AS SHOP_ID_PRCNT
FROM VIEW_PROJ_SCOPE_DASHBOARD A
WHERE SHOP_ID_SCOPE &gt; 0
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_NAME, FIELD_ID_SCOPE, (SELECT Round((A.FIELD_ID_SCOPE * 100 /Sum(FIELD_ID_SCOPE)), 2) FROM VIEW_PROJ_SCOPE_DASHBOARD) AS FIELD_ID_PRCNT
FROM VIEW_PROJ_SCOPE_DASHBOARD A
WHERE FIELD_ID_SCOPE &gt; 0
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlIsomeStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="select ISO_STATUS, ISO_COUNT from VIEW_ISO_STATUS_DASHBOARD order by status_ord"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
                        FROM SUB_CONTRACTOR
                        WHERE FAB_SC = 'Y'
                        ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSGProgress" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="SELECT 'SCOPE' AS SCOPE_TEXT, 40 AS SCOPE_VALUE, '#D6D6D6' as color_code FROM DUAL
                                                                                                                                                                                                                    UNION
                                                                                                                                                                                                                    SELECT 'COMPLETED' AS SCOPE_TEXT, 60 AS VALUE, '#4DCA5E' as color_Code FROM DUAL"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlFabProgressSC" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT shop_id_scope, shop_id, mat_avl_shop_id, jc_issued_shop_id,weld_done_shop_id, nde_done_shop_id, paint_clr_shop_id,sent_to_site FROM VIEW_FAB_STATUS_DB WHERE SUB_CON_ID = :SUB_CON_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlSubconList" DefaultValue="-1" Name="SUB_CON_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSpoolInstStatusID" runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlIsometricReceive" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM VIEW_ISOME_STATUS_DETAIL WHERE CAT = :CAT">
        <SelectParameters>
            <asp:Parameter Name="CAT" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

