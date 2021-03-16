<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MilestoneSpools.aspx.cs" Inherits="SpoolMove_MilestoneSpools" Title="Spool Milestone" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    OnClick="btnBack_Click" Text="Back" Width="75px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="spoolGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="spoolDataSource" PageSize="15" Width="100%"
                    DataKeyNames="SPL_ID" OnSelectedIndexChanged="spoolGridView_SelectedIndexChanged">
                    <PagerSettings PageButtonCount="18" />
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True">
                            <ItemStyle Width="30px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="JOB_CODE" HeaderText="Job Code" SortExpression="JOB_CODE" />
                        <asp:BoundField DataField="AREA_L1" HeaderText="Area" SortExpression="AREA_L1" />
                        <asp:BoundField DataField="SPL_TITLE" HeaderText="Spool Title" SortExpression="SPL_TITLE" />
                        <asp:BoundField DataField="JC_NO" HeaderText="Job Card No" SortExpression="JC_NO" />
                        <asp:BoundField DataField="MAT_AVL" HeaderText="Mat Avail" SortExpression="MAT_AVL" />
                        <asp:BoundField DataField="MAIN_MAT" HeaderText="Main Material" SortExpression="MAIN_MAT" />
                        <asp:BoundField DataField="LINE_PS" HeaderText="Paint" SortExpression="LINE_PS" />
                        <asp:BoundField DataField="SPL_SIZE" HeaderText="Spool Size" SortExpression="SPL_SIZE" />
                        <asp:BoundField DataField="SPL_LEN" HeaderText="Length" SortExpression="SPL_LEN" />
                        <asp:BoundField DataField="SFR" HeaderText="SFR" SortExpression="SFR" />
                    </Columns>
                    <EmptyDataTemplate>
                        No spool found on selected status!
                    </EmptyDataTemplate>
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <PagerStyle Font-Bold="True" ForeColor="Blue" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnExcel" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                    Text="Excel" Width="74px" OnClick="btnExcel_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="spoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, JOB_CODE, SPL_ID, SPL_TITLE, AREA_L1, ISO_REV, SPL_REV, MAT_AVL, SPL_SIZE, MAIN_MAT, LINE_CLASS, SHOP_ID, FIELD_ID, SPL_LEN, SFR, JC_NO, STATUS, LINE_PS 
FROM VIEW_TOTAL_SPOOL_LIST
WHERE ((PROJECT_ID = :PROJECT_ID) AND (STATUS_ID = :STATUS_ID))
ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="STATUS_ID" QueryStringField="STATUS_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
