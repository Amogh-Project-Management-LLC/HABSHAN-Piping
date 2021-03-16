<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="WPS_Register.aspx.cs" Inherits="WeldingInspec_WPS_Register" Title="WPS" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server"
                                Text="Back" Width="80px" CausesValidation="False" OnClick="btnBack_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server"
                                Text="Submit" Width="80px" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label1" runat="server" Text="WPS Number1:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtWPS1" runat="server" Width="150px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="wps1FieldValidator" runat="server" ErrorMessage="*"
                                ControlToValidate="txtWPS1"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label2" runat="server" Text="WPS Number2:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtWPS2" runat="server" Width="150px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label4" runat="server" Text="Revision:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRevision" runat="server" Width="60px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label5" runat="server" Text="Subcon:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                                Width="150px">
                            </telerik:RadComboBox>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                     <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="AllsubconLabel" runat="server" Text="Common WPS (Y/N):"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="AllsubconRadioButton" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Y" Value="Y" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="N" Value="N" ></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label6" runat="server" Text="Material:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboMatList" runat="server" AllowCustomText="True" DataSourceID="sqlMatSource" DataTextField="MAT_TYPE" DataValueField="MAT_TYPE" Filter="Contains"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label7" runat="server" Text="Process:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboProcessList" runat="server" AllowCustomText="True" DataSourceID="sqlProcessSource" DataTextField="WELD_PROCESS" DataValueField="WELD_PROCESS" Filter="Contains"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label8" runat="server" Text="PWHT(Y/N):"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="radPWHTList" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                <asp:ListItem Text="N" Value="N" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label9" runat="server" Text="Size :"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtSizeFrom" runat="server" Width="95px" EmptyMessage="Size From.."></telerik:RadTextBox>

                            <telerik:RadTextBox ID="txtSizeTo" runat="server" Width="95px" EmptyMessage="Size To.."></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label11" runat="server" Text="Thickness :"></asp:Label>
                        </td>
                        <td class="TableStyle">
                            <telerik:RadTextBox ID="txtThkFrom" runat="server" Width="95px" EmptyMessage="Thick From.."></telerik:RadTextBox>

                            <telerik:RadTextBox ID="txtThkTo" runat="server" Width="95px" EmptyMessage="Thick To.."></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label13" runat="server" Text="Connection :"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboConnA" runat="server" Width="140px">
                                <Items>
                                    <telerik:RadComboBoxItem Selected="True" Text="(Connection A)"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="PIPE" Value="PIPE"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="FITTING" Value="FITTING"></telerik:RadComboBoxItem>
                                </Items>

                            </telerik:RadComboBox>

                            <telerik:RadComboBox ID="cboConnB" runat="server" Width="140px">
                                 <Items>
                                    <telerik:RadComboBoxItem Selected="True" Text="(Connection B)"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="PIPE" Value="PIPE"></telerik:RadComboBoxItem>
                                    <telerik:RadComboBoxItem Text="FITTING" Value="FITTING"></telerik:RadComboBoxItem>
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label15" runat="server" Text="PIPE Class:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboPipeClass" runat="server" AllowCustomText="True" CheckBoxes="True" DataSourceID="sqlPipingClass" DataTextField="PIPING_CLASS" DataValueField="PIPING_CLASS"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label18" runat="server" Text="Remarks:"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="471px"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_TYPE
FROM PIP_MAT_TYPE
WHERE PROJ_ID = :PROJ_ID
ORDER BY MAT_TYPE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlProcessSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELD_PROCESS FROM PIP_WELD_PROCESS ORDER BY WELD_PROCESS"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPipingClass" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PIPING_CLASS FROM PIPING_SPECS ORDER BY PIPING_CLASS"></asp:SqlDataSource>
</asp:Content>
