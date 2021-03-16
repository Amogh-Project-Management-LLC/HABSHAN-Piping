<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JobCardPlate.aspx.cs" Inherits="Material_JobCardPlate" Title="Jobcard Plates" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
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
        <telerik:RadGrid ID="spoolsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="JcSpoolsDataSource" Width="100%"
            PageSize="20" OnDataBound="spoolsGridView_DataBound" DataKeyNames="PLATE_ID">
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn DataField="ITEM_NAME" HeaderText="Item Name" SortExpression="ITEM_NAME" />
                    <telerik:GridBoundColumn DataField="ITEM_TYPE" HeaderText="Item Type" SortExpression="ITEM_TYPE" />
                    <telerik:GridBoundColumn DataField="MATERIAL_STANDARD" HeaderText="Material Standard" SortExpression="MATERIAL_STANDARD" />
                    <telerik:GridBoundColumn DataField="SIZE1" HeaderText="Size 1" SortExpression="SIZE1" />
                    <telerik:GridBoundColumn DataField="SIZE2" HeaderText="Size 2" SortExpression="SIZE2" />
                    <telerik:GridBoundColumn DataField="THICKNESS" HeaderText="Thickness" SortExpression="THICKNESS" />
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                    <telerik:GridBoundColumn DataField="QTY" HeaderText="QTY" SortExpression="QTY" />
                    <telerik:GridBoundColumn DataField="ACTUAL_WEIGHT" HeaderText="Weight (KG)" SortExpression="ACTUAL_WEIGHT" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="JcSpoolsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsFabricationJCTableAdapters.VIEW_WORK_ORD_PLATETableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
