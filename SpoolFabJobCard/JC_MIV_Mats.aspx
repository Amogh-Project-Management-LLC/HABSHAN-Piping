<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV_Mats.aspx.cs" Inherits="Material_FabricationJobCardMatList"
    Title="JC MIV Materials" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddMat" runat="server" Text="New" Width="80" OnClick="btnAddMat_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" PageSize="18" Width="100%" SkinID="GridViewSkin" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            OnRowEditing="itemsGridView_RowEditing" OnDataBound="itemsGridView_DataBound"
            DataKeyNames="ISSUE_ITEM_ID">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataSourceID="itemsDataSource" DataKeyNames="ISSUE_ITEM_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmTextFormatString="Delete this Material <br\> {0}?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" ConfirmTextFields="SPL_TITLE"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>


                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" ReadOnly="true" SortExpression="MAT_CODE1"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat NO" ReadOnly="true" SortExpression="HEAT_NO"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" HeaderText="Issued Quantity" ReadOnly="true" SortExpression="QTY"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIPE_PIECES" HeaderText="Pipe Pieces" ReadOnly="true" SortExpression="PIPE_PIECES"></telerik:GridBoundColumn>            
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" SelectMethod="GetDataRev"
        TypeName="dsFabricationJCTableAdapters.PIP_MAT_ISSUE_WO_MATSTableAdapter" UpdateMethod="UpdateQuery"
        OldValuesParameterFormatString="original_{0}" DeleteMethod="DeleteQuery">
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_ISSUE_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_REV_ID" QueryStringField="ISSUE_REV_ID" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_ISSUE_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
