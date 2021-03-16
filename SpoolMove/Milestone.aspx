<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Milestone.aspx.cs" Inherits="SpoolMove_Milestone" Title="Spool Milestones" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnSpools" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Spools" Width="79px" OnClick="btnSpools_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="statusGridView" runat="server" AutoGenerateColumns="False" CssClass="DataWebControlStyle"
                    DataKeyNames="STATUS_ID" DataSourceID="SplMilsDataSource">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True">
                            <ItemStyle Width="30px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="STATUS_CODE" HeaderText="Status Code" SortExpression="STATUS_CODE">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="STATUS" HeaderText="Status Description" SortExpression="STATUS">
                            <ItemStyle Width="250px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS">
                            <ItemStyle Width="300px" />
                        </asp:BoundField>
                    </Columns>
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SplMilsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECt * FROM  PIP_SPOOL_MILESTONE
ORDER BY STATUS_CODE"></asp:SqlDataSource>
</asp:Content>
