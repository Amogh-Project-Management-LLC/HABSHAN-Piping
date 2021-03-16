<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialReuseItemsNew.aspx.cs" Inherits="Material_MaterialReuseItemsNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .auto-style2 {
            font-family: Calibri;
            font-weight: bold;
            font-size: small;
            width: 150px;
            background-color: #eff6fc;
        }
    </style>
    <div>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">Isometric Number</td>
                <td class="auto-style3">:</td>
                <td>
                    <%--<telerik:RadTextBox ID="txtIsometric" runat="server" Width="180px" AutoPostBack="True" OnTextChanged="txtIsometric_TextChanged" ValidationGroup="Add">
                        </telerik:RadTextBox>--%>
                    <telerik:RadSearchBox ID="txtIsometric" runat="server" Width="200px" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_ID"
                        EmptyMessage="Search Isometric...." OnSearch="txtIsometric_Search">
                    </telerik:RadSearchBox>

                </td>
            </tr>
            <tr>
                <td class="auto-style2">BOM Item</td>
                <td class="auto-style3">:</td>
                <td>
                    <telerik:RadComboBox ID="ddBomItem" runat="server" DataSourceID="bomDataSourceB" DataTextField="BOM_ITEM_B"
                        DataValueField="BOM_ID" Width="450px" AppendDataBoundItems="True" OnSelectedIndexChanged="ddBomItem_SelectedIndexChanged" AutoPostBack="True"
                        CausesValidation="false" ValidationGroup="Add" OnDataBinding="ddBomItem_DataBinding">
                        <Items>
                            <telerik:RadComboBoxItem Text="(BOM Items)" Value="" />
                        </Items>
                    </telerik:RadComboBox>
                    <asp:CompareValidator ID="bomItemValidator" runat="server" ErrorMessage="*" ControlToValidate="ddBomItem"
                        Operator="NotEqual" ValueToCompare="-1" ValidationGroup="Add"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">MRN Qty</td>
                <td class="auto-style3">:</td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" ValidationGroup="Add"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ValidationGroup="Add"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style3">&nbsp;</td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" CssClass="btnSubmit" Text="Submit" Skin="Office2007" OnClick="btnSubmit_Click" ValidationGroup="Add"></telerik:RadButton>
                </td>
            </tr>


        </table>
    </div>

    <asp:SqlDataSource ID="bomDataSourceB" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM_B FROM VIEW_BOM_REUSE_ITEM WHERE REUSE_FLAG='Y' AND (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY BOM_ITEM_B" OnSelecting="bomDataSourceB_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="HiddenISO" DefaultValue="-1" Name="ISO_TITLE1"
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, ISO_TITLE1
FROM VIEW_BOM_EREC_ITEM
WHERE SF = 8"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenISO" runat="server" />
</asp:Content>

