<%@ Page Title="MRIR" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatInsp.aspx.cs" Inherits="Material_MatInsp" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="New MRIR" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnMaterial" runat="server" Text="Material List" Width="110" OnClick="btnMaterial_Click"></telerik:RadButton>
                    <telerik:RadDropDownList runat="server" ID="ddlReport" Height="25px" Width="170px">
                        <Items>
                            <telerik:DropDownListItem Text="(Select Report)" />
                            <telerik:DropDownListItem  Text="Pre-Inspection Report" Value="1" />
                            <telerik:DropDownListItem Text="Post-Inspection Report" Value="2" />
                        </Items>
                    </telerik:RadDropDownList>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Bulk Import.." Width="110"
                        OnClick="btnImport_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnESD" runat="server" Text="Create ESD" Width="100" OnClick="btnESD_Click"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search MRIR...." Width="250px"
                        AutoPostBack="true">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="min-height: 20px">
                <telerik:RadGrid ID="grdMRIR" runat="server" OnSelectedIndexChanged="grdMRIR_SelectedIndexChanged" CellSpacing="-1" DataSourceID="itemsDataSource" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowPaging="True"
                    PageSize="15" Font-Size="9pt" MasterTableView-EditMode="InPlace" OnDataBound="grdMRIR_DataBound" OnItemDataBound="grdMRIR_ItemDataBound">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings EnablePostBackOnRowClick="False">
                        <Selecting AllowRowSelect="true" />

                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="MIR_ID">
                        <Columns>
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" ButtonType="ImageButton" ConfirmTitle="Confirm Delete" ConfirmText="Are you sure you want to Delete this record ?"
                                CommandName="Delete">
                            </telerik:GridButtonColumn>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                            <telerik:GridTemplateColumn DataField="PDF_URL" FilterControlAltText="Filter PDF_URL column" HeaderText="PDF" SortExpression="PDF_URL" UniqueName="PDF_URL" AllowFiltering="False" ReadOnly="true">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("PDF_URL") %>'
                                        Target="_blank">
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/icons/pdf-icon.png" Visible="false" />
                                    </asp:HyperLink>
                                </ItemTemplate>
                                <ItemStyle Width="25px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="MIR_NO" FilterControlAltText="Filter MIR_NO column" HeaderText="MRIR NUMBER" SortExpression="MIR_NO" UniqueName="MIR_NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="MIR_NOTextBox" runat="server" Text='<%# Bind("MIR_NO") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="MIR_NOLabel" runat="server" Text='<%# Eval("MIR_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="MRV_NUMBER" ReadOnly="true" FilterControlAltText="Filter MRV_NUMBER column" HeaderText="MRV NUMBER" SortExpression="MRV_NUMBER" UniqueName="MRV_NUMBER">
                                <EditItemTemplate>
                                    <asp:TextBox ID="MRV_NUMBERTextBox" runat="server" Text='<%# Bind("MRV_NUMBER") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="MRV_NUMBERLabel" runat="server" Text='<%# Eval("MRV_NUMBER") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP NO" SortExpression="SHIP_NO" UniqueName="SHIP_NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SHIP_NOTextBox" runat="server" Text='<%# Bind("SHIP_NO") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="SHIP_NOLabel" runat="server" Text='<%# Eval("SHIP_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="SRN_NO" AllowFiltering="False" FilterControlAltText="Filter SRN_NO column" HeaderText="SRN NO" SortExpression="SRN_NO" UniqueName="SRN_NO">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="INSP_DATE" DataType="System.DateTime" FilterControlAltText="Filter INSP_DATE column" HeaderText="INSP DATE" SortExpression="INSP_DATE" UniqueName="INSP_DATE">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtInspDateEdit" runat="server" DbSelectedDate='<%# Bind("INSP_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy" Width="100px">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="INSP_DATELabel" runat="server" Text='<%# Eval("INSP_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" ReadOnly="true" DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="RECEIVE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtCreateDateEdit" runat="server" SelectedDate='<%# Bind("CREATE_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy" Width="100px">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="CREATE_BY" AllowFiltering="False" FilterControlAltText="Filter CREATE_BY column" HeaderText="RECEIVE BY" SortExpression="CREATE_BY" UniqueName="CREATE_BY" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PO_NO" AllowFiltering="false" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" SortExpression="PO_NO" UniqueName="PO_NO" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="STORE_NAME" AllowFiltering="false" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PDF_FLG" AllowFiltering="false" FilterControlAltText="Filter PDF_FLG column" HeaderText="PDF FLG" SortExpression="PDF_FLG" UniqueName="PDF_FLG" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                                <EditItemTemplate>
                                    <asp:TextBox ID="REMARKSTextBox" runat="server" Text='<%# Bind("REMARKS") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="REMARKSLabel" runat="server" Text='<%# Eval("REMARKS") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>

            <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter" UpdateMethod="UpdateQuery">
                <DeleteParameters>
                    <asp:Parameter Name="original_MIR_ID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PROJ_ID" Type="Decimal" />
                    <asp:Parameter Name="MIR_NO" Type="String" />
                    <asp:Parameter Name="INSP_DATE" Type="DateTime" />
                    <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
                    <asp:Parameter Name="CREATE_BY" Type="String" />
                    <asp:Parameter Name="PO_ID" Type="Decimal" />
                    <asp:Parameter Name="MRV_ID" Type="Decimal" />
                    <asp:Parameter Name="STORE_ID" Type="Decimal" />
                    <asp:Parameter Name="PDF_FLG" Type="String" />
                    <asp:Parameter Name="REMARKS" Type="String" />
                    <asp:Parameter Name="SRN_NO" Type="String" />
                    <asp:Parameter Name="SHIP_NO" Type="String" />
                    <asp:Parameter Name="MODE_OF_SHIPMENT" Type="String" />
                    <asp:Parameter Name="INVOICE_NO" Type="String" />
                    <asp:Parameter Name="PKG_LIST_NO" Type="String" />
                    <asp:Parameter Name="BL_AWB_TWBNO" Type="String" />
                    <asp:Parameter Name="MRIR_SC_ID" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" Type="Decimal" />
                    <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="MIR_NO" Type="String" />
                    <asp:Parameter Name="SHIP_NO" Type="String" />
                    <asp:Parameter Name="SRN_NO" Type="String" />
                    <asp:Parameter Name="REMARKS" Type="String" />
                    <asp:Parameter Name="INSP_DATE" Type="DateTime" />
                    <asp:Parameter Name="original_MIR_ID" Type="Decimal" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:SqlDataSource ID="sqlExportMIR" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MIR_NO, INSP_DATE, CREATE_DATE, PO_NO,PO_ITEM, MIR_ITEM, MRV_NUMBER, SRN_NO, SHIP_NO, SUPPLIER_VENDORNAME, MODE_OF_SHIPMENT, INVOICE_NO,
