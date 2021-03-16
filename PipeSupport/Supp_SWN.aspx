<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_SWN.aspx.cs" Inherits="PipeSupport_Supp_SWN" Title="Support SWN" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: #99ccff">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <asp:Button ID="btnRegist" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="Register" Width="80px" OnClick="btnRegist_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnPreview" runat="server" OnClick="btnPreview_Click" Text="Preview"
                                Width="80px" BackColor="SkyBlue" BorderColor="SteelBlue" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                                AutoPostBack="true" EmptyMessage="Search Here" Width="195px">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CssClass="DataWebControlStyle" DataSourceID="rowsDataSource" Width="100%" DataKeyNames="SWN_ID"
                            PageSize="15" OnRowEditing="rowsGridView_RowEditing">
                            <Columns>
                                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                                    ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                                    <ItemStyle Width="50px" />
                                </asp:CommandField>
                                <asp:BoundField DataField="SWN_NO" HeaderText="SWN No" SortExpression="SWN_NO" />
                                <asp:BoundField DataField="SWN_DATE" HeaderText="SWN Date" SortExpression="SWN_DATE"
                                    DataFormatString="{0:dd-MMM-yyyy}" ApplyFormatInEditMode="true" HtmlEncode="false" />
                                <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon Name" SortExpression="SUB_CON_NAME"
                                    ReadOnly="true" />
                                <asp:TemplateField HeaderText="Fab Shop" SortExpression="SHOP_NO">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList11" runat="server" DataSourceID="shopDataSource"
                                            DataTextField="SHOP_NAME" DataValueField="SHOP_ID" SelectedValue='<%# Bind("SHOP_ID") %>'
                                            Width="150px" AppendDataBoundItems="True">
                                            <asp:ListItem></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="shopDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SHOP_ID, SHOP_NAME FROM PIP_FAB_SHOP WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY SHOP_NAME'>
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("SHOP_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Columns>
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                            <PagerSettings PageButtonCount="15" />
                            <EmptyDataTemplate>
                                No Information!
                            </EmptyDataTemplate>
                            <PagerStyle Font-Bold="True" Font-Italic="False" ForeColor="DarkGreen" />
                            <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff;">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnView" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Support List" Width="100px" OnClick="btnView_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnYes" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="Yes" Visible="False" Width="44px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnNo" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="No" Visible="False" Width="44px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_DTableAdapters.VIEW_SUPP_SWNTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SWN_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SWN_NO" Type="String" />
            <asp:Parameter Name="SWN_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SHOP_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SWN_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SWN_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>