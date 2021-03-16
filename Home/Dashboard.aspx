<%@ Page Title="Amogh Dashboard" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard_Dashboard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .BoxHeading {
            font-weight: bold;
            font-size: 15pt;
            padding-top: 5px;
            height: 40px;
            padding-left: 3px;
            text-align: center;
            color: #2a33a5;
        }

        .BoxHeading1 {
            background-color: #2a33a5;
            font-weight: bold;
            font-size: 12pt;
            padding-top: 3px;
            height: 30px;
            padding-left: 3px;
            color: white;
            text-align: center;
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
    <%--  <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
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

    </telerik:RadCodeBlock>--%>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            var $ = $telerik.$;
            function exportPDF() {
                $find('<%=RadClientExportManager1.ClientID%>').exportPDF($("#divexport"));
            }

            function exportPDF2() {
                $find('<%=RadClientExportManager1.ClientID%>').exportPDF($("#divexport2"));
            }
            //<![CDATA[
            (function (global, undefined) {
                global.OnClientSeriesClicked = function (sender, args) {
                    var ajaxManager = global.getAjaxManager();

                    if (args.get_seriesName() !== "Months") {
                        ajaxManager.ajaxRequest(args.get_category());
                    }
                }
            })(window);

        </script>

    </telerik:RadCodeBlock>
    <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
            <ImageSettings Height="1500px" Width="950px" FileName="Chart.png" />
    </telerik:RadClientExportManager>



    <telerik:RadButton RenderMode="Lightweight" runat="server" OnClientClicked="exportPDF" Text="Export Dashboard 1 to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
    <telerik:RadButton RenderMode="Lightweight" runat="server" OnClientClicked="exportPDF2" Text="Export Dashboard 2 to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
    <telerik:RadButton runat="server" ID="btnShow" Text="Show" OnClick="btnShow_Click"></telerik:RadButton>
    <telerik:RadButton runat="server" ID="btnHide" Text="Hide" OnClick="btnHide_Click"></telerik:RadButton>
    <div id="divexport2" style="border: solid">
        <%-- <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td colspan="4">
                                <telerik:RadGrid ID="RadGrid4" runat="server" CellSpacing="-1" DataSourceID="ISOStatusDataSourcedb2" Width="1200px"
                                    Font-Size="Larger" GroupHeaderItemStyle-Font-Size="Larger" GroupHeaderItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="ISOStatusDataSourcedb2">
                                        <AlternatingItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="SNO" FilterControlAltText="Filter SNO column" HeaderText="SNO" SortExpression="SNO" UniqueName="SNO">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="LABEL" FilterControlAltText="Filter LABEL column" HeaderText="LABEL" SortExpression="LABEL" UniqueName="LABEL">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PROGRESS" FilterControlAltText="Filter PROGRESS column" HeaderText="PROGRESS" SortExpression="PROGRESS" UniqueName="PROGRESS">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart5" Width="300" Height="200" Transitions="true" DataSourceID="ISOStatusDataSourcedb2_1">
                                    <ChartTitle Text="ISOMETRIC SHEET STATUS">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart6" Width="300" Height="200" Transitions="true" DataSourceID="ISOStatusDataSourcedb2_2">
                                    <ChartTitle Text="SHEET RECEIVED BY EPIC">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart7" Width="300" Height="200" Transitions="true" DataSourceID="ISOStatusDataSourcedb2_3">
                                    <ChartTitle Text="ISOMETRIC SPOOLED BY EPIC">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart8" Width="300" Height="200" Transitions="true" DataSourceID="ISOStatusDataSourcedb2_4">
                                    <ChartTitle Text="SPOOLGEN BALANCE BY EPIC">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td>
                    <table>
                        <tr>
                            <td colspan="4">
                                <telerik:RadGrid ID="RadGrid5" runat="server" CellSpacing="-1" DataSourceID="MatStatusDataSourcedb2" Width="1200px"
                                    Font-Size="Larger" GroupHeaderItemStyle-Font-Size="Larger" GroupHeaderItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="MatStatusDataSourcedb2">
                                        <AlternatingItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="SNO" FilterControlAltText="Filter SNO column" HeaderText="SNO" SortExpression="SNO" UniqueName="SNO">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="LABEL" FilterControlAltText="Filter LABEL column" HeaderText="LABEL" SortExpression="LABEL" UniqueName="LABEL">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PROGRESS" FilterControlAltText="Filter PROGRESS column" HeaderText="PROGRESS" SortExpression="PROGRESS" UniqueName="PROGRESS">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart9" Width="300" Height="200" Transitions="true" DataSourceID="MatStatusDataSourcedb2_1">
                                    <ChartTitle Text="100% MATCHED ID">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart10" Width="300" Height="200" Transitions="true" DataSourceID="MatStatusDataSourcedb2_2">
                                    <ChartTitle Text="100% MATCHED MATERIAL STATUS">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td>
                    <table>
                        <tr>
                            <td colspan="4">
                                <telerik:RadGrid ID="RadGrid6" runat="server" CellSpacing="-1" DataSourceID="WFStatusDataSourcedb2" Width="1200px"
                                    Font-Size="Larger" GroupHeaderItemStyle-Font-Size="Larger" GroupHeaderItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                    <MasterTableView AutoGenerateColumns="False" DataSourceID="WFStatusDataSourcedb2">
                                        <AlternatingItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="SNO" FilterControlAltText="Filter SNO column" HeaderText="SNO" SortExpression="SNO" UniqueName="SNO">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="LABEL" FilterControlAltText="Filter LABEL column" HeaderText="LABEL" SortExpression="LABEL" UniqueName="LABEL">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PROGRESS" FilterControlAltText="Filter PROGRESS column" HeaderText="PROGRESS" SortExpression="PROGRESS" UniqueName="PROGRESS">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart11" Width="300" Height="200" Transitions="true" DataSourceID="WFStatusDataSourcedb2_1">
                                    <ChartTitle Text="100% MATCHED ISO SHEET STATUS">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart12" Width="300" Height="200" Transitions="true" DataSourceID="WFStatusDataSourcedb2_2">
                                    <ChartTitle Text="100% MATERIAL MATCHED AVAILABLE IN EPIC">
                                        <Appearance Align="Center" Position="Top">
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                        </Appearance>
                                    </Legend>
                                    <PlotArea>
                                        <Series>
                                            <telerik:PieSeries DataFieldY="STATUS" NameField="LABEL">
                                                <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:PieSeries>
                                        </Series>
                                    </PlotArea>
                                </telerik:RadHtmlChart>
                            </td>

                        </tr>
                    </table>
                </td>
            </tr>
        </table>--%>
        <%--DASHBOARD-3--%>
        <div class="BoxHeading">
            BIFP Piping Fabrication Status - EPIC Piping
        </div>
        <table>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        Isometrics & Spool Drawings
                    </div>
                    <table>
                        <tr>
                            <td style="vertical-align: top; padding-top: 100px;">
                                <telerik:RadTextBox ID="txtSpgnNarrative" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnSpgnNarrative" runat="server" Text="Save" OnClick="btnSpgnNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>
                            <td>
                                <div style="padding: 50px">
                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart10" Width="1300px" Height="400px" RegisterWithScriptManager="true" DataSourceID="SplSGPrgsVsActualDataSource" Font-Size="Larger">
                                        <PlotArea>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="WEEK_TARGET" Name="Weekly Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Visible="false">
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="FAB_WEEK_PRGS" Name="Weekly Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Visible="false">
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#ff9900" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>

                                                <telerik:LineSeries DataFieldY="CUMM_TARGET" Name="Cummulative Target" AxisName="AdditionalAxis">

                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <LabelsAppearance Visible="false"></LabelsAppearance>
                                                </telerik:LineSeries>
                                                <telerik:LineSeries DataFieldY="CUMM_PRGS" Name="Cummulative Progress" AxisName="AdditionalAxis">
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#ff9900" />
                                                    </Appearance>
                                                    <LabelsAppearance Visible="false"></LabelsAppearance>
                                                </telerik:LineSeries>
                                            </Series>
                                            <XAxis DataLabelsField="LABEL">
                                                <LabelsAppearance></LabelsAppearance>
                                                <MajorGridLines Visible="false"></MajorGridLines>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <TitleAppearance Text="Week"></TitleAppearance>
                                                <AxisCrossingPoints>
                                                    <telerik:AxisCrossingPoint Value="0" />
                                                    <telerik:AxisCrossingPoint Value="99999" />
                                                </AxisCrossingPoints>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Weekly Iso-To-Spool Dwg Weekly Target"></TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                            </YAxis>

                                            <AdditionalYAxes>
                                                <telerik:AxisY Name="AdditionalAxis"  Width="2">
                                                    <TitleAppearance Text="Weekly Iso-To-Spool Dwg Cumm Target">
                                                        <TextStyle Color="Black" />
                                                    </TitleAppearance>
                                                    <LabelsAppearance>
                                                        <TextStyle Color="Black" />
                                                    </LabelsAppearance>
                                                </telerik:AxisY>
                                            </AdditionalYAxes>
                                        </PlotArea>
                                        <ChartTitle Text="Weekly Progress Cummulative">
                                            <Appearance Align="Center" Position="Top"></Appearance>
                                        </ChartTitle>
                                    </telerik:RadHtmlChart>
                                </div>

                            </td>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart100" runat="server" DataSourceID="DWGProgressDataSource" Height="400px" Width="600px"
                                    Transitions="false">
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="DATA" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#006699" />

                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="DATA_BAL" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff6600" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>

                                        </Series>
                                        <XAxis DataLabelsField="LABLE">
                                        </XAxis>

                                    </PlotArea>
                                    <ChartTitle Text="Isometric & Spool Dwg. Status"></ChartTitle>

                                </telerik:RadHtmlChart>

                            </td>
                        </tr>
                        <%--test--%>

                        <tr>
                            <td colspan="2">

                                <telerik:RadGrid ID="SpoolgenGrid" runat="server" AutoGenerateColumns="true" DataSourceID="spgnStatusTableDataSrouce" Width="1800" Font-Size="Medium">
                                    <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        Total Project Material Delivery
                    </div>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart101" runat="server" DataSourceID="PIPDeliveryDataSource" Height="400px" Width="500px">
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="DATA" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#006699" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="DATA_BAL" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff6600" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>

                                        </Series>
                                        <XAxis DataLabelsField="LABLE">
                                        </XAxis>
                                        <YAxis>
                                            <TitleAppearance Text="Meters"></TitleAppearance>
                                        </YAxis>

                                    </PlotArea>
                                    <ChartTitle Text="Pipe Delivery Status"></ChartTitle>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart5" runat="server" DataSourceID="FLANGEDeliveryDataSource" Height="400px" Width="500px">
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="DATA" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#006699" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="DATA_BAL" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff6600" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>

                                        </Series>
                                        <XAxis DataLabelsField="LABLE">
                                        </XAxis>
                                        <YAxis>
                                            <TitleAppearance Text="Each"></TitleAppearance>
                                        </YAxis>

                                    </PlotArea>
                                    <ChartTitle Text="Flange Delivery Status"></ChartTitle>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart6" runat="server" DataSourceID="FITTINGDeliveryDataSource" Height="400px" Width="500px">
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="DATA" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#006699" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="DATA_BAL" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff6600" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>

                                        </Series>
                                        <XAxis DataLabelsField="LABLE">
                                        </XAxis>
                                        <YAxis>
                                            <TitleAppearance Text="Each"></TitleAppearance>
                                        </YAxis>
                                    </PlotArea>
                                    <ChartTitle Text="Fittings Delivery Status"></ChartTitle>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtMaterialNarrative" runat="server" TextMode="MultiLine" Width="300" Height="280" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnMaterialNarrative" runat="server" Text="Save" OnClick="btnMaterialNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        Workfront Availability
                    </div>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart7" runat="server" DataSourceID="AvlWorkFrontDataSource" Height="400px" Width="500px">
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="DATA" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#006699" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="DATA_BAL" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff6600" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>

                                        </Series>
                                        <XAxis DataLabelsField="LABLE">
                                        </XAxis>

                                    </PlotArea>
                                    <ChartTitle Text="Total Available Workfront Of EPIC"></ChartTitle>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart8" runat="server" DataSourceID="CurrentWorkDataSource" Height="400px" Width="1200px">
                                    <PlotArea>
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="DATA" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#006699" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="DATA_BAL" Stacked="true">
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff6600" />
                                                </Appearance>
                                                <LabelsAppearance Position="Center"></LabelsAppearance>
                                            </telerik:ColumnSeries>

                                        </Series>
                                        <XAxis DataLabelsField="LABLE">
                                        </XAxis>

                                    </PlotArea>
                                    <ChartTitle Text="Current Workfront Availabilty (dia. Inch)"></ChartTitle>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtWorkFrontNarrative" runat="server" TextMode="MultiLine" Width="300" Height="280" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnWorkFrontNarrative" runat="server" Text="Save" OnClick="btnWorkFrontNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        Spool Fabrication
                    </div>
                    <table>
                        <tr>
                            <td style="vertical-align: top">
                                <telerik:RadTextBox ID="txtFabNarrative" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnFabNarrative" runat="server" Text="Save" OnClick="btnFabNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>
                            <td>
                                <div>
                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart9" Width="2000px" Height="500px" RegisterWithScriptManager="true" DataSourceID="SplFabPrgsVsActualDataSource">
                                        <PlotArea>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="SPL_FAB_TARGET_WEEK" Name="Weekly Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="InsideBase" Visible="false">
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="FAB_WEEK_PRGS" Name="Weekly Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="InsideBase" Visible="false">
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#ff9900" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>


                                                <telerik:LineSeries DataFieldY="SPL_FAB_TARGET_CUMM" Name="Cummulative Target" AxisName="AdditionalAxis">
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <LabelsAppearance Visible="false"></LabelsAppearance>
                                                </telerik:LineSeries>
                                                <telerik:LineSeries DataFieldY="CUMM_PRGS" Name="Cummulative Progress" AxisName="AdditionalAxis">
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#ff9900" />
                                                    </Appearance>
                                                    <LabelsAppearance Visible="false"></LabelsAppearance>
                                                </telerik:LineSeries>
                                            </Series>
                                            <XAxis DataLabelsField="LABEL">
                                                <LabelsAppearance></LabelsAppearance>
                                                <MajorGridLines Visible="false"></MajorGridLines>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <TitleAppearance Text="Week"></TitleAppearance>

                                                <AxisCrossingPoints>
                                                    <telerik:AxisCrossingPoint Value="0" />
                                                    <telerik:AxisCrossingPoint Value="99999" />
                                                </AxisCrossingPoints>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Weekly Spool Fabrication Inch Dia Weekly"></TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                            </YAxis>
                                             <AdditionalYAxes>
                                                <telerik:AxisY Name="AdditionalAxis"  Width="2">
                                                    <TitleAppearance Text="Weekly Spool Fabrication Inch Dia Cumm">
                                                        <TextStyle Color="Black" />
                                                    </TitleAppearance>
                                                    <LabelsAppearance>
                                                        <TextStyle Color="Black" />
                                                    </LabelsAppearance>
                                                </telerik:AxisY>
                                            </AdditionalYAxes>
                                        </PlotArea>
                                        <ChartTitle Text="">
                                            <Appearance Align="Left" Position="Top"></Appearance>
                                        </ChartTitle>
                                    </telerik:RadHtmlChart>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadGrid ID="FabProgressGrid" runat="server" AutoGenerateColumns="true" DataSourceID="fabStatusTableDataSource" Width="2800" Font-Size="Medium">
                                    <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>


    </div>
    <div id="divexport" style="border: solid">
        <table>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        ISOMETRIC RECIEVED STATUS PLANNING vs ACTUAL
                    </div>
                    <div style="padding: 50px">
                        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1_EPIC" Width="1000px" Height="600px" RegisterWithScriptManager="true" DataSourceID="dsISOPlanningReport_EPIC">
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
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        ISOMETRIC SPOOLGEN STATUS PLANNING vs ACTUAL
                    </div>
                    <div style="padding: 50px">
                        <telerik:RadHtmlChart runat="server" ID="RadHtmlChart4" Width="1000px" Height="500px" RegisterWithScriptManager="true" DataSourceID="dsISOSpoolgenReport_EPIC">
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
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        SPOOLGEN STATUS
                    </div>
                    <div style="padding: 50px">
                        <table>
                            <tr>
                                <td colspan="2">

                                    <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="spgnTableStatusDataSource" Width="1500px" Font-Size="Larger" GroupHeaderItemStyle-Font-Size="Larger" GroupHeaderItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="spgnTableStatusDataSource">
                                            <AlternatingItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="LABEL" FilterControlAltText="Filter LABEL column" HeaderText="LABEL" SortExpression="LABEL"
                                                    UniqueName="LABEL" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT1" FilterControlAltText="Filter CNT1 column" HeaderText="COUNT (Last-Week)" SortExpression="CNT1"
                                                    UniqueName="CNT1" FooterText="Total">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="INCHDIA1" FilterControlAltText="Filter INCHDIA1 column" HeaderText="INCHDIA(Last-Week)" SortExpression="INCHDIA1"
                                                    UniqueName="INCHDIA1" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT2" FilterControlAltText="Filter CNT2 column" HeaderText="COUNT(This-Week)" SortExpression="CNT2"
                                                    UniqueName="CNT2" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="INCHDIA2" FilterControlAltText="Filter INCHDIA2 column" HeaderText="INCHDIA(This-Week )" SortExpression="INCHDIA2"
                                                    UniqueName="INCHDIA2" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT" FilterControlAltText="Filter CNT column" HeaderText="COUNT(Cumulative)" SortExpression="CNT"
                                                    UniqueName="CNT" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="INCHDIA" FilterControlAltText="Filter INCHDIA column" HeaderText="INCHDIA(Cumulative)" SortExpression="INCHDIA"
                                                    UniqueName="INCHDIA" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                    <div style="padding: 5px; text-align: center;">
                                        <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DefaultType="Bar" Width="800px" Height="500px" DataSourceID="spgnStatusDataSource" Legend-Appearance-TextStyle-FontSize="20px">
                                            <PlotArea>
                                                <Series>
                                                    <telerik:ColumnSeries DataFieldY="SCOPE_SHEET" Name="01 TOTAL ISOMETRICS" VisibleInLegend="true" Gap="1" Spacing="4">

                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Aqua" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>

                                                    <telerik:ColumnSeries DataFieldY="SHEET_RECEIVED_FROM_ENGG" Name="02 RELEASED FROM ENGINEERING">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Violet" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="ISSUED_TO_SUBCON" Name="03 ISSUED TO FABRICATOR">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Tomato" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>

                                                    <telerik:ColumnSeries DataFieldY="RECEIVED_BY_FAB" Name="04 RECEIVED BY FABRICATOR">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="BlueViolet" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="HOLD_ISO_SHEET" Name="05 HOLD ISOMETRIC SHEET">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="SteelBlue" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="SPGN_UNDER_PRGS" Name="06 WORKFRONT FOR SPOOLGEN">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Gold" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="SPOOLGEN_SHTS" Name="07 SPOOLGEN COMPLETED">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Gray" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                </Series>
                                            </PlotArea>
                                            <ChartTitle Text="Spoolgen Status Count">
                                            </ChartTitle>
                                        </telerik:RadHtmlChart>

                                    </div>
                                </td>
                                <td colspan="1">
                                    <div style="padding: 5px; text-align: center;">
                                        <telerik:RadHtmlChart ID="RadHtmlChart2" runat="server" DefaultType="Bar" Width="800px" Height="500px" DataSourceID="spgnStatusDataSource" Legend-Appearance-TextStyle-FontSize="20px">
                                            <PlotArea>
                                                <Series>
                                                    <telerik:ColumnSeries DataFieldY="FAB_SCOPE_ID_PLANNING" Name="01 TOTAL ISOMETRICS ID" VisibleInLegend="true" Gap="1" Spacing="4">

                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Aqua" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>

                                                    <telerik:ColumnSeries DataFieldY="ESTIMATED_SHOP_ID_77_PER" Name="02 RELEASED FROM ENGINEERING ID">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Violet" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="ISSUED_TO_SUBCON_ID_77_PER" Name="03 ISSUED TO FABRICATOR ID">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Tomato" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>

                                                    <telerik:ColumnSeries DataFieldY="RECEIVED_BY_FAB_ID" Name="04 RECEIVED BY FABRICATOR ID">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="BlueViolet" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="HOLD_ISO_SHEET_ID" Name="05 HOLD ISOMETRIC SHEET ID">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="SteelBlue" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="SPGN_UNDER_PRGS_ID" Name="06 WORKFRONT FOR SPOOLGEN ID">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Gold" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                    <telerik:ColumnSeries DataFieldY="SPOOLGEN_ID" Name="07 SPOOLGEN COMPLETED ID">
                                                        <Appearance>
                                                            <FillStyle BackgroundColor="Gray" />
                                                        </Appearance>
                                                    </telerik:ColumnSeries>
                                                </Series>
                                            </PlotArea>
                                            <ChartTitle Text="Spoolgen Status Inch Dia">
                                            </ChartTitle>
                                        </telerik:RadHtmlChart>

                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        MATERIAL STATUS
                    </div>
                    <div style="padding: 50px">
                        <table>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="RadGrid2" runat="server" CellSpacing="-1" DataSourceID="SplMatTableDataSource" Width="1000px">
                                        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SplMatTableDataSource">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="LABEL" FilterControlAltText="Filter LABEL column" HeaderText="LABEL" SortExpression="LABEL"
                                                    UniqueName="LABEL" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="REF" FilterControlAltText="Filter REF column" HeaderText="REFERENCE" SortExpression="REF"
                                                    UniqueName="REF" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT" FilterControlAltText="Filter CNT column" HeaderText="SPOOL COUNT" SortExpression="CNT"
                                                    UniqueName="CNT" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="INCHDIA" FilterControlAltText="Filter INCHDIA column" HeaderText="INCHDIA" SortExpression="INCHDIA"
                                                    UniqueName="INCHDIA" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadHtmlChart runat="server" ID="PieChart1" Width="550" Height="300" Transitions="true" DataSourceID="SplMatDataSource">
                                        <ChartTitle Text="MATERIAL STATUS COUNT">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="CNT" ColorField="COLORCODE"
                                                    NameField="LABEL">
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                </td>
                                <td>
                                    <telerik:RadHtmlChart runat="server" ID="PieChart2" Width="550" Height="300" Transitions="true" DataSourceID="SplMatDataSource">
                                        <ChartTitle Text="MATERIAL STATUS INCHDIA">
                                            <Appearance Align="Center" Position="Top">
                                            </Appearance>
                                        </ChartTitle>
                                        <Legend>
                                            <Appearance Position="Custom" OffsetX="370" OffsetY="120" Visible="true">
                                            </Appearance>
                                        </Legend>
                                        <PlotArea>
                                            <Series>
                                                <telerik:PieSeries DataFieldY="INCHDIA" ColorField="COLORCODE"
                                                    NameField="LABEL">
                                                    <LabelsAppearance DataFormatString="{0:N0}"></LabelsAppearance>
                                                    <TooltipsAppearance Color="White" DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:PieSeries>
                                            </Series>
                                        </PlotArea>
                                    </telerik:RadHtmlChart>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        SPOOL PROGRESS
                    </div>
                    <div style="padding: 50px">
                        <table>

                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="RadGrid3" runat="server" CellSpacing="-1" DataSourceID="SplProgressDataSource" Width="1500px">
                                        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SplProgressDataSource">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="LABEL" FilterControlAltText="Filter LABEL column" HeaderText="LABEL" SortExpression="LABEL"
                                                    UniqueName="LABEL" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT1" FilterControlAltText="Filter CNT1 column" HeaderText="COUNT (Last-Week)" SortExpression="CNT1"
                                                    UniqueName="CNT1" FooterText="Total">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="INCHDIA1" FilterControlAltText="Filter INCHDIA1 column" HeaderText="INCHDIA(Last-Week)" SortExpression="INCHDIA1"
                                                    UniqueName="INCHDIA1" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT2" FilterControlAltText="Filter CNT2 column" HeaderText="COUNT(This-Week)" SortExpression="CNT2"
                                                    UniqueName="CNT2" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="INCHDIA2" FilterControlAltText="Filter INCHDIA2 column" HeaderText="INCHDIA(This-Week )" SortExpression="INCHDIA2"
                                                    UniqueName="INCHDIA2" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CNT" FilterControlAltText="Filter CNT column" HeaderText="COUNT(Cumulative)" SortExpression="CNT"
                                                    UniqueName="CNT" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="INCHDIA" FilterControlAltText="Filter INCHDIA column" HeaderText="INCHDIA(Cumulative)" SortExpression="INCHDIA"
                                                    UniqueName="INCHDIA" FooterText="Total">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadHtmlChart ID="RadHtmlIsoStatus" runat="server" DataSourceID="SplProgressDataSource" Height="400px" Width="500px">
                                        <PlotArea>
                                            <Series>
                                                <telerik:BarSeries DataFieldY="CNT" Name="Isometric Status" Stacked="False" VisibleInLegend="false">
                                                </telerik:BarSeries>
                                            </Series>
                                            <XAxis DataLabelsField="LABEL">
                                                <LabelsAppearance RotationAngle="0">
                                                </LabelsAppearance>
                                            </XAxis>

                                        </PlotArea>
                                        <ChartTitle Text="ISOMETRIC STATUS COUNT"></ChartTitle>

                                    </telerik:RadHtmlChart>
                                </td>
                                <td>
                                    <telerik:RadHtmlChart ID="RadHtmlChart3" runat="server" DataSourceID="SplProgressDataSource" Height="400px" Width="500px">
                                        <PlotArea>
                                            <Series>
                                                <telerik:BarSeries DataFieldY="INCHDIA" Name="Isometric Status" Stacked="False" VisibleInLegend="false">
                                                </telerik:BarSeries>
                                            </Series>
                                            <XAxis DataLabelsField="LABEL">
                                                <LabelsAppearance RotationAngle="0">
                                                </LabelsAppearance>
                                            </XAxis>

                                        </PlotArea>
                                        <ChartTitle Text="ISOMETRIC STATUS INCHDIA"></ChartTitle>
                                    </telerik:RadHtmlChart>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="spgnStatusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM TBL_VIEW_EPIC_ISO_STATUS_DB"></asp:SqlDataSource>
    <asp:SqlDataSource ID="spgnTableStatusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_TBL_EPIC_ISO_STATUS_DB ORDER BY SNO"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SplMatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT COLORCODE,LABEL,CNT,INCHDIA FROM VIEW_TBL_EPIC_SPL_STATUS_DB WHERE SNO IN (1,3)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SplMatTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_TBL_EPIC_SPL_STATUS_DB where sno in (1,2,3,4,5,6)"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SplProgressDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_TBL_EPIC_SPL_STATUS_DB where sno in (1,3,7,8,9,10,11,12)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsISOPlanningReport_EPIC" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_ISO_PLANNING_REP_EPIC ORDER BY yymm asc"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsISOSpoolgenReport_EPIC" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_ISO_SPOOLGEN_REP_EPIC ORDER BY yymm asc"></asp:SqlDataSource>

    <%--Dashboard 2--%>

    <asp:SqlDataSource ID="ISOStatusDataSourcedb2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_ISO_STATUS_DB2 ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ISOStatusDataSourcedb2_1" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_ISO_STATUS_DB2 WHERE SNO IN(1.1,1.2) ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ISOStatusDataSourcedb2_2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_ISO_STATUS_DB2 WHERE SNO IN(1.1,1.4)  ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ISOStatusDataSourcedb2_3" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_ISO_STATUS_DB2 WHERE SNO IN(1.1,1.6)  ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ISOStatusDataSourcedb2_4" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_ISO_STATUS_DB2  WHERE SNO IN(1.1,1.7)  ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_ISO_STATUS_DB2 ORDER BY sno"></asp:SqlDataSource>

    <%--Dashboard 2.1--%>

    <asp:SqlDataSource ID="MatStatusDataSourcedb2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_MAT_STATUS_DB2 ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="MatStatusDataSourcedb2_1" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_MAT_STATUS_DB2 WHERE SNO IN(2.3,2.5) ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="MatStatusDataSourcedb2_2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_MAT_STATUS_DB2 WHERE SNO IN(2.3,2.6)  ORDER BY sno"></asp:SqlDataSource>

    <%--Dashboard 3.1--%>

    <asp:SqlDataSource ID="WFStatusDataSourcedb2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_WORKFRONT_STATUS_DB2 ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="WFStatusDataSourcedb2_1" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_WORKFRONT_STATUS_DB2 WHERE SNO IN(3.0,3.2,3.4) ORDER BY sno"></asp:SqlDataSource>

    <asp:SqlDataSource ID="WFStatusDataSourcedb2_2" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>" ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM TBL_WORKFRONT_STATUS_DB2 WHERE SNO IN(3.0,3.3,3.5)  ORDER BY sno"></asp:SqlDataSource>
    <%--Dashbaord 3 EPIC ADNOC FORMAT--%>


    <asp:SqlDataSource ID="SplSGPrgsVsActualDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SPL_SG_PRGS_DB"></asp:SqlDataSource>

    <asp:SqlDataSource ID="DWGProgressDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_DWG_EPIC_STATUS_MAIN"></asp:SqlDataSource>

    <asp:SqlDataSource ID="PIPDeliveryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_DELIVERY_STATUS_PIPE"></asp:SqlDataSource>

    <asp:SqlDataSource ID="FLANGEDeliveryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_DELIVERY_STATUS_FLNG"></asp:SqlDataSource>


    <asp:SqlDataSource ID="FITTINGDeliveryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_DELIVERY_STATUS_FITNG"></asp:SqlDataSource>

    <asp:SqlDataSource ID="AvlWorkFrontDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_WORK_FORNT_EPIC_SCOPE"></asp:SqlDataSource>

    <asp:SqlDataSource ID="CurrentWorkDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_WORK_FORNT_EPIC_MAIN"></asp:SqlDataSource>


    <asp:SqlDataSource ID="SplFabPrgsVsActualDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SPL_FAB_PRGS_DB"></asp:SqlDataSource>

    <asp:SqlDataSource ID="spgnStatusTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_PRGS_DB"></asp:SqlDataSource>


    <asp:SqlDataSource ID="fabStatusTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_PRGS_DB"></asp:SqlDataSource>
</asp:Content>

