<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CuttingPlanMaster.aspx.cs" Inherits="Material_CuttingPlanMaster"
    Title="Cutting Plan" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="False"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdateRemainSerial" runat="server" Text="Rem Serial" Width="100" OnClick="btnUpdateRemainSerial_Click" CausesValidation="False"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAlloc" runat="server" Text="Allocation" Width="90" OnClick="btnAlloc_Click" CausesValidation="False"></telerik:RadButton>
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
    <div id="RemainSerialDiv" runat="server" visible="false">
        <table>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Remain Seial No
                </td>
                <td>
                    <asp:TextBox ID="txtRemainSerialNo" runat="server" Width="100px"></asp:TextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnSaveRemainSerial" runat="server" Text="Save" Width="80" OnClick="btnSaveRemainSerial_Click" Skin="Sunset"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div id="EntryDiv" runat="server" visible="false">
        <table>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Material Code
                </td>
                <td style="height: 24px">
                    <asp:DropDownList ID="cboMat" runat="server" AppendDataBoundItems="True" DataSourceID="matDataSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Width="200px">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="matValidator" runat="server" ControlToValidate="cboMat"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Piece No</td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtPieceNo" runat="server" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PieceNoValidator" runat="server" ControlToValidate="txtPieceNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Heat No
                </td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtHN" runat="server" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHN"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Paint Code</td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtPaintCode" runat="server" Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">Length (Pipe)
                </td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtLength" runat="server" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="lengthValidator3" runat="server" ControlToValidate="txtLength"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" PageSize="18" Width="100%" SkinID="GridViewSkin"
            OnRowEditing="itemsGridView_RowEditing" OnDataBound="itemsGridView_DataBound"
            DataKeyNames="PIECE_ID" OnSelectedIndexChanged="itemsGridView_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="Piece No" SortExpression="PIECE_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PIECE_NO") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PIECE_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pipe Len" SortExpression="PIPE_LEN">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PIPE_LEN") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("PIPE_LEN") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Heat No" SortExpression="HEAT_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="100px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Paint Code" SortExpression="PNT_CODE">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PNT_CODE") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("PNT_CODE") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1" ReadOnly="True" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size Desc" SortExpression="SIZE_DESC" ReadOnly="true" />
                <asp:BoundField DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" ReadOnly="true" />
                <asp:BoundField DataField="REM_QTY" HeaderText="Rem Qty" SortExpression="REM_QTY" />
                <asp:BoundField DataField="REM_SERIAL" HeaderText="Rem Serial" SortExpression="REM_SERIAL" ReadOnly="true" />
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
        TypeName="dsCuttingPlanATableAdapters.VIEW_WORK_ORD_CUTLENTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}" DeleteMethod="DeleteQuery">
        <UpdateParameters>
            <asp:Parameter Name="PIECE_NO" Type="Decimal" />
            <asp:Parameter Name="PIPE_LEN" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="PNT_CODE" Type="String" />
            <asp:Parameter Name="REM_QTY" Type="Decimal" />
            <asp:Parameter Name="Original_PIECE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_PIECE_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="matDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1 FROM VIEW_JC_MAT_SUMMARY WHERE (WO_ID = :WO_ID) AND (ITEM_NAM = 'PIPE') ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:ControlParameter ControlID="WO_IDHiddenField" DefaultValue="-1" Name="WO_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>