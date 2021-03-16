<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AreaSystemCompletion.aspx.cs" Inherits="TestPkg_AreaSystemCompletion" Title="Test Package Completion Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 110px; background-color: #ccccff;" valign="top">System No
                        </td>
                        <td>
                            <asp:RadioButtonList ID="SystemNoList" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SystemNoDataSource" DataTextField="SYS_NUMBER" DataValueField="SYS_NUMBER"
                                OnDataBinding="SystemNoList_DataBinding">
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 110px; background-color: #ccccff;" valign="top">Report
                        </td>
                        <td>
                            <asp:RadioButtonList ID="ReportList" runat="server">
                                <asp:ListItem Value="11" Text="Welding Completion Status" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="12" Text="Support and Loose Material Installation Status"></asp:ListItem>
                                <asp:ListItem Value="13" Text="Spools Fabrication and Installation Sttaus"></asp:ListItem>
                                <asp:ListItem Value="14" Text="NDT Status"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff;">
                <asp:Button ID="btnArea" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Preview" Width="80px" OnClick="btnArea_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SystemNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SYS_NUMBER FROM TPK_SYSTEM_DEFINITION WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SYS_NUMBER">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>