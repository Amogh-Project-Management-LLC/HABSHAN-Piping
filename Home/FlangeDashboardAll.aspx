<%@ Page Title="Amogh Dashboard" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FlangeDashboardAll.aspx.cs" Inherits="FlangeDashboard_Dashboard" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .BoxHeading {
            font-weight: bold;
            font-size: 40pt;
            padding-top: 5px;
            height: 60px;
            padding-left: 3px;
            text-align: center;
            color: #2a33a5;
        }

        .BoxHeading1 {
            background-color: #2a33a5;
            font-weight: bold;
            font-size: 30pt;
            padding-top: 3px;
            height: 50px;
            padding-left: 3px;
            color: white;
            text-align: center;
        }

        .BoxHeading2 {
            background-color: #AEDEE7;
            font-weight: bold;
            font-size: 30pt;
            padding-top: 5px;
            height: 50px;
            padding-left: 3px;
        }

        /*#divexport2{
            width: 1450px;
            height:2000px;
            overflow: scroll;
        }*/

        /*#divexport2.k-pdf-export{
            height: auto;
            width:auto;
            border: 2px solid;
            overflow: initial;
        }*/
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
            function exportPDFexportPDF() {
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




    <telerik:RadButton RenderMode="Lightweight" runat="server" OnClientClicked="exportPDF2" Text="Export Dashboard to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
    <telerik:RadButton runat="server" ID="btnShow" Text="Show" OnClick="btnShow_Click" ></telerik:RadButton>
    <telerik:RadButton runat="server" ID="btnHide" Text="Hide" OnClick="btnHide_Click" Visible="false"></telerik:RadButton>


    <div id="divexport2">

        <%--DASHBOARD-3--%>
        <div class="BoxHeading">
            BIFP Flange Status - 
            <telerik:RadLabel ID="lablesc" runat="server"></telerik:RadLabel>
            Piping
        </div>

        <table>
            <tr>
                <td>
                    <div class="BoxHeading1">
                        Flange Joints PID Marking Schedule 
                    </div>
                    <table>
                        <tr>

                            <td>

                                <telerik:RadHtmlChart runat="server" ID="RadHtmlChart3" Width="500px" Height="400px" RegisterWithScriptManager="true" Font-Size="Large" DataSourceID="ProgressGridDs">
                                    
                                    <PlotArea>
                                        <Appearance>
                                            <TextStyle Margin="50 0 0 0" />
                                        </Appearance>
                                        
                                        <Series>
                                            <telerik:ColumnSeries DataFieldY="ESTIMATED_JOINTS" Name="Total Planned Count">
                                                <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                    <TextStyle Color="#3333ff" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                </LabelsAppearance>
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#3333ff" />
                                                </Appearance>
                                                <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                            <telerik:ColumnSeries DataFieldY="FLANGE_JOINTS" Name="Total Actual Count">
                                                <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                    <TextStyle Color="#ff9900" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                </LabelsAppearance>
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#ff9900" />
                                                </Appearance>
                                                <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="FLANGE_JOINTS" Name="Total Amogh Count">
                                                <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                    <TextStyle Color="#33ccff" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                </LabelsAppearance>
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#33ccff" />
                                                </Appearance>
                                                <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:ColumnSeries>
                                              <telerik:ColumnSeries DataFieldY="FLANGE_JC" Name="Total Jobcard Count">
                                                <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                    <TextStyle Color="#33cccc" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                </LabelsAppearance>
                                                <Appearance>
                                                    <FillStyle BackgroundColor="#33cccc" />
                                                </Appearance>
                                                <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                            </telerik:ColumnSeries>



                                        </Series>
                                        <XAxis DataLabelsField="LABEL">
                                            <LabelsAppearance></LabelsAppearance>
                                            <MajorGridLines Visible="false"></MajorGridLines>
                                            <MinorGridLines Visible="false"></MinorGridLines>
                                            <AxisCrossingPoints>
                                                <telerik:AxisCrossingPoint Value="0" />
                                                <telerik:AxisCrossingPoint Value="99999" />
                                            </AxisCrossingPoints>
                                            <LabelsAppearance>
                                                <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                            </LabelsAppearance>
                                        </XAxis>
                                        <YAxis Step="10000" MinValue="0">
                                            <LabelsAppearance>
                                                <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                            </LabelsAppearance>

                                            <MinorGridLines Visible="false"></MinorGridLines>

                                        </YAxis>

                                    </PlotArea>
                                    <%-- <ChartTitle Text="Identification Of Flange Joints \n (Isometris/SpoolDrawing) ">
                                        <Appearance Align="Center" Position="Top"></Appearance>
                                    </ChartTitle>--%>
                                    <ChartTitle Text="Identification Of Flange Joints \n (Isometris/SpoolDrawing) ">
                                        <Appearance>
                                            <TextStyle Color="Black" FontSize="25" FontFamily="Verdana" Margin="11" Padding="10" />
                                        </Appearance>
                                    </ChartTitle>
                                    <Legend>
                                        <Appearance>
                                            <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                        </Appearance>
                                    </Legend>
                                </telerik:RadHtmlChart>

                            </td>
                           
                            <td>
                                <div id="chart4">

                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart4" Width="4400px" Height="400px" RegisterWithScriptManager="true" Font-Size="Large" DataSourceID="FlangeDataSrouce">
                                        <PlotArea>
                                            <Appearance>
                                                <TextStyle Margin="50 0 0 0" />
                                            </Appearance>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="WEEK_TARGET" Name="Weekly Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                        <TextStyle Color="Black" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="FAB_WEEK_PRGS" Name="Weekly Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                        <TextStyle Color="Blue" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
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
                                                <LabelsAppearance>
                                                    <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                </LabelsAppearance>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Flange Joints Schedule  Weekly Target">
                                                    <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                                </TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <LabelsAppearance>
                                                    <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                </LabelsAppearance>
                                            </YAxis>

                                            <AdditionalYAxes>
                                                <telerik:AxisY Name="AdditionalAxis" Width="2">
                                                    <TitleAppearance Text="Flange Joints Schedule Cumm Target">
                                                        <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                                    </TitleAppearance>
                                                    <LabelsAppearance>
                                                        <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                    </LabelsAppearance>
                                                </telerik:AxisY>
                                            </AdditionalYAxes>
                                        </PlotArea>
                                        <%--  <ChartTitle Text="Weekly Progress Cummulative">
                                            <Appearance Align="Center" Position="Top"></Appearance>
                                        </ChartTitle>--%>
                                        <Legend>
                                            <Appearance>
                                                <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                            </Appearance>
                                        </Legend>
                                    </telerik:RadHtmlChart>
                                </div>

                            </td>
                             <td style="vertical-align: top; padding-top: 100px; ">
                                <telerik:RadTextBox ID="txtNarrative" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnNarrative" runat="server" Text="Save" OnClick="btnNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>
                        </tr>
                        <tr>

                            <td>
                                <telerik:RadGrid ID="ProgressGrid" runat="server" AutoGenerateColumns="true" Width="120" Font-Size="Large" DataSourceID="ProgressGridDs"
                                    HeaderStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left">
                                    <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                </telerik:RadGrid>
                            </td>
                            <td style="padding: 50px">
                                <div id="flnGrid">
                                    <telerik:RadGrid ID="flangeGrid" runat="server" AutoGenerateColumns="true" Width="4400" Font-Size="Large" DataSourceID="FlangeGridDS" HeaderStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left">
                                        <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>

                        </tr>

                    </table>
                </td>
            </tr>

        </table>

        <table>
            <tr>
                <td style="padding: 20px;">
                    <div class="BoxHeading1">
                        Tag Printing Schedule
                    </div>
                    <table>
                        <tr>
                            <%-- <td style="vertical-align: top; padding-top: 100px;">
                                <telerik:RadTextBox ID="RadTextBox1" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="RadButton1" runat="server" Text="Save" OnClick="btnNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>--%>
                            <td>
                                <div id="chart1">

                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart1" Width="5100px" Height="400px" RegisterWithScriptManager="true" Font-Size="Large" DataSourceID="FlangeDataSrouce1">
                                        <PlotArea>
                                            <Appearance>
                                                <TextStyle Margin="50 0 0 0" />
                                            </Appearance>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="WEEK_TARGET" Name="Weekly Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                        <TextStyle Color="Black" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="FAB_WEEK_PRGS" Name="Weekly Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                        <TextStyle Color="Blue" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
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
                                                <LabelsAppearance>
                                                    <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                </LabelsAppearance>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Flange Joints Schedule  Weekly Target">
                                                    <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                                </TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <LabelsAppearance>
                                                    <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                </LabelsAppearance>
                                            </YAxis>

                                            <AdditionalYAxes>
                                                <telerik:AxisY Name="AdditionalAxis" Width="2">
                                                    <TitleAppearance Text="Flange Joints Schedule Cumm Target">
                                                        <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                                    </TitleAppearance>
                                                    <LabelsAppearance>
                                                        <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                    </LabelsAppearance>
                                                </telerik:AxisY>
                                            </AdditionalYAxes>
                                        </PlotArea>
                                        <%-- <ChartTitle Text="Weekly Progress Cummulative">
                                        <Appearance Align="Center" Position="Top"></Appearance>
                                    </ChartTitle>--%>
                                        <Legend>
                                            <Appearance>
                                                <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                            </Appearance>
                                        </Legend>
                                    </telerik:RadHtmlChart>
                                </div>

                            </td>
                             <td style="vertical-align: top; padding-top: 100px; ">
                                <telerik:RadTextBox ID="txtNarrative2" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnNarrative2" runat="server" Text="Save" OnClick="btnNarrative2_Click" Visible="false"></telerik:RadButton>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="3">
                                <div id="grid1">
                                    <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="true" Width="5100" Font-Size="Large" DataSourceID="FlangeGridDS1" HeaderStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left">
                                        <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>


                    </table>
                </td>
            </tr>

        </table>
        <table>
            <tr>
                <td style="padding: 20px;">
                    <div class="BoxHeading1">
                        Physical Tagging On Site
                    </div>
                    <table>
                        <tr>
                            <%-- <td style="vertical-align: top; padding-top: 100px;">
                                <telerik:RadTextBox ID="RadTextBox1" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="RadButton1" runat="server" Text="Save" OnClick="btnNarrative_Click" Visible="false"></telerik:RadButton>
                            </td>--%>
                            <td>
                                <div id="chart2">

                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart2" Width="5100px" Height="400px" RegisterWithScriptManager="true" Font-Size="Large" DataSourceID="FlangeDataSrouce2">
                                        <PlotArea>
                                            <Appearance>
                                                <TextStyle Margin="50 0 0 0" />
                                            </Appearance>
                                            <Series>
                                                <telerik:ColumnSeries DataFieldY="WEEK_TARGET" Name="Weekly Planned Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                        <TextStyle Color="Black" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
                                                    </LabelsAppearance>
                                                    <Appearance>
                                                        <FillStyle BackgroundColor="#3333ff" />
                                                    </Appearance>
                                                    <TooltipsAppearance DataFormatString="{0:N0}"></TooltipsAppearance>
                                                </telerik:ColumnSeries>
                                                <telerik:ColumnSeries DataFieldY="FAB_WEEK_PRGS" Name="Weekly Actual Count">
                                                    <LabelsAppearance RotationAngle="270" DataFormatString="{0:N0}" Position="OutsideEnd">
                                                        <TextStyle Color="Blue" FontFamily="Arial" FontSize="20" Bold="true" Italic="true" />
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
                                                <LabelsAppearance>
                                                    <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                </LabelsAppearance>
                                            </XAxis>
                                            <YAxis>
                                                <TitleAppearance Text="Flange Joints Schedule  Weekly Target">
                                                    <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                                </TitleAppearance>
                                                <MinorGridLines Visible="false"></MinorGridLines>
                                                <LabelsAppearance>
                                                    <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                </LabelsAppearance>
                                            </YAxis>

                                            <AdditionalYAxes>
                                                <telerik:AxisY Name="AdditionalAxis" Width="2">
                                                    <TitleAppearance Text="Flange Joints Schedule Cumm Target">
                                                        <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                                    </TitleAppearance>
                                                    <LabelsAppearance>
                                                        <TextStyle Color="Green" FontFamily="Verdana" Italic="true" FontSize="20" />
                                                    </LabelsAppearance>
                                                </telerik:AxisY>
                                            </AdditionalYAxes>
                                        </PlotArea>
                                        <%--   <ChartTitle Text="Weekly Progress Cummulative">
                                        <Appearance Align="Center" Position="Top"></Appearance>
                                    </ChartTitle>--%>
                                        <Legend>
                                            <Appearance>
                                                <TextStyle Color="Red" FontFamily="Segoe UI" FontSize="20" Italic="true" />
                                            </Appearance>
                                        </Legend>
                                    </telerik:RadHtmlChart>
                                </div>

                            </td>
                            <td style="vertical-align: top; padding-top: 100px; ">
                                <telerik:RadTextBox ID="txtNarrative3" runat="server" TextMode="MultiLine" Width="300" Height="300" Resize="Both" EmptyMessage="Narrative:"></telerik:RadTextBox><br />
                                <telerik:RadButton ID="btnNarrative3" runat="server" Text="Save" OnClick="btnNarrative3_Click" Visible="false"></telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <div id="grid2">
                                    <telerik:RadGrid ID="RadGrid2" runat="server" AutoGenerateColumns="true" Width="5100" Font-Size="Medium" DataSourceID="FlangeGridDS2" HeaderStyle-Font-Bold="true" HeaderStyle-HorizontalAlign="Left">
                                        <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>


                    </table>
                </td>
            </tr>

        </table>
    </div>


    <asp:SqlDataSource ID="FlangeDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_FLANGE_PRGS1"></asp:SqlDataSource>

    <asp:SqlDataSource ID="FlangeGridDS" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_FLANGE_PRGS2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="FlangeDataSrouce1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_FLANGE_PRGS1_CH1"></asp:SqlDataSource>

    <asp:SqlDataSource ID="FlangeGridDS1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_FLANGE_PRGS2_CH1"></asp:SqlDataSource>

    <asp:SqlDataSource ID="FlangeDataSrouce2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_FLANGE_PRGS1_CH2"></asp:SqlDataSource>

    <asp:SqlDataSource ID="FlangeGridDS2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_FLANGE_PRGS2_CH2"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ProgressGridDs" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_FLANGE_CNT"></asp:SqlDataSource>


</asp:Content>

