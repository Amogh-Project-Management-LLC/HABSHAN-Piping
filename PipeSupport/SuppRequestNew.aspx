<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SuppRequestNew.aspx.cs" Inherits="PipeSupport_SuppRequestNew" Title="Support Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="80px"
                                CausesValidation="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                Width="80px"/>
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
                                <td style="width: 140px; background-color: whitesmoke;">Request Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txtJcNumber" runat="server" Width="200px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="JcNumberValidator" runat="server" ControlToValidate="txtJcNumber"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: whitesmoke;">Request Date
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
                                <td style="width: 140px; background-color: whitesmoke;">Remarks
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
</asp:Content>