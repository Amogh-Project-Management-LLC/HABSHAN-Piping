<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipingDWR.aspx.cs" Inherits="WeldingInspec_DailyFitupEntry"
    Title="Welding Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Src="~/UserControls/NotificationBox.ascx" TagPrefix="uc1" TagName="NotificationBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 3px; background-color: gainsboro;">
        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
            <ContentTemplate>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                        </td>
                        <td style="text-align: right;">
                            <telerik:RadButton ID="btnUpdateWelders" runat="server" CausesValidation="false"
                                Text="Update Joint Welders" Width="130px" OnClick="btnUpdateWelders_Click" Skin="Sunset">
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <uc1:NotificationBox runat="server" ID="NotificationBox" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Subcon</td>
                        <td>
                            <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="200px" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="99">(Subcon)</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Isometric </td>
                        <td>
                            <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="isomeValidator" runat="server" ControlToValidate="txtIsome" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Joint No
                        </td>
                        <td>
                            <asp:DropDownList ID="cboJoints" runat="server" Width="350px" AutoPostBack="True"
                                DataSourceID="jointsDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                AppendDataBoundItems="True" OnDataBinding="cboJoints_DataBinding" OnSelectedIndexChanged="cboJoints_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="-1">(Select Joint)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="jointValidator" runat="server" ControlToValidate="cboJoints"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Rework Code</td>
                        <td>
                            <asp:DropDownList ID="ddReworkCode" runat="server" DataSourceID="ReworkCodeDataSource" DataTextField="REWORK_CODE" DataValueField="REWORK_CODE" Width="100px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">WPS Number
                        </td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="WPS_NO_RadAutoCompleteBox" InputType="Text" DropDownHeight="300px" runat="server" DataSourceID="wpsDataSource"
                                DataTextField="WPS_NO1" DataValueField="WPS_NO1" Filter="StartsWith" MinFilterLength="2" Width="200px"
                                AllowCustomEntry="True">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Weld Date
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="txtWeldDate" runat="server" Culture="en-US" DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="WeldDateValidator" runat="server" ControlToValidate="txtWeldDate" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Weld Report No
                        </td>
                        <td>
                            <asp:TextBox ID="txtReportNo" runat="server" Width="120px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reportValidator" runat="server" ControlToValidate="txtReportNo"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Welder No</td>
                        <td>
                            <asp:DropDownList ID="ddWelder" runat="server" AppendDataBoundItems="True" DataSourceID="weldersDataSource" DataTextField="WELDER_NO" DataValueField="WELDER_ID" Width="150px" OnDataBinding="ddWelder_DataBinding">
                                <asp:ListItem Text="Welder No" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="WelderNoValidator" runat="server" ControlToValidate="ddWelder" ErrorMessage="*" ForeColor="Red" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Welding Pass</td>
                        <td>
                            <asp:DropDownList ID="ddWelderPass" runat="server" AppendDataBoundItems="True" DataSourceID="weldingPassDataSource" DataTextField="WELD_PASS" DataValueField="PASS_ID" Width="120px">
                                <asp:ListItem Text="Pass" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="PassValidator" runat="server" ControlToValidate="ddWelderPass" ErrorMessage="*" ForeColor="Red" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Inspector Code
                        </td>
                        <td>
                            <asp:TextBox ID="txtInsp" runat="server" Width="120px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: Gainsboro">Weld Process</td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="WeldProcess_RadAutoCompleteBox" runat="server" AllowCustomEntry="True" DataSourceID="WeldProcessDataSource" DataTextField="WELD_PROCESS" DataValueField="WELD_PROCESS" DropDownHeight="300px" Filter="StartsWith" InputType="Text" MinFilterLength="2" Width="200px">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>

                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="SpoolWeldingObjectDataSource">
                    <ValidationSettings EnableValidation="false" EnableModelValidation="false" ValidationGroup="New" />
                    <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="True" DataKeyNames="JOINT_ID,REWORK_CODE,WELDER_ID,PASS_ID" DataSourceID="SpoolWeldingObjectDataSource"
                        EditFormSettings-EditColumn-ButtonType="ImageButton" EditMode="InPlace" HierarchyLoadMode="Client" PageSize="15">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" ItemStyle-Width="20px">
                            </telerik:GridButtonColumn>

                            <telerik:GridTemplateColumn DataField="REWORK_CODE" FilterControlAltText="Filter REWORK_CODE column" HeaderText="Rework Code" SortExpression="REWORK_CODE" UniqueName="REWORK_CODE">
                                <ItemTemplate>
                                    <asp:Label ID="LabelReworkCode" runat="server" Text='<%# Bind("REWORK_CODE") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddReworkCodeEdit" runat="server" Width="100px"
                                        DataSourceID="ReworkCodeDataSource" DataTextField="REWORK_CODE" DataValueField="REWORK_CODE" SelectedValue='<%# Bind("REWORK_CODE") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="WELD_REP_NO" FilterControlAltText="Filter WELD_REP_NO column" HeaderText="Weld Report No" SortExpression="WELD_REP_NO" UniqueName="WELD_REP_NO">
                            </telerik:GridBoundColumn>

                            <telerik:GridDateTimeColumn DataField="WELD_DATE" FilterControlAltText="Filter WELD_DATE column" HeaderText="Weld Date" SortExpression="WELD_DATE" UniqueName="WELD_DATE"
                                DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" EditDataFormatString="dd-MMM-yyyy">
                            </telerik:GridDateTimeColumn>

                            <telerik:GridBoundColumn DataField="INSPECTOR_CODE" FilterControlAltText="Filter INSPECTOR_CODE column" HeaderText="Inspector Code" SortExpression="INSPECTOR_CODE" UniqueName="INSPECTOR_CODE">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="WELDER_NO" FilterControlAltText="Filter WELDER_NO column" HeaderText="Welder Code" SortExpression="WELDER_NO" UniqueName="WELDER_NO">
                                <ItemTemplate>
                                    <asp:Label ID="LabelWelderNo" runat="server" Text='<%# Bind("WELDER_NO") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddRWelderNoEdit" runat="server" Width="100px"
                                        DataSourceID="weldersDataSource" DataTextField="WELDER_NO" DataValueField="WELDER_ID" SelectedValue='<%# Bind("WELDER_ID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="W_NAME" FilterControlAltText="Filter W_NAME column" HeaderText="Welder Name" SortExpression="W_NAME" UniqueName="W_NAME" ReadOnly="true">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="WELD_PASS" FilterControlAltText="Filter WELD_PASS column" HeaderText="Pass" SortExpression="WELD_PASS" UniqueName="WELD_PASS">
                                <ItemTemplate>
                                    <asp:Label ID="LabelWelderPass" runat="server" Text='<%# Bind("WELD_PASS") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddRWelderPassEdit" runat="server" Width="100px"
                                        DataSourceID="weldingPassDataSource" DataTextField="WELD_PASS" DataValueField="PASS_ID" SelectedValue='<%# Bind("PASS_ID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="WELD_PROCESS" FilterControlAltText="Filter WELD_PROCESS column" HeaderText="Process" SortExpression="WELD_PROCESS" UniqueName="WELD_PROCESS">
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:HiddenField ID="weldProcessCtrlField" runat="server" />

    <asp:SqlDataSource ID="jointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, JOINT_TITLE FROM VIEW_JOINTS_SIMPLE WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE) AND (SUB_CON_ID = :SC_ID) AND (DFR_DWR_FLG = 'Y') ORDER BY JOINT_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE" PropertyName="Text" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="wpsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WPS_ID, WPS_NO1
