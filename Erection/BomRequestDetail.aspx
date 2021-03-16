<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="BomRequestDetail.aspx.cs" Inherits="PipeSupport_BomRequestDetail" Title="Material Request" %>

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
                                <td style="width: 130px; background-color: #ccccff">Isometric Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                                        Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Item Code
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddSupp" runat="server" Width="400px" DataSourceID="bomDataSource"
                                        DataTextField="BOM_ITEM_B" DataValueField="BOM_ID" AppendDataBoundItems="True"
                                        OnSelectedIndexChanged="ddSupp_SelectedIndexChanged" AutoPostBack="True">
                                        <asp:ListItem Selected="True" Value="-1">(Ident Code)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="suppValidator" runat="server" ControlToValidate="ddSupp"
                                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Quantity
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
                            DataKeyNames="REQ_ID,BOM_ID" DataSourceID="itemstDataSource" Width="100%" AllowPaging="True"
                            PageSize="15" OnRowEditing="itemsGridView_RowEditing">
                            <Columns>
                                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                                    ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                                    <ItemStyle Width="50px" />
                                </asp:CommandField>
                                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="true" />
                                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                                <asp:BoundField DataField="MAT_CODE1" HeaderText="Tag No" SortExpression="MAT_CODE1"
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
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionATableAdapters.VIEW_BOM_REQUEST_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REQ_ID" QueryStringField="REQ_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM_B FROM VIEW_BOM_EREC_ITEM WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) AND (SF = 2) AND (IS_SUPP = 'N') ORDER BY BOM_ITEM_B">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>