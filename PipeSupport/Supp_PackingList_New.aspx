<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_PackingList_New.aspx.cs" Inherits="Supp_JobCard_New" Title="Support Job Card" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Packing List Number
                        </td>
                        <td>
                            <asp:TextBox ID="txtJcNumber" runat="server" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="JcNumberValidator" runat="server" ControlToValidate="txtJcNumber"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Ship No
                        </td>
                        <td>
                            <asp:TextBox ID="txtShipNo" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Pallet No
                        </td>
                        <td>
                            <asp:TextBox ID="txtPalletNo" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Create By
                        </td>
                        <td>
                            <asp:TextBox ID="txtIssuedBy" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Issue Date
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Remarks
                        </td>
                        <td>
                            <asp:TextBox ID="txtRem" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>