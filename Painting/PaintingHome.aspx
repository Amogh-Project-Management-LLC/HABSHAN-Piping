<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PaintingHome.aspx.cs" Inherits="Painting_PaintingHome" Title="Painting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;" class="biglinks">
        <tr>
            <td>
                <asp:LinkButton ID="btnPaintingRepA" runat="server" Text="Material available for Painting Jobcard vs Issued"
                    OnClick="btnPaintingRepA_Click"></asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>
