<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="ColdBendingItems.aspx.cs" Inherits="ColdBending_ColdBendingItems" Title="Cold Bending" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
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
        <table width="100%" runat="server" visible="false" id="EntryTable">
            <tr>
                <td class="TableStyle" style="width: 150px; background-color: Whitesmoke;">Isometric No
                </td>
                <td class="TableStyle">
                    <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="isomeValidator" runat="server" ControlToValidate="txtIsome"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="TableStyle" style="width: 150px; background-color: Whitesmoke;">Sheet No
                </td>
                <td class="TableStyle">
                    <asp:DropDownList ID="ddSheetNo" runat="server" AppendDataBoundItems="True" DataSourceID="SheetNoDataSource"
                        DataTextField="SHEET" DataValueField="SHEET" OnDataBinding="ddSheetNo_DataBinding"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="TableStyle" style="width: 150px; background-color: Whitesmoke;">BOM Item
                </td>
                <td class="TableStyle">
                    <asp:DropDownList ID="cboBOM" runat="server" AppendDataBoundItems="True" DataSourceID="bomDataSource"
                        DataTextField="BOM_ITEM" DataValueField="BOM_ID" Width="332px" AutoPostBack="True"
                        OnSelectedIndexChanged="cboMM_SELECTedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="itemValidator" runat="server" ControlToValidate="cboBOM"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="TableStyle" style="width: 150px; background-color: Whitesmoke;">
                    <asp:Label ID="Label3" runat="server" Text="Issued Qty"></asp:Label>
                </td>
                <td class="TableStyle">
                    <asp:TextBox ID="txtIssuedQty" runat="server" Width="70px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="issuedQtyValidator" runat="server" ControlToValidate="txtIssuedQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="TableStyle" style="width: 150px; background-color: Whitesmoke">
                    <asp:Label ID="Label4" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td class="TableStyle">
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="itemsDataSource" Width="100%" OnRowEditing="itemsGridView_RowEditing" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            OnDataBound="itemsGridView_DataBound" PageSize="20" DataKeyNames="JC_ID,BOM_ID">
            <ClientSettings>
                <Selecting AllowRowSelect="true"/>
            </ClientSettings>
            <MasterTableView DataSourceID="itemsDataSource" DataKeyNames="JC_ID,BOM_ID" EditMode="InPlace">
            <Columns>          
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1"
                    ReadOnly="true" />
                <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="true" />
                <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                <telerik:GridBoundColumn DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" ReadOnly="true" />
                <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"
                    ReadOnly="true" />
                <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />
                <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item Name" SortExpression="ITEM_NAM"
                    ReadOnly="true" />
                <telerik:GridBoundColumn DataField="QTY" HeaderText="Qty" SortExpression="QTY" />
                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
           </MasterTableView>
        </telerik:RadGrid>
    </div>

   

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsCoolBendingTableAdapters.VIEW_COOL_BENDING_JC_DTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, BOM_ID, BOM_ITEM FROM VIEW_BOM_EREC_ITEM WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE) ORDER BY BOM_ITEM">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SheetNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SHEET FROM VIEW_SPL_INDEX WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY SHEET">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>