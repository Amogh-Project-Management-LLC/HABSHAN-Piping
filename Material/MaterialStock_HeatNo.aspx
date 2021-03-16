<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_HeatNo.aspx.cs" Inherits="Material_Reports_Material_Stock_HeatNo"
    Title="Material - Heat No" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMore_Click" Enabled="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <table style="width: 100%">
        <tr>
            <td>
                <asp:RadioButtonList ID="heatNos" runat="server" DataSourceID="hnDataSource" DataTextField="HEAT_NO"
                    DataValueField="HEAT_NO" Font-Bold="False" Font-Italic="False" Font-Size="9pt" OnDataBound="heatNos_DataBound">
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="hnDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT HEAT_NO FROM VIEW_MRIR_ESD WHERE (MAT_ID = :MAT_ID) GROUP BY HEAT_NO ORDER BY HEAT_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>