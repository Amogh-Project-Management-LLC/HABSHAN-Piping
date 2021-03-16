<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProjectBasicData.aspx.cs" Inherits="Home_ProjectBasicData" Title="Project Basic Data" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td style="vertical-align: top">
                <table style="width: 100%" class="biglinks">
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnPMS" runat="server"  Font-Underline="false" CssClass="bglinks" OnClick="btnPMS_Click"> Piping Specs (PMS)</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnSubcons" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnSubcons_Click">Sub-Contractors</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnMatType" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnMatType_Click">Material Types</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnStores" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnStores_Click">Material Stores</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnFabShops" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnFabShops_Click">Fabrication Shops</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnAreas" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnAreas_Click">Areas/PCWBS</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="btnLineService" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnLineService_Click">Line Services</asp:LinkButton>
                        </td>
                    </tr>
                      <tr>
                        <td>
                            <asp:LinkButton ID="btnMileStone" runat="server" Font-Underline="false" CssClass="bglinks"  OnClick="btnMileStone_Click">Spool Milestone</asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="text-align: right;">
                <img alt="homepage" src="../Images/Piping-12.gif" />
            </td>
        </tr>
    </table>
</asp:Content>