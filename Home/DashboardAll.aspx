<%@ Page Title="Amogh Dashboard" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DashboardAll.aspx.cs" Inherits="Dashboard_Dashboard"  EnableSessionState="ReadOnly" %>

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



  
    <telerik:RadButton RenderMode="Lightweight" runat="server" OnClientClicked="exportPDF2" Text="Export Dashboard to PDF" AutoPostBack="false" UseSubmitBehavior="false"></telerik:RadButton>
    <telerik:RadButton runat="server" ID="btnShow" Text="Show" OnClick="btnShow_Click"></telerik:RadButton>
    <telerik:RadButton runat="server" ID="btnHide" Text="Hide" OnClick="btnHide_Click"></telerik:RadButton>
    <telerik:RadDropDownList runat="server" ID="ddlSubcon" DataSourceID="SubconDataSource" DataTextField="COMMON_SC_NAME" DataValueField="COMMON_SC_NAME" OnSelectedIndexChanged="ddlSubcon_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true" OnDataBinding="ddlSubcon_DataBinding">
       
    </telerik:RadDropDownList>
    <div id="divexport2" style="border: solid">
     
        <%--DASHBOARD-3--%>
        <div class="BoxHeading">
            BIFP Piping Fabrication Status - 
            <telerik:RadLabel ID="lablesc" runat="server"></telerik:RadLabel>
            Piping
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
                                <div style="padding: 50px ; width:1500px; overflow-x:scroll">
                                    
                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart10" Width="1600px" Height="400px" RegisterWithScriptManager="true" Font-Size="Large">
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
                                <telerik:RadHtmlChart ID="RadHtmlChart100" runat="server"  Height="400px" Width="600px"
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
                            <td colspan="3">
                                    <div style=" width:1500px; overflow-x:scroll">
                                <telerik:RadGrid ID="SpoolgenGrid" runat="server" AutoGenerateColumns="true"  Width="2200" Font-Size="Medium">
                                    <MasterTableView AutoGenerateColumns="true"></MasterTableView>
                                </telerik:RadGrid>
                                        </div>
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
                                <telerik:RadHtmlChart ID="RadHtmlChart101" runat="server" Height="400px" Width="500px">
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
                                <telerik:RadHtmlChart ID="RadHtmlChart5" runat="server"  Height="400px" Width="500px">
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
                                <telerik:RadHtmlChart ID="RadHtmlChart6" runat="server"  Height="400px" Width="500px">
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
                                <telerik:RadHtmlChart ID="RadHtmlChart7" runat="server"  Height="400px" Width="500px">
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
                                    <ChartTitle Text="Total Available Workfront"></ChartTitle>
                                </telerik:RadHtmlChart>
                            </td>
                            <td>
                                <telerik:RadHtmlChart ID="RadHtmlChart8" runat="server"  Height="400px" Width="1500px">
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
                                <div style="width:2000px; overflow-x:scroll">
                                    <telerik:RadHtmlChart runat="server" ID="RadHtmlChart9" Width="3000px" Height="500px" RegisterWithScriptManager="true" >
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
                                <div style="width:2000px; overflow-x:scroll">
                                <telerik:RadGrid ID="FabProgressGrid" runat="server" AutoGenerateColumns="true"  Width="2800" Font-Size="Medium">
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
   
    <%--Dashbaord 3 ALL ADNOC FORMAT--%>
    
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT COMMON_SC_NAME FROM SUB_CONTRACTOR WHERE COMMON_SC_NAME IN ('EPIC','CPECC ICAD WORKSHOP','DIVISION-7','PENTA GLOBAL','STS','DYCC-7')">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SplSGPrgsVsActualDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SPL_SG_PRGS_DB_SC WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DWGProgressDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_DWG_SC_STATUS_MAIN WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource> 

    <asp:SqlDataSource ID="PIPDeliveryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_DELVRY_STATUS_PIPE_SC WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="FLANGEDeliveryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_DELVRY_STATUS_FLNG_SC WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="FITTINGDeliveryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_DELVRY_STATUS_FITG_SC WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="AvlWorkFrontDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_WORK_FORNT_SC_SCOPE WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="CurrentWorkDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_WORK_FORNT_SC_MAIN WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource> 

    <asp:SqlDataSource ID="SplFabPrgsVsActualDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_SPL_FAB_PRGS_DB_SC WHERE COMMON_SC_NAME=:SC_ID">
          <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
    </asp:SqlDataSource> 
    <%--START PIVOT TABLES OF  AND FAB--%>
                <%--START EPIC  PIVOT--%>
    <asp:SqlDataSource ID="EPICspgnTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_EPIC">
         
    </asp:SqlDataSource>  

    <asp:SqlDataSource ID="EPICfabTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_EPIC">
         
    </asp:SqlDataSource> 
               <%-- END EPIC  PIVOT--%>

              <%--START ICAD  PIVOT--%>
    <asp:SqlDataSource ID="ICADspgnTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_ICAD">
         
    </asp:SqlDataSource>  

    <asp:SqlDataSource ID="ICADfabTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_ICAD">
         
    </asp:SqlDataSource> 
               <%-- END ICAD  PIVOT--%>

             <%--START DIVISION-7  PIVOT--%>
    <asp:SqlDataSource ID="D7spgnTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_DIV7">
         
    </asp:SqlDataSource>  

    <asp:SqlDataSource ID="D7fabTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_DIV7">
         
    </asp:SqlDataSource> 
               <%-- END DIVISION-7  PIVOT--%>

             <%--START PENTA GLOBAL  PIVOT--%>
    <asp:SqlDataSource ID="PentaspgnTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_PENTA">
         
    </asp:SqlDataSource>  

    <asp:SqlDataSource ID="PentafabTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_PENTA">
         
    </asp:SqlDataSource> 
               <%-- END PENTA GLOBAL  PIVOT--%>

             <%--START STS  PIVOT--%>
    <asp:SqlDataSource ID="STSspgnTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_STS">
         
    </asp:SqlDataSource>  

    <asp:SqlDataSource ID="STSfabTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_STS">
         
    </asp:SqlDataSource> 
               <%-- END STS  PIVOT--%>

       <%--START DYCC-7  PIVOT--%>
    <asp:SqlDataSource ID="DYCC7spgnTableDataSrouce" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_SG_DYCC7">
         
    </asp:SqlDataSource>  

    <asp:SqlDataSource ID="DYCC7fabTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PIVOT_SPL_FAB_DYCC7">
         
    </asp:SqlDataSource> 
               <%-- END DYCC-7  PIVOT--%>

    <%--END PIVOT TABLES OF SG AND FAB--%>


</asp:Content>