FROM PIP_WPS_NO
WHERE (PROJECT_ID = :PROJECT_ID) AND (SC_ID = :SC_ID)
ORDER BY WPS_NO1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="weldersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS WHERE (PROJECT_ID = :PROJECT_ID) AND (SC_ID = :SC_ID) ORDER BY WELDER_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="weldingPassDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PASS_ID, WELD_PASS FROM PIP_WELDING_PASS ORDER BY PASS_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="WeldProcessDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELD_PROCESS FROM PIP_WELD_PROCESS ORDER BY WELD_PROCESS"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ReworkCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, REWORK_CODE FROM PIP_NDE_REWORK_CODE WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY REWORK_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="SpoolWeldingObjectDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsWeldingATableAdapters.VIEW_SPOOL_WELDINGTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="Original_PASS_ID" Type="Decimal" />
            <asp:Parameter Name="Original_REWORK_CODE" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboJoints" DefaultValue="-1" Name="JOINT_ID" PropertyName="SelectedValue" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="REWORK_CODE" Type="String" />
            <asp:Parameter Name="PASS_ID" Type="Decimal" />
            <asp:Parameter Name="WELD_REP_NO" Type="String" />
            <asp:Parameter Name="WELD_DATE" Type="DateTime" />
            <asp:Parameter Name="INSPECTOR_CODE" Type="String" />
            <asp:Parameter Name="WELD_PROCESS" Type="String" />
            <asp:Parameter Name="Original_JOINT_ID" Type="Decimal" />
            <asp:Parameter Name="Original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="Original_PASS_ID" Type="Decimal" />
            <asp:Parameter Name="Original_REWORK_CODE" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>