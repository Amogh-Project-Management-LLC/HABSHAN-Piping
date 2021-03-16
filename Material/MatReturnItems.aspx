<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReturnItems.aspx.cs" Inherits="Material_MatReturn" Title="Material Return" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td align="right" style="width: 100%">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Material Code
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode" runat="server" AutoPostBack="True"
                        Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Heat No
                </td>
                <td>
                    <asp:TextBox ID="txtHeatNo" runat="server" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="HeatNoValidator" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Paint Code
                </td>
                <td>
                    <asp:TextBox ID="txtPaintCode" runat="server" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Return Qty
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="350px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="returnGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="returnDataSource" OnDataBound="returnGridView_DataBound" SkinID="GridViewSkin"
            PageSize="18" Width="100%" DataKeyNames="RET_ITEM_ID" OnRowEditing="returnGridView_RowEditing">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" ReadOnly="True"
                    SortExpression="MAT_CODE1" />
                <asp:TemplateField HeaderText="Heat Number" SortExpression="HEAT_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="106px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE" />
                <asp:TemplateField HeaderText="Return Qty" SortExpression="RET_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RET_QTY") %>' Width="61px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("RET_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="returnDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialATableAdapters.PIP_MAT_RETURN_LISTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RET_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="RET_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RET_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RET_ID" QueryStringField="MAT_RET_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>