<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Site_Supervisors.aspx.cs" Inherits="Site_Supervisors" Title="Supervisors" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Back" Width="80px" OnClick="btnBack_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" PageSize="18" Width="100%" DataKeyNames="SV_ID"
                    DataSourceID="rowstDataSource">
                    <PagerSettings PageButtonCount="18" />
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <PagerStyle Font-Bold="True" ForeColor="DarkGreen" />
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True">
                            <ItemStyle Width="30px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="SV_NAME" HeaderText="Supervisor Name" SortExpression="SV_NAME" />
                        <asp:BoundField DataField="SV_CODE" HeaderText="Supervisor Code" SortExpression="SV_CODE" />
                        <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME" />
                        <asp:BoundField DataField="AREA_L1" HeaderText="Area Name" SortExpression="AREA_L1" />
                        <asp:BoundField DataField="DISCIPLINE" HeaderText="Discipline" SortExpression="DISCIPLINE" />
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Information!
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnRegister" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Register" Width="80px" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnYes" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="Yes" Width="44px" EnableViewState="False" OnClick="btnYes_Click" Visible="False" />
                        </td>
                        <td>
                            <asp:Button ID="btnNo" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="No" Width="44px" EnableViewState="False" Visible="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME 
FROM SUB_CONTRACTOR 
WHERE PROJ_ID = :PROJECT_ID 
ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="rowstDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsErectionATableAdapters.PIP_SITE_SVTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
