<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_RequesSelect.aspx.cs" Inherits="Isome_IsomeTransSelect" Title="NDT" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnBack_Click1" Text="Back" Width="85px" />
                        </td>
                        <td>
                            <asp:Button ID="btnContinue" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnContinue_Click" Text="Request" Width="85px" />
                        </td>
                        <td>
                            <asp:Button ID="btnStatus" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Status" Width="85px" OnClick="btnStatus_Click" />
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnPenalty" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                        Text="Penalty Selection" Width="120px" onclick="btnPenalty_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td style="width: 100%;" align="right">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <telerik:RadTextBox ID="txtDate" runat="server" Width="100px" EmptyMessage="Report Date"></telerik:RadTextBox>
                                    <cc1:CalendarExtender ID="calExtender5" runat="server" PopupButtonID="btnDate" PopupPosition="BottomRight"
                                        OnClientShowing="DisplayDateToday" TargetControlID="txtDate" Format="dd-MMM-yyyy">
                                    </cc1:CalendarExtender>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td>
                            <asp:ImageButton ID="btnDate" ImageUrl="~/images/pdate.gif" runat="server" />
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                    <telerik:RadTextBox EmptyMessage="NDE Report No" ID="txtRepNo" runat="server" Width="180px"></telerik:RadTextBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                Select the NDT type below:
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:RadioButtonList ID="NdeList" runat="server" DataSourceID="NdeTypeDataSource"
                            DataTextField="NDE_TITLE" DataValueField="NDE_TYPE_ID" CssClass="RadioList" AutoPostBack="True"
                            OnSelectedIndexChanged="NdeList_SelectedIndexChanged">
                        </asp:RadioButtonList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="NdeTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT NDE_TYPE_ID, NDE_TYPE, NDE_DESCR, NDE_TITLE FROM VIEW_NDE_TITLE ORDER BY NDE_TYPE'>
    </asp:SqlDataSource>
</asp:Content>
