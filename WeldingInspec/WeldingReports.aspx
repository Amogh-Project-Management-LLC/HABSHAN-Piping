<%@ Page Language="C#" Title="Welding Reports" AutoEventWireup="true" CodeFile="WeldingReports.aspx.cs" MasterPageFile="~/MasterPage.master" Inherits="WeldingInspec_WeldingReports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="right_content" style="width: 1130px;">
        <div class="menu-div">
            <telerik:RadMenu ID="HeaderMenu" runat="server" OnItemClick="HeaderMenu_ItemClick" Skin="Office2010Blue" Width="100%" CausesValidation="false">
                <Items>
                    <telerik:RadMenuItem Text="Back" Value="back" ImageUrl="~/App_Themes/BlueTheme/images/icons/back_menu.png"></telerik:RadMenuItem>
                </Items>
            </telerik:RadMenu>
        </div>
        <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>--%>
        <div class="contact-area" style="width: 720px; font-family: Calibri; font-size: medium; height: 300px;">

            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnPreview">
                <table style="vertical-align: top; width: 100%;">
                    <tr>
                        <td class="auto-style2">Subcon</td>
                        <td>:</td>
                        <td>
                            <telerik:RadComboBox ID="cboSubcon" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="200px" CausesValidation="false" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Selected="True" Text="Select Subcon" Value="" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Download Option</td>
                        <td>:</td>
                        <td>
                            <telerik:RadComboBox ID="rdoOptions" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rdoOptions_SelectedIndexChanged" Width="200px">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Select Option" Value="-1" />
                                    <telerik:RadComboBoxItem Text="Individual Report" Value="individual" />
                                    <telerik:RadComboBoxItem Text="Weld Entry Range" Value="entrydate"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Weld Date Range" Value="welddate"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Fitup Entry Range" Value="fitupentry"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Fitup Date Range" Value="fitupdate"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="Isometric" Value="isometric"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr id="tblIndividual" runat="server" visible="false">
                        <td class="auto-style2">Weld Report Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtWeldRepNo" runat="server" Width="200px" AutoPostBack="true" OnTextChanged="txtWeldRepNo_TextChanged" EmptyMessage="Search Weld Report">
                            </telerik:RadTextBox>
                            <telerik:RadComboBox ID="ddWeldRepNo" runat="server" DataSourceID="dsWeldReports" DataTextField="WELD_REP_NO"
                                DataValueField="WELD_REP_NO" AppendDataBoundItems="true" AutoPostBack="true" CausesValidation="false" Width="200px">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr id="tblEntryDate" runat="server" visible="false">
                        <td class="auto-style2">Entry Date Range</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtEntryFromDate" runat="server" DateInput-EmptyMessage="From Date">
                                <DateInput ID="DateInput1" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <telerik:RadDatePicker ID="txtEntryToDate" runat="server" DateInput-EmptyMessage="To Date">
                                <DateInput ID="DateInput2" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr id="tblWeldDate" runat="server" visible="false">
                        <td class="auto-style2">Weld Date Range</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtWeldFromDate" runat="server" DateInput-EmptyMessage="From Date">
                                <DateInput ID="DateInput3" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy" Repeatable="Today">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <telerik:RadDatePicker ID="txtWeldToDate" runat="server" DateInput-EmptyMessage="To Date">
                                <DateInput ID="DateInput4" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr id="tblInspDate" runat="server" visible="false">
                        <td class="auto-style2">Insp Date Range</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtInspFromDate" runat="server" DateInput-EmptyMessage="From Date">
                                <DateInput ID="DateInput5" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <telerik:RadDatePicker ID="txtInspToDate" runat="server" DateInput-EmptyMessage="To Date">
                                <DateInput ID="DateInput6" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                     <tr id="tblFitupDate" runat="server" visible="false">
                        <td class="auto-style2">Fitup Date Range</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtFitupFromDate" runat="server" DateInput-EmptyMessage="From Date">
                                <DateInput ID="DateInput7" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <telerik:RadDatePicker ID="txtFitupToDate" runat="server" DateInput-EmptyMessage="To Date">
                                <DateInput ID="DateInput8" runat="server" DateFormat="dd-MMM-yyyy" DisplayDateFormat="dd-MMM-yyyy">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr id="tblIsometric" runat="server" visible="false">
                        <td class="auto-style2">Isometric</td>
                        <td>:</td>
                        <td>
                            <telerik:RadComboBox ID="rcbisoList" runat="server" AllowCustomText="true" EnableCheckAllItemsCheckBox="true" CheckBoxes="true"
                                DataSourceID="dsIsoReport" DataTextField="ISO_TITLE1" DataValueField="ISO_ID">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: center;">
                            <telerik:RadButton ID="btnPreview" runat="server" OnClick="btnPreview_Click" Text="Preview"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
                <div style="text-align: center; color: green; font-weight: bold; height: 25px; font-size: medium; vertical-align: baseline;">
                    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                </div>
            </asp:Panel>
        </div>

        <%--  </ContentTemplate>
        </asp:UpdatePanel>--%>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="false">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsWeldReports" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELD_REP_NO FROM VIEW_WELDING_REPORT WHERE (WELD_REP_NO IS NOT NULL) AND (PROJECT_ID = :PROJECT_ID) AND (SUB_CON_ID = :SUB_CON) AND (WELD_REP_NO LIKE '%%' || :SEARCH || '%') GROUP BY WELD_REP_NO ORDER BY WELD_REP_NO">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="cboSubcon" DefaultValue="~" Name="SUB_CON" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtWeldRepNo" DefaultValue="%" Name="SEARCH" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="dsIsoReport" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISO_TITLE1,ISO_ID FROM view_welding_report WHERE  (PROJECT_ID = :PROJECT_ID) AND (SUB_CON_ID = :SUB_CON)">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="cboSubcon" DefaultValue="~" Name="SUB_CON" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
