<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatInspDetailImport.aspx.cs" Inherits="Material_MatInspDetailImport" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sqlMRIRImport" CellSpacing="-1" GridLines="Both">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlMRIRImport">
                <Columns>
                    
                    <telerik:GridBoundColumn DataField="MAT_ID" DataType="System.Decimal" FilterControlAltText="Filter MAT_ID column" HeaderText="MAT_ID" SortExpression="MAT_ID" UniqueName="MAT_ID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO_ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM" FilterControlAltText="Filter MR_ITEM column" HeaderText="MR_ITEM" SortExpression="MR_ITEM" UniqueName="MR_ITEM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RECV_QTY column" HeaderText="RECV_QTY" SortExpression="RECV_QTY" UniqueName="RECV_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Accept">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtAccQty" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Shortage">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtShortQty" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Damage">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtDamQty" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Excess">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtExcQty" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Heat No">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtHeatNo" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="MTC No">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtMTC" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Substore">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtSubstore" runat="server" Width="50"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlMRIRImport" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT A.MAT_ID, B.MAT_CODE1, A.PO_ITEM, A.MR_ITEM, A.RECV_QTY FROM PIP_MAT_RECEIVE_DETAIL A, PIP_MAT_STOCK B WHERE A.MAT_ID = B.MAT_ID AND (A.MAT_RCV_ID = :MAT_RCV_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" DefaultValue="-1" Name="MAT_RCV_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>

