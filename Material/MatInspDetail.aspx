<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatInspDetail.aspx.cs" Inherits="Material_MatInspDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="110" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnUpdate" runat="server" Text="Update Weight" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnImportMRV" runat="server" Text="Import From MRV" OnClick="btnImportMRV_Click" Enabled="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="grdMRIRItems" runat="server" AllowPaging="True" DataSourceID="ObjSrcMRIRItems" AllowAutomaticDeletes="True"
            AllowAutomaticUpdates="True" OnSelectedIndexChanged="grdMRIRItems_SelectedIndexChanged" Font-Size="9pt">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings EnablePostBackOnRowClick="true">
                <Selecting AllowRowSelect="true" />

            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="ObjSrcMRIRItems" DataKeyNames="MIR_ITEM_ID" EditMode="InPlace"
                EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true"
                EditFormSettings-PopUpSettings-OverflowPosition="Center">
                <Columns>
                    <%--<telerik:GridClientDeleteColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Confirm Delete"
                        ConfirmText="Are you sure you want to delete this record ?" ImageUrl="../Images/icon-cancel.gif"
                        ConfirmDialogWidth="400px">
                    </telerik:GridClientDeleteColumn>--%>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton" ConfirmText="Are you sure you want to delete this record ?" 
                         ConfirmDialogType="RadWindow" ConfirmTitle="Confirm Delete"></telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM">
                        <EditItemTemplate>
                            <asp:TextBox ID="PO_ITEMTextBox" runat="server" Text='<%# Bind("PO_ITEM") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="PO_ITEMLabel" runat="server" Text='<%# Eval("PO_ITEM") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="MIR_ITEM" FilterControlAltText="Filter MIR_ITEM column" HeaderText="MIR ITEM" SortExpression="MIR_ITEM" UniqueName="MIR_ITEM">
                        <EditItemTemplate>
                            <asp:TextBox ID="MIR_ITEMTextBox" runat="server" Text='<%# Bind("MIR_ITEM") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="MIR_ITEMLabel" runat="server" Text='<%# Eval("MIR_ITEM") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="ITEM CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV QTY" SortExpression="RCV_QTY" UniqueName="RCV_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="RCV_QTYTextBox" runat="server" Text='<%# Bind("RCV_QTY") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RCV_QTYLabel" runat="server" Text='<%# Eval("RCV_QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="ACPT_QTY" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACPT QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="ACPT_QTYTextBox" runat="server" Text='<%# Bind("ACPT_QTY") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ACPT_QTYLabel" runat="server" Text='<%# Eval("ACPT_QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="AS_PER_PL_QTY" DataType="System.Decimal" FilterControlAltText="Filter AS_PER_PL_QTY column" HeaderText="PL QTY" SortExpression="AS_PER_PL_QTY" UniqueName="AS_PER_PL_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="AS_PER_PL_QTYTextBox" runat="server" Text='<%# Bind("AS_PER_PL_QTY") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="AS_PER_PL_QTYLabel" runat="server" Text='<%# Eval("AS_PER_PL_QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TOTAL_WT" ReadOnly="true" FilterControlAltText="Filter TOTAL_WT column" HeaderText="WEIGHT (KG)" SortExpression="TOTAL_WT" UniqueName="TOTAL_WT" DataType="System.Decimal">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="HEAT_NOTextBox" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="HEAT_NOLabel" runat="server" Text='<%# Eval("HEAT_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" HeaderText="PAINT SYS" SortExpression="PAINT_SYS" UniqueName="PAINT_SYS">
                        <EditItemTemplate>
                            <asp:TextBox ID="PAINT_SYSTextBox" runat="server" Text='<%# Bind("PAINT_SYS") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="PAINT_SYSLabel" runat="server" Text='<%# Eval("PAINT_SYS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TC_CODE" ReadOnly="true" FilterControlAltText="Filter TC_CODE column" HeaderText="MTC CODE" SortExpression="TC_CODE" UniqueName="TC_CODE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" ReadOnly="true" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                        <EditItemTemplate>
                            <asp:TextBox ID="REMARKSTextBox" runat="server" Text='<%# Bind("REMARKS") %>' Width="150px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REMARKSLabel" runat="server" Text='<%# Eval("REMARKS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>

                    <PopUpSettings Modal="True" KeepInScreenBounds="True"></PopUpSettings>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="ObjSrcMRIRItems" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MIR_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_MIR_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MIR_ID" QueryStringField="MIR_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RCV_QTY" Type="Decimal" />
            <asp:Parameter Name="ACPT_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="PAINT_SYS" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="MIR_ITEM" Type="String" />
            <asp:Parameter Name="SUBSTORE_ID" Type="Decimal" />
            <asp:Parameter Name="TOTAL_WT" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="CEVALUE" Type="Decimal" />
            <asp:Parameter Name="AS_PER_PL_QTY" Type="Decimal" />
            <asp:Parameter Name="Original_MIR_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

