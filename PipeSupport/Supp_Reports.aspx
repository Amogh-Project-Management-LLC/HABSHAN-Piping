<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_Reports.aspx.cs" Inherits="PipeSupport_Supp_Reports" Title="Support Reports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro; padding: 5px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">WBS/ Area:
                </td>
                <td>
                    <asp:DropDownList ID="ddArea" runat="server" Width="130px" AppendDataBoundItems="True"
                        DataSourceID="areaDataSource" DataTextField="AREA_L1" DataValueField="AREA_L1">
                        <asp:ListItem Selected="True" Value="XXX">&lt;ALL&gt;</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">Isometric No:
                </td>
                <td>
                    <asp:TextBox ID="txtIso" runat="server" Width="250px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">Support Tag No:
                </td>
                <td>
                    <asp:TextBox ID="txtSupTag" runat="server" Width="200px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke; padding: 5px;">

        <asp:LinkButton ID="btnSuppInst" runat="server" ForeColor="Blue"
            OnClick="btnSuppInst_Click"> Support Installation Status</asp:LinkButton>
    </div>
    <asp:SqlDataSource ID="areaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT AREA_L1 FROM IPMS_AREA WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY AREA_L1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>