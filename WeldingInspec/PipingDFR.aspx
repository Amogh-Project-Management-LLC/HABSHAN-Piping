<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PipingDFR.aspx.cs" Inherits="WeldingInspec_DailyFitupEntry" Title="Daily Piping Fitup" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Src="~/UserControls/NotificationBox.ascx" TagPrefix="uc1" TagName="NotificationBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 3px; background-color: whitesmoke;">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <uc1:NotificationBox runat="server" ID="NotificationBox" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <table style="width: 100%">
        <tr>
            <td style="vertical-align: top;">
                <asp:UpdatePanel ID="leftPanelUpdatePanel" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Weld Subcon</td>
                                <td>
                                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="200px">
                                        <asp:ListItem Selected="True" Value="99">(Subcon)</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Isometric </td>
                                <td>
                                    <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged" Width="250px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="isomeValidator" runat="server" ControlToValidate="txtIsome" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Joint No
                                </td>
                                <td>
                                    <asp:DropDownList ID="cboJoints" runat="server" Width="400px" AutoPostBack="True"
                                        DataSourceID="jointsDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                        OnSelectedIndexChanged="cboJoints_SelectedIndexChanged" AppendDataBoundItems="True" OnDataBinding="cboJoints_DataBinding">
                                        <asp:ListItem Selected="True" Value="-1">(Select Joint)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="jointValidator" runat="server" ControlToValidate="cboJoints"
                                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Fitup Date
                                </td>
                                <td>

                                    <telerik:RadDatePicker ID="txtFitupDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Culture="en-US">
                                    </telerik:RadDatePicker>

                                    <asp:RequiredFieldValidator ID="FitupDateValidator" runat="server" ControlToValidate="txtFitupDate"
                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Fitup Report No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtReportNo" runat="server" Width="140px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reportValidator" runat="server" ControlToValidate="txtReportNo"
                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Heat Number 1
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddHeatNo1" runat="server" DataSourceID="heat1DataSource" DataTextField="HEAT_NO"
                                        DataValueField="HEAT_NO" OnDataBound="ddHeatNo1_DataBound" Width="150px" AppendDataBoundItems="True" OnDataBinding="ddHeatNo1_DataBinding">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Heat Number 2
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddHeatNo2" runat="server" DataSourceID="heat2DataSource" DataTextField="HEAT_NO"
                                        DataValueField="HEAT_NO" Width="150px" OnDataBound="ddHeatNo2_DataBound" AppendDataBoundItems="True" OnDataBinding="ddHeatNo2_DataBinding">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: Gainsboro">Inspector Code
                                </td>
                                <td>
                                    <asp:TextBox ID="txtInsp" runat="server" Width="140px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:DetailsView ID="jointDetailsView" runat="server" AutoGenerateRows="False" CaptionAlign="Left"
                            DataSourceID="jointDetailsDataSource" Width="500px" HorizontalAlign="Right" SkinID="DetailsViewSkin">
                            <HeaderTemplate>
                                Joint Details
                            </HeaderTemplate>
                            <Fields>
                                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" />
                                <asp:BoundField DataField="ISO_REV" HeaderText="Isometric Rev" SortExpression="ISO_REV" />
                                <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                                <asp:BoundField DataField="SPOOL" HeaderText="Spool Piece" SortExpression="SPOOL" />
                                <asp:BoundField DataField="WO_NAME" HeaderText="Job Card No" SortExpression="WO_NAME" />
                                <asp:BoundField DataField="JOINT_NO" HeaderText="Joint Number" SortExpression="JOINT_NO" />
                                <asp:BoundField DataField="JNT_REV_CODE" HeaderText="Joint-Rev" SortExpression="JNT_REV_CODE" />
                                <asp:BoundField DataField="JOINT_TYPE" HeaderText="Joint Type" SortExpression="JOINT_TYPE" />
                                <asp:BoundField DataField="JOINT_SIZE" HeaderText="Joint Size" SortExpression="JOINT_SIZE" />
                                <asp:BoundField DataField="HEAT_NO1" HeaderText="Heat Number 1" SortExpression="HEAT_NO1" />
                                <asp:BoundField DataField="HEAT_NO2" HeaderText="Heat Number 2" SortExpression="HEAT_NO2" />
                                <asp:BoundField DataField="TRACER" HeaderText="Tracer" SortExpression="TRACER" />
                                <asp:BoundField DataField="DIS_FLG" HeaderText="Dissimilar" SortExpression="DIS_FLG" />
                                <asp:BoundField DataField="CAT_NAME" HeaderText="Category" SortExpression="CAT_NAME" />
                                <asp:BoundField DataField="COMMODITY1" HeaderText="Mat Code1" SortExpression="COMMODITY1" />
                                <asp:BoundField DataField="COMMODITY2" HeaderText="Mat Code2" SortExpression="COMMODITY2" />
                            </Fields>
                        </asp:DetailsView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="matId1Field" runat="server" />
            <asp:HiddenField ID="matId2Field" runat="server" />
            <asp:HiddenField ID="bomId1Field" runat="server" />
            <asp:HiddenField ID="bomId2Field" runat="server" />
            <asp:HiddenField ID="IsoIdField" runat="server" />
            <asp:HiddenField ID="hnTypeField" runat="server" />
            <asp:HiddenField ID="unqPartField" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="jointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, JOINT_TITLE FROM VIEW_JOINTS_SIMPLE WHERE (PROJ_ID = :PROJECT_ID) AND (FITUP_DATE IS NULL) AND (ISO_TITLE1 = :ISO_TITLE) AND (SUB_CON_ID = :SC_ID) AND (DFR_DWR_FLG = 'Y') ORDER BY JOINT_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="jointDetailsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, ISO_TITLE1, ISO_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK, HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, TRACER, DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE, COMMODITY1, COMMODITY2 FROM VIEW_TOTAL_JOINTS WHERE (JOINT_ID = :JOINT_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboJoints" DefaultValue="-1" Name="JOINT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
WHERE PROJ_ID = :PROJECT_ID
ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="heat1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT HEAT_NO FROM VIEW_MAT_HEAT_NO_MTC WHERE (MAT_ID = :MAT_ID) ORDER BY HEAT_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="matId1Field" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="heat2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT HEAT_NO FROM VIEW_MAT_HEAT_NO_MTC WHERE (MAT_ID = :MAT_ID) ORDER BY HEAT_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="matId2Field" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>