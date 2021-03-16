<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_Release_Detail.aspx.cs" Inherits="PipeSupport_Supp_Release_Detail"
    Title="Support Release" %>

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
                                <td style="width: 130px; background-color: #ccccff" valign="top">Entry Type
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="ddEntryType" runat="server" AutoPostBack="True" Width="400px"
                                        OnSelectedIndexChanged="ddEntryType_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Text="Isometric Wise Entry" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Partial Entry" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Isometric Number
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                                        Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 130px; background-color: #ccccff">Support Tag Number
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddSupp" runat="server" Width="400px" DataSourceID="bomDataSource"
                                        DataTextField="BOM_ITEM_B" DataValueField="BOM_ID" AppendDataBoundItems="True">
                                        <asp:ListItem Selected="True" Value="-1">(Select Support)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="suppValidator" runat="server" ControlToValidate="ddSupp"
                                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
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
                            DataKeyNames="REL_ID,BOM_ID" DataSourceID="itemstDataSource" Width="100%" AllowPaging="True"
                            PageSize="15" OnRowEditing="itemsGridView_RowEditing">
                            <Columns>
                                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                                    SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True" UpdateImageUrl="~/Images/icon-save.gif"
                                    CausesValidation="False">
                                    <ItemStyle Width="25px" />
                                </asp:CommandField>
                                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                                <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                                <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                                <asp:BoundField DataField="MAT_CODE1" HeaderText="Support Tag" SortExpression="MAT_CODE1" />
                                <asp:BoundField DataField="NET_QTY" HeaderText="Qty" SortExpression="NET_QTY" />
                                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Columns>
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                            <PagerStyle CssClass="PagerStyle" />
                            <EmptyDataTemplate>
                                No Support Selected Yet!
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
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_ETableAdapters.VIEW_SUPP_REL_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REL_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REL_ID" QueryStringField="REL_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_REL_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM_B FROM VIEW_BOM_EREC_ITEM WHERE (SG_GROUP = 'SUPPORT') AND (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY BOM_ITEM_B">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>