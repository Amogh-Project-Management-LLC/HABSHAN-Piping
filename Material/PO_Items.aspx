<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PO_Items.aspx.cs" Inherits="Material_PurchaseOrderItems" Title="PO Items" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnPOList_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="80" CausesValidation="false" Enabled="False"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" CausesValidation="false" Enabled="False" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" Visible="false" Enabled="False" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" Width="100%" OnDataBound="itemsGridView_DataBound"
            DataKeyNames="PO_ITEM_ID" ClientDataKeyNames="PO_ITEM_ID" DataSourceID="PO_DetailsDataSource" AllowAutomaticUpdates="True">
            <ClientSettings>
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
            <MasterTableView DataSourceID="PO_DetailsDataSource" EditMode="InPlace" DataKeyNames="PO_ITEM_ID">
                <Columns>

                    <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete PO" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="PO_ITEM" HeaderText="PO Item" SortExpression="PO_ITEM" />
                    <telerik:GridBoundColumn DataField="PA_ITEM" HeaderText="PA Item" SortExpression="PA_ITEM" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1" />
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" />
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item Name" SortExpression="ITEM_NAM" />
                    <telerik:GridBoundColumn DataField="PO_QTY" HeaderText="PO Qty" SortExpression="PO_QTY" />
                    <telerik:GridBoundColumn DataField="PART_QTY" HeaderText="Part Qty" SortExpression="PART_QTY" />
                    <telerik:GridBoundColumn DataField="QTY_SHIPPED" HeaderText="Qty Shipped" SortExpression="QTY_SHIPPED" />
                    <telerik:GridBoundColumn DataField="ETA" HeaderText="ETA" SortExpression="ETA" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                    <telerik:GridBoundColumn DataField="ETA_FA" HeaderText="ETA FA" SortExpression="ETA_FA" />
                    <telerik:GridBoundColumn DataField="AT_SITE" HeaderText="At Site" SortExpression="AT_SITE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                    <telerik:GridBoundColumn DataField="AT_SITE_FA" HeaderText="At Site FA" SortExpression="AT_SITE_FA" />
                    <telerik:GridBoundColumn DataField="SHIPMENT_NO" HeaderText="Ship No" SortExpression="SHIPMENT_NO" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>



    <asp:ObjectDataSource ID="PO_DetailsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsPO_ShipmentTableAdapters.PIP_PO_DETAILTableAdapter"
        DeleteMethod="DeleteQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_PO_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