PKG_LIST_NO, BL_AWB_TWBNO, STORE_NAME, SUB_CON_NAME, SUBSTORE, MAT_CODE1, MAT_CODE2, SIZE_DESC, WALL_THK,
ITEM_NAM, MAT_DESCR, UOM, RCV_QTY, ACPT_QTY, AS_PER_PL_QTY, REJ_QTY, HEAT_NO, PAINT_SYS, ESD_NO, MISSING_QTY, DAMAGE_QTY,
EXCESS_QTY, CLEAR_QTY, TC_CODE, CEVALUE, REMARKS
FROM VIEW_MRIR_ESD
WHERE MIR_ID = :MIR_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="grdMRIR" DefaultValue="-1" Name="MIR_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlExportMIRAll" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MIR_NO, INSP_DATE, CREATE_DATE, PO_NO,PO_ITEM, MIR_ITEM, MRV_NUMBER, SRN_NO, SHIP_NO, SUPPLIER_VENDORNAME, MODE_OF_SHIPMENT, INVOICE_NO,
PKG_LIST_NO, BL_AWB_TWBNO, STORE_NAME, SUB_CON_NAME, SUBSTORE, MAT_CODE1, MAT_CODE2, SIZE_DESC, WALL_THK,
ITEM_NAM, MAT_DESCR, UOM, RCV_QTY, ACPT_QTY, AS_PER_PL_QTY, REJ_QTY, HEAT_NO, PAINT_SYS, ESD_NO, MISSING_QTY, DAMAGE_QTY,
EXCESS_QTY, CLEAR_QTY, TC_CODE, CEVALUE, REMARKS
FROM VIEW_MRIR_ESD
ORDER BY MIR_NO, MIR_ITEM"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnUploadPDF" runat="server" Text="Upload PDF" Width="120" Icon-PrimaryIconUrl="~/Images/icons/icon-upload.png">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="110" Icon-PrimaryIconUrl="~/Images/icons/icon-save2.png" OnClick="btnExport_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnExportAll" runat="server" Text="Export All" Width="110"
                        Icon-PrimaryIconUrl="~/Images/icons/icon-save2.png" OnClick="btnExportAll_Click">
                    </telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>
</asp:Content>

