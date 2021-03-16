<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TackWeldEntry.aspx.cs"
    MasterPageFile="~/MasterPage.master" Inherits="WeldingInspec_TackWeldEntry" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <telerik:RadLinkButton ID="back"  runat="server" Text="Back" NavigateUrl="PipingDFWR.aspx"></telerik:RadLinkButton>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 100%;vertical-align:top;">
                    <table runat="server">
                        <tr>
                            <td>
                                <telerik:RadLabel Text="Sub Contractor" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDropDownList runat="server" ID="ddlSubcon" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME"
                                    DataValueField="SUB_CON_ID" AutoPostBack="true" CausesValidation="false" Width="200px">
                                    <Items>
                                        <telerik:DropDownListItem Value="-1" Text="Select SubCon" Selected="true" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblTWReport" Text="Tack Weld Report" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtTWRep" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTWRep"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblTWDate" Text="Tack Weld Date" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txTWDate" runat="server" Width="200px">
                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txTWDate"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblISOJnt" Text="Isometric-Joint" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbTWJoint" Text="ISO/Joint/CRWCode" DataSourceID="TWjointsDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                    runat="server" AllowCustomText="true" Filter="Contains" AutoPostBack="true" Width="200px" CausesValidation="false" OnSelectedIndexChanged="rcbTWJoint_SelectedIndexChanged">
                                </telerik:RadComboBox>
                                <asp:CompareValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rcbTWJoint" ValueToCompare="ISO/Joint/CRWCode" Operator="NotEqual"
                                    ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                            </td>
                        </tr>


                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblHN1" Text="Heat No1" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbHeatNo1" runat="server" DataSourceID="HeatNo1DataSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                    Filter="Contains" AllowCustomText="true" Text="Select Heat No1" AutoPostBack="true" Enabled="false" Width="200px">
                                </telerik:RadComboBox>
                                <telerik:RadTextBox ID="txtSuppHeatNo1" runat="server" Width="200px" Visible="false"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblHN2" Text="Heat No2" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbHeatNo2" runat="server" DataSourceID="HeatNo2DataSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                    Filter="Contains" AllowCustomText="true" Text="Select Heat NO2" Enabled="false" Width="200px">
                                </telerik:RadComboBox>
                                <telerik:RadTextBox ID="txtSuppHeatNo2" runat="server" Visible="false" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>


                        <tr>
                            <td>
                                <telerik:RadButton ID="TWSave" runat="server" Text="Save" OnClick="TWSave_Click"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="text-align: left; vertical-align: top;">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:DetailsView ID="jointDetailsView" runat="server" AutoGenerateRows="False" CaptionAlign="Left"
                                DataSourceID="jointDetailsDataSource1" Width="400px" HorizontalAlign="Right" CssClass="DataWebControlStyle"
                                GridLines="None" Font-Size="10pt" Font-Names="Calibri">
                                <Fields>
                                    <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" />
                                    <asp:BoundField DataField="ISO_REV" HeaderText="Isometric Rev" SortExpression="ISO_REV" />
                                    <asp:BoundField DataField="JC_REV" HeaderText="JobCard Rev" SortExpression="JC_REV" />
                                    <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                                    <asp:BoundField DataField="SPOOL" HeaderText="Spool Piece" SortExpression="SPOOL" />
                                    <asp:BoundField DataField="WO_NAME" HeaderText="Job Card No" SortExpression="WO_NAME" />
                                    <asp:BoundField DataField="JOINT_NO" HeaderText="Joint Number" SortExpression="JOINT_NO" />
                                    <asp:BoundField DataField="CRW_CODE" HeaderText="Suffix" SortExpression="CRW_CODE" />
                                    <asp:BoundField DataField="JNT_REV_CODE" HeaderText="REV CODE" SortExpression="JNT_REV_CODE" />
                                    <asp:BoundField DataField="JOINT_TYPE" HeaderText="Joint Type" SortExpression="JOINT_TYPE" />
                                    <asp:BoundField DataField="JOINT_SIZE" HeaderText="Joint Size" SortExpression="JOINT_SIZE" />
                                    <asp:BoundField DataField="SCHEDULE" HeaderText="Schedule" SortExpression="SCHEDULE" />
                                    <asp:BoundField DataField="JOINT_THK" HeaderText="Joint Thick" SortExpression="JOINT_THK" />
                                    <asp:BoundField DataField="HEAT_NO1" HeaderText="Heat Number 1" SortExpression="HEAT_NO1" />
                                    <asp:BoundField DataField="HEAT_NO2" HeaderText="Heat Number 2" SortExpression="HEAT_NO2" />
                                    <asp:BoundField DataField="TRACER" HeaderText="Tracer" SortExpression="TRACER" />
                                    <asp:BoundField DataField="DIS_FLG" HeaderText="Dissimilar" SortExpression="DIS_FLG" />
                                    <asp:BoundField DataField="WPS_NO" HeaderText="WPS" SortExpression="WPS_NO" />
                                    <asp:BoundField DataField="CAT_NAME" HeaderText="Category" SortExpression="CAT_NAME" />
                                    <asp:BoundField DataField="COMMODITY1" HeaderText="Mat Code1" SortExpression="COMMODITY1" />
                                    <asp:BoundField DataField="COMMODITY2" HeaderText="Mat Code2" SortExpression="COMMODITY2" />
                                    <asp:BoundField DataField="SPL_SWN_DT" HeaderText="Spool SWN Date" SortExpression="SPL_SWN_DT"
                                        DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />
                                    <asp:BoundField DataField="SPL_REL_DT" HeaderText="Spool Release Date" SortExpression="SPL_REL_DT"
                                        DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" />
                                </Fields>
                                <EmptyDataTemplate>Select a joint to get its' details !</EmptyDataTemplate>
                                <AlternatingRowStyle CssClass="AlternatingRowStyle" BackColor="White" />
                                <FieldHeaderStyle Width="250px" VerticalAlign="Top" />
                                <FooterStyle BackColor="#0678e3" ForeColor="Black" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                                <PagerStyle BackColor="#E7E7FF" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#eff6fc" ForeColor="Black" VerticalAlign="Top" />
                            </asp:DetailsView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>


        <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="TWjointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||JOINT_NO||'/'||CRW_CODE AS JOINT_TITLE, JOINT_ID FROM VIEW_ADAPTER_JOINTS
                            WHERE (PROJ_ID = :PROJECT_ID)
                            AND (TW_DATE IS NULL)
                            AND (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                            OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                            AND  JNT_REV_CODE  NOT  IN  ('D','N')
                            AND TW_FLG='Y'
                            ORDER BY ISO_ID, JOINT_TITLE">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="itemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||PT_NO ITEM,BOM_ID FROM VIEW_ISO_BOM_LINK"></asp:SqlDataSource>

        <asp:SqlDataSource ID="HeatNo1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT DISTINCT HEAT_NO FROM VIEW_MRIR_HN WHERE MAT_ID=:MAT_ID1">
            <SelectParameters>
                <asp:ControlParameter DefaultValue="-1" Name="MAT_ID1" ControlID="hiddenMat1" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hiddenMat1" runat="server" />
        <asp:SqlDataSource ID="HeatNo2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT DISTINCT HEAT_NO FROM VIEW_MRIR_HN WHERE MAT_ID=:MAT_ID2">
            <SelectParameters>
                <asp:ControlParameter DefaultValue="-1" Name="MAT_ID2" ControlID="hiddenMat2" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hiddenMat2" runat="server" />


        <asp:SqlDataSource ID="FitupInspDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT INSP_CODE FROM PIP_INSPECTOR WHERE SUB_CON_ID=:SC_ID AND TYPE_ID=1">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
       <asp:SqlDataSource ID="jointDetailsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK, HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER, FILL_CAP_WELDER, CRW_CODE, TRACER, DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE, COMMODITY1, COMMODITY2, SPL_SWN_DT, SPL_REL_DT FROM VIEW_TOTAL_JOINTS WHERE (JOINT_ID = :JOINT_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="rcbTWJoint" DefaultValue="-1" Name="JOINT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    </div>
</asp:Content>
