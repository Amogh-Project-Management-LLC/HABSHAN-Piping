<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MTNReceiveDetail.aspx.cs" Inherits="Material_MTNReceiveDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="background-color: whitesmoke">
                <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Width="120px" OnClick="btnAdd_Click"></telerik:RadButton>
            </div>
            <div>
                <table runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Material Code</td>
                        <td>
                            <telerik:RadComboBox ID="cboMatCode" runat="server" Width="200px" AllowCustomText="True" DataSourceID="sqlMaterialSource" DataTextField="MAT_CODE1"
                                DataValueField="MAT_ID" Filter="Contains" AutoPostBack="true" OnSelectedIndexChanged="cboMatCode_SelectedIndexChanged">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Heat No</td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="txtAutoHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO" EmptyMessage="Start typing Heat No....." InputType="Text"></telerik:RadAutoCompleteBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Paint System</td>
                        <td>
                            <telerik:RadTextBox ID="txtAutoPS" runat="server"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Receive Qty</td>
                        <td>
                            <telerik:RadTextBox ID="txtReceiveQty" runat="server" Width="160px" EmptyMessage="Receive Qty.."></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">ESD</td>
                        <td>
                            <telerik:RadTextBox ID="txtExcess" runat="server" Width="80px" EmptyMessage="Excess.."></telerik:RadTextBox>
                            <telerik:RadTextBox ID="txtShort" runat="server" Width="80px" EmptyMessage="Shortage.."></telerik:RadTextBox>
                            <telerik:RadTextBox ID="txtDamage" runat="server" Width="80px" EmptyMessage="Damage.."></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="itemsGrid" runat="server" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="None">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="RCV_ITEM_ID" EditMode="InPlace"
                         AllowAutomaticUpdates="true">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ITEM_NAM" ReadOnly="true" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM_NAM" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RCV_QTY" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV_QTY" SortExpression="RCV_QTY" UniqueName="RCV_QTY" DataType="System.Decimal">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" HeaderText="PAINT_SYS" SortExpression="PAINT_SYS" UniqueName="PAINT_SYS">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SHORT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SHORT_QTY column" HeaderText="SHORT_QTY" SortExpression="SHORT_QTY" UniqueName="SHORT_QTY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DAMAGE_QTY" DataType="System.Decimal" FilterControlAltText="Filter DAMAGE_QTY column" HeaderText="DAMAGE_QTY" SortExpression="DAMAGE_QTY" UniqueName="DAMAGE_QTY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EXCESS_QTY" DataType="System.Decimal" FilterControlAltText="Filter EXCESS_QTY column" HeaderText="EXCESS_QTY" SortExpression="EXCESS_QTY" UniqueName="EXCESS_QTY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
            <div style="margin-top: 3px">
                <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80px" OnClick="btnDelete_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="false"></telerik:RadButton>
                <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="false" OnClick="btnNo_Click"></telerik:RadButton>
            </div>
            <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter" UpdateMethod="UpdateQuery">
                <DeleteParameters>
                    <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" Type="Decimal" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RCV_QTY" Type="Decimal" />
                    <asp:Parameter Name="HEAT_NO" Type="String" />
                    <asp:Parameter Name="PAINT_SYS" Type="String" />
                    <asp:Parameter Name="REMARKS" Type="String" />
                    <asp:Parameter Name="SHORT_QTY" Type="Decimal" />
                    <asp:Parameter Name="DAMAGE_QTY" Type="Decimal" />
                    <asp:Parameter Name="EXCESS_QTY" Type="Decimal" />
                    <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:SqlDataSource ID="sqlMaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1
FROM VIEW_MAT_TRANSFER_RCV_BAL
WHERE TRANSF_ID = (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID = :RCV_ID)
AND BAL_QTY &gt; 0">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlHeatNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT HEAT_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID =:MAT_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenMatID" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlPaintSystem" runat="server"></asp:SqlDataSource>
            <asp:HiddenField ID="HiddenMatID" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

