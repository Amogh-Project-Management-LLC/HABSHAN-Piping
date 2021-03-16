<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SupportErectionRegister.aspx.cs" Inherits="SupportErectionRegister"
    Title="Support Erection" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <telerik:RadTextBox ID="txtErecReportNo" runat="server" Width="150px" EmptyMessage="Erection Report No"
                                AutoPostBack="True" Enabled="False"></telerik:RadTextBox>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtErecDate" runat="server" Width="100px" EmptyMessage="Erection Date"
                                AutoPostBack="True"></telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnSaveErec" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Save Erec" Width="90px" OnClick="btnSaveErec_Click" />
                        </td>
                        <td style="width: 100%" align="center">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="10">
                                <ProgressTemplate>
                                    <img src="../Images/ajax-loader-bar.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIsome" Width="175px" runat="server" AutoPostBack="True"
                                OnTextChanged="txtIsome_TextChanged" EmptyMessage="Isometric No"></telerik:RadTextBox>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtSupp" runat="server" AutoPostBack="True" Width="175px"
                                OnTextChanged="txtSupp_TextChanged" EmptyMessage="Support Tag"></telerik:RadTextBox>
                        </td>
                        <td align="right" style="width: 40px">
                            <img src="../Images/magnifier.bmp" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" PageSize="15" Width="100%" DataSourceID="suppDataSource"
                    DataKeyNames="BOM_ID">
                    <PagerSettings PageButtonCount="15" />
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <PagerStyle Font-Bold="True" ForeColor="DarkGreen" />
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True">
                            <ItemStyle Width="30px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                        <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                        <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                        <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                        <asp:BoundField DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM" />
                        <asp:BoundField DataField="MAT_CODE1" HeaderText="Support Tag" SortExpression="MAT_CODE1" />
                        <asp:BoundField DataField="SF_FLG" HeaderText="S/F" SortExpression="SF_FLG" />
                        <asp:BoundField DataField="NET_QTY" HeaderText="Qty" SortExpression="NET_QTY" />
                        <asp:BoundField DataField="EREC_DATE" HeaderText="Erec Date" SortExpression="EREC_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                    </Columns>
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                    <EmptyDataTemplate>
                        No Information!
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="suppDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJ_ID, BOM_ID, ISO_TITLE1, SHEET, SPOOL, PT_NO, ITEM_NAM, MAT_CODE1, SF_FLG, NET_QTY, EREC_DATE FROM VIEW_BOM_TOTAL WHERE (IS_SUPP = 'Y') AND (ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1)) AND (MAT_CODE1 LIKE FNC_FILTER(:MAT_CODE1)) AND (SF = 2) AND (PROJ_ID = :PROJECT_ID) ORDER BY ISO_TITLE1, SHEET, SPOOL, PT_NO, MAT_CODE1">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtSupp" DefaultValue="%" Name="MAT_CODE1" PropertyName="Text" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>