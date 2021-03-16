<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ConsumableArrive.aspx.cs" Inherits="Consumable_ConsumableArrive" Title="Consumable Arrive" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" />
                </td>
                <td style="text-align: right; width: 100%">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtFilter" runat="server" Width="150" OnTextChanged="txtFilter_TextChanged" EmptyMessage="Search Here" AutoPostBack="True"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="RadGrid1_DataSource"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnUpdateCommand="RadGrid1_UpdateCommand">
                <ClientSettings EnablePostBackOnRowClick="True">
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="LOG_ID" DataSourceID="RadGrid1_DataSource" HierarchyLoadMode="Client" PageSize="15"
                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true">
                    <Columns>

                        <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                            <ItemStyle Width="50px" />
                        </telerik:GridEditCommandColumn>

                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn" ItemStyle-Width="20px">
                            <ItemStyle Width="20px" />
                        </telerik:GridButtonColumn>

                        <telerik:GridDateTimeColumn DataField="ARRIVE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ARRIVE_DATE column" HeaderText="Arrived Date"
                            SortExpression="ARRIVE_DATE" UniqueName="ARRIVE_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" EditDataFormatString="dd-MMM-yyyy">
                        </telerik:GridDateTimeColumn>

                        <telerik:GridBoundColumn DataField="MAT_CODE" FilterControlAltText="Filter MAT_CODE column" HeaderText="Mat Code" SortExpression="MAT_CODE" UniqueName="MAT_CODE" ReadOnly="true">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="CATEGORY" FilterControlAltText="Filter CATEGORY column" HeaderText="Category" SortExpression="CATEGORY" UniqueName="CATEGORY" ReadOnly="true">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="DESCRIPTION" FilterControlAltText="Filter DESCRIPTION column" HeaderText="Description" SortExpression="DESCRIPTION" UniqueName="DESCRIPTION" ReadOnly="true">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" ReadOnly="true">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="ARRIVE_QTY" DataType="System.Decimal" FilterControlAltText="Filter ARRIVE_QTY column" HeaderText="Arrived Qty" SortExpression="ARRIVE_QTY" UniqueName="ARRIVE_QTY">
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                        </EditColumn>
                        <PopUpSettings Modal="True" />
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:ObjectDataSource ID="RadGrid1_DataSource" runat="server" SelectMethod="GetData"
        TypeName="dsConsumableTableAdapters.VIEW_CONSUMABLE_ARRIVETableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="MAT_CODE" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ARRIVE_DATE" Type="DateTime" />
            <asp:Parameter Name="ARRIVE_QTY" Type="Decimal" />
            <asp:Parameter Name="Original_LOG_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LOG_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>