<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="LooseMatStatus.aspx.cs" Inherits="LooseMatStatus" Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" CausesValidation="false" />
                        </td>
                        <td>
                            <asp:Button ID="btnEntry" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                CausesValidation="false" Text="Erection" Width="80px" OnClick="btnEntry_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="80px" BackColor="SkyBlue"
                                BorderColor="SteelBlue" Visible="False" OnClick="btnSubmit_Click" />
                        </td>
                        <td style="width: 100%" align="right">
                            <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                                EmptyMessage="Isometric No" Width="180px"></telerik:RadTextBox>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtCommodity" runat="server" AutoPostBack="True" Width="180px"
                                OnTextChanged="txtSupp_TextChanged" EmptyMessage="Item Code"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" runat="server" visible="false" id="ErectionEntryTable">
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label1" runat="server" Text="Report Number"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRepNo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label2" runat="server" Text="Erection Date"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate" runat="server" Width="76px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="dateValidator" runat="server" ControlToValidate="txtDate"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label4" runat="server" Text="Subcon"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                Width="170px">
                                <asp:ListItem Selected="True">(Select)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label6" runat="server" Text="Erec Quantity"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtQty" runat="server" Width="46px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label7" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRem" runat="server" Width="570px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" PageSize="15" Width="100%" DataSourceID="rowsDataSource"
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
                        <asp:BoundField DataField="MAT_CODE1" HeaderText="Ident Code/Supp Symbol" SortExpression="MAT_CODE1" />
                        <asp:BoundField DataField="SIZE_DESC" HeaderText="Size Desc" SortExpression="SIZE_DESC" />
                        <asp:BoundField DataField="NET_QTY" HeaderText="BOM Qty" SortExpression="NET_QTY" />
                        <asp:BoundField DataField="EREC_QTY" HeaderText="Erec Qty" SortExpression="EREC_QTY" />
                        <asp:BoundField DataField="EREC_DATE" HeaderText="Erection Date" SortExpression="EREC_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" ApplyFormatInEditMode="true" />
                    </Columns>
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                    <EmptyDataTemplate>
                        No matches!
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnErected" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Erected" Width="80px" OnClick="btnErected_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="rowsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJ_ID, ISO_ID, BOM_ID, ISO_TITLE1, SHEET, SPOOL, PT_NO, ITEM_NAM, MAT_CODE1, SIZE_DESC, NET_QTY, EREC_DATE, EREC_QTY FROM VIEW_BOM_TOTAL WHERE (ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1)) AND (MAT_CODE1 LIKE FNC_FILTER(:MAT_CODE1)) AND (FLAG_B = 'Y') AND (SF = 2) ORDER BY ISO_TITLE1, SHEET, SPOOL, PT_NO, MAT_CODE1">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtCommodity" DefaultValue="~" Name="MAT_CODE1"
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
