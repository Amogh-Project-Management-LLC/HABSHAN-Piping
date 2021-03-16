<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="BomRequestNew.aspx.cs" Inherits="PipeSupport_BomRequestNew" Title="Material Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="80px"
                                BackColor="SkyBlue" BorderColor="SteelBlue" CausesValidation="False" />
                        </td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                Width="80px" BackColor="SkyBlue" BorderColor="SteelBlue" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table class="TableStyle" style="width: 100%">
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Request Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txtJcNumber" runat="server" Width="200px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="JcNumberValidator" runat="server" ControlToValidate="txtJcNumber"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Request Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIssueDate" runat="server" Width="100px"></asp:TextBox>
                                    <cc1:CalendarExtender ID="calExtender5" runat="server" Format="dd-MMM-yyyy" OnClientShowing="DisplayDateToday"
                                        PopupButtonID="btnDate" PopupPosition="BottomRight" TargetControlID="txtIssueDate">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="btnDate" runat="server" ImageUrl="~/images/pdate.gif" />
                                    <asp:RequiredFieldValidator ID="issueDateValidator" runat="server" ControlToValidate="txtIssueDate"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Subcon
                                </td>
                                <td>
                                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="135px">
                                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Area
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPCWBS" runat="server" Width="100px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Remarks
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRem" runat="server" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
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
</asp:Content>