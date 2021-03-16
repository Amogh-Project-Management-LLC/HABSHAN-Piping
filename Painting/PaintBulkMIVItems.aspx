<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PaintBulkMIVItems.aspx.cs" Inherits="Painting_PaintBulkMIVItems" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <style type="text/css">
                .Heading {
                    background-color: whitesmoke;
                    width: 120px;
                    padding-left: 5px;
                }
            </style>
            <div style="background-color: whitesmoke">
                <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Width="120px" OnClick="btnAdd_Click"></telerik:RadButton>

            </div>
            <div>
                <table runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td class="Heading">Material Code:
                        </td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="txtAutoMatCode" runat="server" AutoPostBack="True" DataSourceID="sqlMatSource"
                                DataTextField="MAT_CODE1" DataValueField="MAT_ID" EmptyMessage="Type Material Code.." InputType="Text"
                                OnEntryAdded="txtAutoMatCode_EntryAdded" OnTextChanged="txtAutoMatCode_TextChanged">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Heat No:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                OnDataBinding="cboHeatNo_DataBinding" AppendDataBoundItems="true"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Paint System:
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboPaintSystem" runat="server" DataSourceID="sqlPaintSystem" DataTextField="PAINT_CODE" DataValueField="PAINT_CODE"
                                OnDataBinding="cboPaintSystem_DataBinding" AppendDataBoundItems="true"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Required Qty:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtReqQty" runat="server" Width="100px" EmptyMessage="Required.."></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Issue Qty:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueQty" runat="server" Width="100px" EmptyMessage="Issue Qty.."></telerik:RadTextBox>
                            <telerik:RadTextBox ID="txtPipePiece" runat="server" Width="120px" EmptyMessage="Pipe Piece Qty.." Enabled="false"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Sub Store:
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="ddlSubStore" runat="server" AppendDataBoundItems="True" DataSourceID="sqlSubStore" DataTextField="STORE_L1" DataValueField="SUBSTORE_ID" OnDataBinding="ddlSubStore_DataBinding"></telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Remarks :
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRemarks" runat="server"></telerik:RadTextBox>
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
                <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource"
                     AllowAutomaticDeletes="true" OnItemCommand="itemsGrid_ItemCommand">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="ISSUE_ITEM_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridButtonColumn CommandName="Delete" ConfirmDialogType="RadWindow"
                                ConfirmText="Are you sure you want to delete ?" ConfirmTitle="Confirm Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ITEM_NAM" ReadOnly="true" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM_NAM" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SIZE_DESC" ReadOnly="true" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE_DESC" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_QTY" DataType="System.Decimal" FilterControlAltText="Filter ISSUE_QTY column" HeaderText="ISSUE_QTY" SortExpression="ISSUE_QTY" UniqueName="ISSUE_QTY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAINT_CODE" FilterControlAltText="Filter PAINT_CODE column" HeaderText="PAINT_CODE" SortExpression="PAINT_CODE" UniqueName="PAINT_CODE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
            <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPaintingMatTableAdapters.VIEW_BULK_PAINT_ISSUE_DETAILTableAdapter" UpdateMethod="UpdateQuery">
                <DeleteParameters>
                    <asp:Parameter Name="original_ISSUE_ITEM_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID" Type="Decimal" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ISSUE_QTY" Type="Decimal" />
                    <asp:Parameter Name="HEAT_NO" Type="String" />
                    <asp:Parameter Name="REMARKS" Type="String" />
                    <asp:Parameter Name="PAINT_CODE" Type="String" />
                    <asp:Parameter Name="original_ISSUE_ITEM_ID" Type="Decimal" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1
FROM VIEW_BULK_PAINT_ISSUE_BAL
WHERE PAINT_ID = :PAINT_ID
ORDER BY MAT_CODE1">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenPaintID" DefaultValue="XXX" Name="PAINT_ID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlHeatNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT HEAT_NO
FROM PRC_MAT_INSP_DETAIL
WHERE MAT_ID = :MAT_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenMatID" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlPaintSystem" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PAINT_CODE 
FROM PIP_PAINTING_MAT_DETAIL, PIP_PAINTING_MAT
WHERE PIP_PAINTING_MAT_DETAIL.PAINT_ID = PIP_PAINTING_MAT.PAINT_ID
AND PIP_PAINTING_MAT_DETAIL.PAINT_ID IN (SELECT PAINT_JC_ID FROM PIP_BULK_PAINT_ISSUE WHERE ISSUE_ID = :ISSUE_ID)">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSubStore" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUBSTORE_ID, STORE_L1 
FROM STORES_SUB
WHERE STORE_ID = :STORE_ID
ORDER BY STORE_L1">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlSubStore" DefaultValue="-1" Name="STORE_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenPaintID" runat="server" />
            <asp:HiddenField ID="HiddenMatID" runat="server" />
            <asp:HiddenField ID="HiddenSCID" runat="server" />

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

