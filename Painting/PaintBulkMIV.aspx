<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PaintBulkMIV.aspx.cs" Inherits="Painting_PaintBulkMIV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="80px"></telerik:RadButton>
                    <telerik:RadButton ID="btnMaterial" runat="server" Text="Material" Width="80px" OnClick="btnMaterial_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Import.." Width="80px"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="250px" BackColor="#ffffcc" EmptyMessage="Search..."></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource"  PageSize="15" OnItemDeleted="itemsGrid_ItemDeleted">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="ISSUE_ID" EditMode="InPlace" AllowAutomaticDeletes="True"
            AllowAutomaticUpdates="True">
                <Columns>
                    <telerik:GridButtonColumn ButtonType="ImageButton" ConfirmTextFormatString="Are you sure you want to delete {0}?"
                        CommandName="Delete" ConfirmTextFields="ISSUE_NO" ConfirmDialogType="RadWindow" ConfirmTitle="Confirm Delete">
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_NO" FilterControlAltText="Filter ISSUE_NO column" HeaderText="BULK PAINT ISSUE NO" SortExpression="ISSUE_NO" UniqueName="ISSUE_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="ISSUE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="ISSUE DATE" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="ISSUE_DATETextBox" runat="server" SelectedDate='<%# Bind("ISSUE_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="140px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ISSUE_DATELabel" runat="server" Text='<%# Eval("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_BY" ReadOnly="true" FilterControlAltText="Filter ISSUE_BY column" HeaderText="ISSUE BY" SortExpression="ISSUE_BY" UniqueName="ISSUE_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" ReadOnly="true" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUB CONTRACTOR" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                    </telerik:GridBoundColumn>                  
                    <telerik:GridBoundColumn DataField="PAINT_REQ_NO" ReadOnly="true" FilterControlAltText="Filter PAINT_REQ_NO column" HeaderText="BULK PAINT JC" SortExpression="PAINT_REQ_NO" UniqueName="PAINT_REQ_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <div style="background-color:whitesmoke; margin-top:3px;">
        <telerik:RadButton ID="btnCreateTransfer" runat="server" Text="Create Material Transfer" Width="180px" OnClick="btnCreateTransfer_Click"></telerik:RadButton>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ISSUE_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />       
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_ISSUE_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR"></asp:SqlDataSource>
</asp:Content>

