<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SelectDateFromTo.aspx.cs" Inherits="Painting_SelectDateFromTo" Title="Painting Reports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 50%; background-color: #99ccff;">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    CausesValidation="False" OnClick="btnBack_Click" Text="Back" Width="82px" />
            </td>
        </tr>
        <tr>
            <td style="width: 50%">
                <table style="width: 100%">
                    <tr>
                        <td style="background-color: #ccccff; width: 120px;">
                            <asp:Label ID="Label1" runat="server" Text="Date From:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDateFrom" runat="server" Width="115px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="dateFromValidator" runat="server" ControlToValidate="txtDateFrom"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                            <cc1:CalendarExtender ID="calExtender5" runat="server" PopupButtonID="btnDate" PopupPosition="BottomRight"
                                OnClientShowing="DisplayDateToday" TargetControlID="txtDateFrom" Format="dd-MMM-yyyy">
                            </cc1:CalendarExtender>
                            <asp:ImageButton ID="btnDate" ImageUrl="~/images/pdate.gif" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label3" runat="server" Text="Date To:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDateTo" runat="server" Width="115px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="dateToValidator" runat="server" ControlToValidate="txtDateTo"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="ImageButton1"
                                PopupPosition="BottomRight" OnClientShowing="DisplayDateToday" TargetControlID="txtDateTo"
                                Format="dd-MMM-yyyy">
                            </cc1:CalendarExtender>
                            <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/pdate.gif" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 50%; background-color: #99ccff;">
                <asp:Button ID="btnPreview" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    OnClick="btnPreview_Click" Text="Preview" Width="83px" />
            </td>
        </tr>
    </table>
</asp:Content>
