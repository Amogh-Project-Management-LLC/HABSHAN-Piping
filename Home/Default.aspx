<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="ipms_Home" Title="Home" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .simple_div {
            width: 400px;
            padding: 5px;
            background-color: whitesmoke;
            margin: 3px;
            border-radius: 5px;
            border-color: gainsboro;
            border-style: solid;
            border-width: medium;
        }
    </style>
    <script>
        var $ = $telerik.$;

      <%--  function exportRadHtmlChart() {
            $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadHtmlChart"));
        }--%>

    </script>

    <table style="width: 100%;">
        <tr runat="server" visible="false" id="StatusRow">
            <td>
                <div class="simple_div">
                    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                </div>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top;">
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="5" Width="1000px">
                    <Tabs>
                      <%--  <telerik:RadTab Text="Monthly Planned Vs Actual EPIC" Selected="True"></telerik:RadTab>--%>
                        <%--<telerik:RadTab Text="Monthly Planned Vs Actual" Selected="True"></telerik:RadTab>--%>
                        <telerik:RadTab Text="Piping Fabrication charts"></telerik:RadTab>
                        <telerik:RadTab Text="Piping Fabrication Status"></telerik:RadTab>
                        <telerik:RadTab Text="Isometric Status"></telerik:RadTab>
                        <telerik:RadTab Text="Welding Inch Dia"></telerik:RadTab>
                        <telerik:RadTab Text="Spool Status" Visible="false"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                  <%--  <telerik:RadPageView ID="RadPageView7" runat="server">
                        <div style="padding: 5px; text-align: center;">
                           <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1_EPIC" Width="1000px" Height="500px" RegisterWithScriptManager="true">
                                        <PlotArea>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="PL_ISO_CNT" Name="Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}">
                                                    </LabelsAppearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="RECV_ISO_COUNT" Name="Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}">
                                                    </LabelsAppearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                            </Series>
                                            <XAxis DataLabelsField="MONTH">
                                                <LabelsAppearance></LabelsAppearance>
                                                <MajorGridLines Visible="false"></MajorGridLines>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <TitleAppearance Text="Month-Year"></TitleAppearance>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Isometric Count/InchDia"></TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                            </YAxis>
                                        </PlotArea>
                                        <ChartTitle Text="">
                                            <Appearance Align="Left" Position="Top"></Appearance>
                                        </ChartTitle>
                                    </telerik:RadHtmlChart>
                        </div>
                    </telerik:RadPageView>--%>

                    <%--<telerik:RadPageView ID="RadPageView6" runat="server" >  
                        <div style="padding: 5px; text-align: center;">
                            <asp:Label ID="lblTitle" Text="Isometric Planned Vs Actual" runat="server" Font-Bold="true"></asp:Label><br />
                        </div>
                        <table>
                            <tr>
                                <td style="text-align: left; width: 100%">
                                    <asp:RadioButtonList ID="rdoCountOrInchdia" runat="server" OnSelectedIndexChanged="rdoCountOrInchdia_SelectedIndexChanged"
                                        RepeatDirection="Horizontal" AutoPostBack="true">
                                        <asp:ListItem Selected="True" Value="COUNT" Text="Count"></asp:ListItem>
                                        <asp:ListItem Value="ID" Text="InchDia"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnExportPlannedVsActual" Text="Export Data to Excel" runat="server" OnClick="btnExportPlannedVsActual_Click"></telerik:RadButton>
                                    <telerik:RadButton RenderMode="Lightweight" runat="server" OnClientClicked="exportRadHtmlChart" Text="Export Chart to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
                                    <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
                                    </telerik:RadClientExportManager>
                                    <telerik:RadHtmlChart runat="server" ID="PieChart5" Width="1000px" Height="500px" RegisterWithScriptManager="true">
                                        <PlotArea>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="PL_ISO_CNT" Name="Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}">
                                                    </LabelsAppearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="RECV_ISO_COUNT" Name="Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}">
                                                    </LabelsAppearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                            </Series>
                                            <XAxis DataLabelsField="MONTH">
                                                <LabelsAppearance></LabelsAppearance>
                                                <MajorGridLines Visible="false"></MajorGridLines>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <TitleAppearance Text="Month-Year"></TitleAppearance>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Isometric Count/InchDia"></TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                            </YAxis>
                                        </PlotArea>
                                        <ChartTitle Text="">
                                            <Appearance Align="Left" Position="Top"></Appearance>
                                        </ChartTitle>
                                    </telerik:RadHtmlChart>
                                    <div>
                                        <telerik:RadHtmlChart runat="server" ID="PieChart6" Width="1000px" Height="500px" Visible="false">
                                            <PlotArea>
                                                <Series>
                                                    <telerik:ColumnSeries DataFieldY="PL_INCH_DIA" Name="Planned Inchdia">
                                                        <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}">
                                                        </LabelsAppearance>
                                                        <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="RECV_INCH_DIA" Name="Actual Inchdia">
                                                        <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}">
                                                        </LabelsAppearance>
                                                        <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                    </telerik:ColumnSeries>
                                                </Series>
                                                <XAxis DataLabelsField="MONTH">
                                                    <LabelsAppearance></LabelsAppearance>
                                                    <MajorGridLines Visible="false"></MajorGridLines>
                                                    <MinorGridLines Visible="false"></MinorGridLines>
                                                    <TitleAppearance Text="Month-Year"></TitleAppearance>
                                                </XAxis>
                                                <YAxis>
                                                    <TitleAppearance Text="Isometric Count/InchDia"></TitleAppearance>
                                                    <MinorGridLines Visible="false"></MinorGridLines>
                                                </YAxis>
                                            </PlotArea>
                                            <ChartTitle Text="">
                                                <Appearance Align="Left" Position="Top"></Appearance>
                                            </ChartTitle>
                                        </telerik:RadHtmlChart>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>--%>

                    <telerik:RadPageView ID="RadPageView5" runat="server">
                        <div style="padding: 5px">
                            <telerik:RadLabel ID="MileStone" Text="Milestone" runat="server"></telerik:RadLabel>
                            <telerik:RadComboBox runat="server" ID="ddlMilestone" DataSourceID="MilestoneDataSource" DataTextField="MILESTONE" DataValueField="MILESTONE" AutoPostBack="true"
                                CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Filter="Contains" OnSelectedIndexChanged="ddlMilestone_SelectedIndexChanged">
                            </telerik:RadComboBox>

                            <telerik:RadLabel ID="AreaPriority" Text="Area Priority" runat="server"></telerik:RadLabel>
                            <telerik:RadComboBox runat="server" ID="ddlPriority" DataTextField="AREA_PRIORITY" DataValueField="AREA_PRIORITY" AutoPostBack="true"
                                CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Filter="Contains" OnSelectedIndexChanged="ddlPriority_SelectedIndexChanged">
                            </telerik:RadComboBox>

                            <telerik:RadLabel ID="Area" Text="Area" runat="server"></telerik:RadLabel>
                            <telerik:RadComboBox runat="server" ID="ddlArea" DataTextField="AREA" DataValueField="AREA" AutoPostBack="true"
                                CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Filter="Contains" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <telerik:RadButton ID="btnRefresh" Text="Refresh" runat="server" OnClick="btnRefresh_Click"></telerik:RadButton>
                        </div>
                        <table>
                            <tr>
                                <td style="text-align: center;">
                                    <telerik:RadHtmlChart runat="server" ID="PieChart1" Width="550" Height="300" Transitions="true">
                                        <ChartTitle Text="Isometric Sheet Status">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="220" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" ColorField="COLOR" NameField="LABEL">
                                                    <LabelsAppearance DataFormatString="{0:N0}" Position="Center"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                    <asp:Label ID="lblIsomeShtStatus" runat="server" Text="<u>Total Scope</u> : " Font-Size="Medium"></asp:Label>
                                </td>
                                <td style="text-align: center;">
                                    <telerik:RadHtmlChart runat="server" ID="PieChart2" Width="550" Height="300" Transitions="true">
                                        <ChartTitle Text="Inch Dia Status">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="220" Visible="true" Orientation="Vertical">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" ColorField="COLOR" NameField="LABEL">
                                                    <LabelsAppearance DataFormatString="{0:N0}" Position="Center"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                    <asp:Label ID="lblInchDiaStatus" runat="server" Text="<u>Total Scope</u> : " Font-Size="Medium"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align: center;">
                                    <telerik:RadHtmlChart runat="server" ID="PieChart3" Width="550" Height="300" Transitions="true">
                                        <ChartTitle Text="Fabricatable Material Available Status">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" ColorField="COLOR"
                                                    NameField="LABEL">
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                    <asp:Label ID="lblFabMatStatus" runat="server" Text="<u>Total Scope</u> : " Font-Size="Medium"></asp:Label>
                                </td>
                                <td style="text-align: center;">
                                    <%--<telerik:RadHtmlChart runat="server" ID="PieChart4" Width="550" Height="300" Transitions="true">
                                        <ChartTitle Text="Spool Fabrication Status">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" ColorField="COLOR" NameField="LABEL">
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                    <asp:Label ID="lblSplFabStatus" runat="server" Text="<u>Total Scope</u> : " Font-Size="Medium"></asp:Label>--%>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align: center;">
                                    <%--<telerik:RadHtmlChart runat="server" ID="DivWiseScope1" Width="550" Height="300" Transitions="true">
                                        <ChartTitle Text="Division Wise [Fabrication scope v/s Spoolgen completed]">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" NameField="SUBCON_FIELD">
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                    <asp:Label ID="lblDivWiseStatus" runat="server" Text="<u>Total Scope</u> : " Font-Size="Medium"></asp:Label>--%>
                                </td>
                                <td style="text-align: center;">
                                    <%--<telerik:RadHtmlChart runat="server" ID="DivWiseScope2" Width="550" Height="300" Transitions="true">
                                        <ChartTitle Text="Division Wise [Fabrication scope v/s Fabrication completed]">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" NameField="SUBCON_FIELD">
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                    <asp:Label ID="lblDivWiseStatus2" runat="server" Text="<u>Total Scope</u> : " Font-Size="Medium"></asp:Label>--%>
                                </td>
                            </tr>
                        </table>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="RadPageView4" runat="server">
                        <telerik:RadChart ID="RadChart4" runat="server" DataSourceID="sqlPipingFabStatus" Skin="LightBlue" DefaultType="Bar"
                            Width="1000px" Height="500px">
                            <ChartTitle TextBlock-Text="<%$Resources:PageLabels, InchDiaStatus%>">
                            </ChartTitle>
                            <Series>
                                <telerik:ChartSeries DataYColumn="TOTAL_SCOPE_ID" Name="01 Estimated Scope ID" />
                                <telerik:ChartSeries DataYColumn="SCOPE_ID" Name="02 Estimated Fab Scope ID" />
                                <telerik:ChartSeries DataYColumn="SPOOLGEN_ID" Name="03 Spoolgen ID" />
                                <telerik:ChartSeries DataYColumn="FABRICATION_COMPLTED_ID" Name="04 Fabrication Completed ID" />
                            </Series>
                        </telerik:RadChart>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="RadPageView3" runat="server">
                        <telerik:RadChart ID="RadChart3" runat="server" DataSourceID="sqlIsomeStatus" Skin="LightBlue" DefaultType="Bar"
                            Width="1000px" Height="500px">
                            <ChartTitle TextBlock-Text="<%$Resources:PageLabels, IsometricStatus%>">
                            </ChartTitle>
                            <Series>
                                <telerik:ChartSeries DataYColumn="TOTAL_ISOMETRIC" Name="01 Total Isometric Scope" />
                                <telerik:ChartSeries DataYColumn="ISOMETRIC_RECEIVED" Name="02 Received" />
                                <telerik:ChartSeries DataYColumn="MARKING_DONE" Name="03 Marking Done" />
                                <telerik:ChartSeries DataYColumn="SG_DONE" Name="04 Spoolgen Done" />
                                <telerik:ChartSeries DataYColumn="MAT_CHECK_DONE" Name="05 Material Check" />
                                <telerik:ChartSeries DataYColumn="ON_HOLD" Name="06 On Hold" />
                                <telerik:ChartSeries DataYColumn="VOID_DELETED" Name="07 Void/Deleted" />
                            </Series>
                        </telerik:RadChart>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="RadPageView1" runat="server">
                        <telerik:RadChart ID="RadChart1" runat="server" DataSourceID="WeldingSqlDataSource" Skin="LightBlue" DefaultType="Bar"
                            OnItemDataBound="RadChart1_ItemDataBound" Width="1000px" Height="500px">
                            <ChartTitle TextBlock-Text="<%$Resources:PageLabels, WeldingInchDia%>">
                            </ChartTitle>
                            <Series>
                                <telerik:ChartSeries DataYColumn="FIELD_ID" Name="01 Field Inch Dia" />
                                <telerik:ChartSeries DataYColumn="SHOP_ID" Name="02 Shop Inch Dia" />
                                <telerik:ChartSeries DataYColumn="AVL_SHOP_ID" Name="03 Avail Shop ID" />
                                <telerik:ChartSeries DataYColumn="SHOP_FITUP" Name="04 Shop Fitup">
                                </telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="SHOP_WELDING" Name="05 Shop Welding">
                                </telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="FIELD_FITUP" Name="06 Field Fitup">
                                </telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="FIELD_WELDING" Name="07 Field Welding">
                                </telerik:ChartSeries>
                            </Series>
                        </telerik:RadChart>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="RadPageView2" runat="server" Visible="false">
                        <telerik:RadChart ID="RadChart2" runat="server" DataSourceID="SpoolInstallSqlDataSource" Skin="LightBlue" DefaultType="Bar"
                            OnItemDataBound="RadChart2_ItemDataBound" Width="1000" Height="500" AutoTextWrap="false">
                            <ChartTitle TextBlock-Text="<%$Resources:PageLabels, SpoolStatusByCountSpls%>"></ChartTitle>
                            <Series>
                                <telerik:ChartSeries DataYColumn="TOTAL_SPL" Name="Total Spools"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="FAB_MAT_AVL" Name="Material Available"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="SPL_FAB_JC" Name="Fab Jobcard"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="SHOP_WELDING" Name="Shop Welding"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="PACKING_LIST" Name="Packing List"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="RECVD_SITE" Name="Received at Site"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="SITE_EREC" Name="Installed"></telerik:ChartSeries>
                                <telerik:ChartSeries DataYColumn="SITE_WELDING" Name="Site Welding"></telerik:ChartSeries>
                            </Series>
                        </telerik:RadChart>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
        <tr runat="server" visible="false" id="FataRow">
            <td>
                <telerik:RadButton ID="btnItemCode" runat="server" Text="FATA Item Code" Width="120" OnClick="btnItemCode_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="WeldingSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PROJ_ID, FIELD_ID, SHOP_ID, AVL_SHOP_ID, SHOP_FITUP, SHOP_WELDING, FIELD_FITUP, FIELD_WELDING FROM VIEW_DASH_BOARD_INCH_DIA WHERE (PROJ_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SpoolInstallSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PROJECT_ID, TOTAL_SPL, FAB_MAT_AVL, SPL_FAB_JC, SHOP_WELDING, PACKING_LIST, RECVD_SITE, SITE_EREC, SITE_WELDING FROM VIEW_DASH_BOARD_SPL_INSTALL WHERE (PROJECT_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlIsomeStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>" SelectCommand="select TOTAL_ISOMETRIC, ISOMETRIC_RECEIVED, MARKING_DONE, SG_DONE,MAT_CHECK_DONE, ON_HOLD, VOID_DELETED from VIEW_ISOMETRIC_DASHBOARD"></asp:SqlDataSource>

    <asp:SqlDataSource ID="MilestoneDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="select Distinct milestone from view_piping_dpr_rdlc order by milestone"></asp:SqlDataSource>

    <asp:SqlDataSource ID="PriorityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="select Distinct area_priority from view_piping_dpr_rdlc order by area_priority"></asp:SqlDataSource>

    <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="select Distinct AREA_L2 AS AREA from view_piping_dpr_rdlc order by area_l2"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="select sub_con_name,sub_con_id from sub_contractor"></asp:SqlDataSource>


    <asp:SqlDataSource ID="sqlPipingFabStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  Sum(total_scope_id)total_scope_id,Sum(scope_id)scope_id,Sum(spoolgen_id)spoolgen_id,Sum(fabrication_complted_id)fabrication_complted_id
                         FROM view_piping_dpr_rdlc"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlIsomeSheetStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT COLOR,LABEL,Sum(CNT) as cnt FROM VIEW_ISO_SHT_STATUS_DASHBOARD GROUP BY color,LABEL,ORD ORDER BY ORD"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlInchDiaStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT COLOR,LABEL,Sum(CNT) as cnt FROM VIEW_INCH_DIA_DASHBOARD GROUP BY color,LABEL,ORD ORDER BY ORD"></asp:SqlDataSource>

    <asp:SqlDataSource ID="FabMatAvlStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT COLOR,LABEL,Sum(CNT) as cnt FROM VIEW_FAB_INCH_DIA_DASHBOARD GROUP BY color,LABEL,ORD ORDER BY ORD"></asp:SqlDataSource>

    <asp:SqlDataSource ID="DivWiseMatAvlStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT Nvl(subcon_field,'UNDEFINED') subcon_field,Sum(CNT) as cnt FROM view_fab_inch_dia_dashboard GROUP BY Nvl(subcon_field,'UNDEFINED')"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SpoolFabStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ord,label,Sum(CNT) as cnt FROM VIEW_SPOOLS_DASHBOARD GROUP BY label,ord order by ord"></asp:SqlDataSource>

    <asp:SqlDataSource ID="DivWiseSplStatus" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT subcon_field,Sum(CNT) as cnt FROM VIEW_SPOOLS_DASHBOARD GROUP BY subcon_field"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsISOPlanningReport" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_ISO_PLANNING_REP ORDER BY yymm asc"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsISOPlanningReport_EPIC" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_ISO_PLANNING_REP_EPIC ORDER BY yymm asc"></asp:SqlDataSource>
</asp:Content>
