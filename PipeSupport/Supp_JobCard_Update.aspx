<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_JobCard_Update.aspx.cs" Inherits="Supp_JobCard_Update" Title="Support Job Card Update" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdate" runat="server" Text="Update Now" Width="120" OnClick="btnUpdate_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 100%">
        <asp:CheckBoxList ID="UpdateList" runat="server" Width="200px">
            <asp:ListItem Selected="True" Value="2">Support Material Take off</asp:ListItem>
            <asp:ListItem Selected="True" Value="3">Support Weight</asp:ListItem>
        </asp:CheckBoxList>
    </div>
</asp:Content>