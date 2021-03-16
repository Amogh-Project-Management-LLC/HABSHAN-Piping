<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_Receive_Bulk.aspx.cs" Inherits="PipeSupport_Supp_Receive_Bulk"
    Title="Support Receive" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width: 100%">
                <tr>
                    <td style="background-color: #99ccff">
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                        Text="Back" Width="80px" CausesValidation="False" OnClick="btnBack_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnHideEnt" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                        Text="Entry" Width="80px" CausesValidation="False" OnClick="btnHideEnt_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                        OnClick="btnSubmit_Click" Text="Save" Width="80px" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table style="width: 100%" class="TableStyle" id="EntryTable" runat="server" visible="false">
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Support Tag Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMatCode" runat="server" Width="200px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                                        ErrorMessage="*" Width="12px"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Support Quantity
                                </td>
                                <td>
                                    <asp:TextBox ID="txtQty" runat="server" Width="50px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Remarks
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRem" runat="server" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="itemsGridView" runat="server" AutoGenerateColumns="False" CssClass="DataWebControlStyle"
                            DataKeyNames="RECV_ID,MAT_ID" DataSourceID="itemstDataSource" Width="100%" AllowPaging="True"
                            PageSize="15" OnRowEditing="itemsGridView_RowEditing">
                            <Columns>
                                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                                    ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                                    <ItemStyle Width="50px" />
                                </asp:CommandField>
                                <asp:BoundField DataField="MAT_CODE1" HeaderText="Tag No" SortExpression="MAT_CODE1"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="MAT_DESCR" HeaderText="Material Description" SortExpression="MAT_DESCR"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="QTY" HeaderText="QTY" SortExpression="QTY" />
                                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Columns>
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                            <PagerStyle CssClass="PagerStyle" />
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
                                    <asp:Button ID="btnDelete" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                        OnClick="btnDelete_Click" Text="Delete" Width="80px" CausesValidation="False" />
                                </td>
                                <td>
                                    <asp:Button ID="btnYes" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                        EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="44px"
                                        CausesValidation="False" />
                                </td>
                                <td>
                                    <asp:Button ID="btnNo" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                        EnableViewState="False" Text="No" Visible="False" Width="44px" CausesValidation="False" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_ETableAdapters.VIEW_SUPP_RECEIVE_BULKTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_RECV_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RECV_ID" QueryStringField="RECV_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_RECV_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>