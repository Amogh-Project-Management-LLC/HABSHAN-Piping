<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CuttingPlanAlloc.aspx.cs" Inherits="Material_CuttingPlanAlloc"
    Title="Cutting Plan - Allocation" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddMat" runat="server" Text="New" Width="80" OnClick="btnAddMat_Click" Skin="Telerik" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" Visible="false" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div id="EntryDiv" runat="server" visible="false">
        <table>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">BOM Item</td>
                <td>
                    <asp:DropDownList ID="cboBOM" runat="server" DataSourceID="bomDataSource" DataTextField="BOM_DESC_FULL"
                        DataValueField="BOM_ID" Width="600px" AutoPostBack="True" OnSelectedIndexChanged="cboBOM_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">BOM Qty</td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtBOMQty" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="BOMQtyValidator" runat="server" ControlToValidate="txtBOMQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Cutting Allowance</td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtCuttingAlw" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="CuttingAlwValidator" runat="server" ControlToValidate="txtCuttingAlw"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Total Used Qty</td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtCalcQty" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="CalcQtyValidator" runat="server" ControlToValidate="txtCalcQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" PageSize="18" Width="100%" SkinID="GridViewSkin"
            OnRowEditing="itemsGridView_RowEditing" OnDataBound="itemsGridView_DataBound"
            DataKeyNames="PIECE_ID,BOM_ID">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="BOM_ITEM_B" HeaderText="BOM Item" SortExpression="BOM_ITEM_B" ReadOnly="true" />
                <asp:BoundField DataField="BOM_QTY" HeaderText="Bom Qty" SortExpression="BOM_QTY" />
                <asp:BoundField DataField="CUT_ALW" HeaderText="Allowance" SortExpression="CUT_ALW" />
                <asp:BoundField DataField="CALC_QTY" HeaderText="Total Qty" SortExpression="CALC_QTY" />
                <asp:BoundField DataField="PIPE_ANGLE" HeaderText="Pipe Angle" SortExpression="PIPE_ANGLE" />
                <asp:BoundField DataField="FLAG_A" HeaderText="Flag" SortExpression="FLAG_A" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50" OnClick="btnYes_Click" EnableViewState="false" Visible="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50" EnableViewState="false" Visible="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="WO_IDHiddenField" runat="server" />
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsCuttingPlanATableAdapters.VIEW_WORK_ORD_CUTLEN_DETAILTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}" DeleteMethod="DeleteQuery">
        <UpdateParameters>
            <asp:Parameter Name="BOM_QTY" Type="Decimal" />
            <asp:Parameter Name="CALC_QTY" Type="Decimal" />
            <asp:Parameter Name="CUT_ALW" Type="Decimal" />
            <asp:Parameter Name="PIPE_ANGLE" Type="Decimal" />
            <asp:Parameter Name="FLAG_A" Type="String" />
            <asp:Parameter Name="Original_PIECE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PIECE_ID" QueryStringField="PIECE_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_PIECE_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_DESC_FULL FROM VIEW_BOM_NOT_IN_CUTLEN WHERE (MAT_ID = :MAT_ID) AND (ISSUE_ID = :ISSUE_ID) ORDER BY ISO_TITLE1, SHEET, SPOOL, BOM_DESC_FULL">
        <SelectParameters>
            <asp:ControlParameter ControlID="matIdField" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="matIdField" runat="server" />
</asp:Content>