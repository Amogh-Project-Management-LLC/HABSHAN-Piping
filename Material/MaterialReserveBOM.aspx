<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialReserveBOM.aspx.cs" Inherits="Material_MaterialReserveBOM" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add" Width="80px"></telerik:RadButton>
    </div>
      <div style="margin-top:3px">
            <telerik:RadGrid ID="gvHoldDetails" runat="server" DataSourceID="dsHoldItemDetails" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" CellSpacing="0" GridLines="None"
                AllowPaging="True" AllowFilteringByColumn="True" PageSize="20">
                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView AutoGenerateColumns="False" DataSourceID="dsHoldItemDetails" ClientDataKeyNames="BOM_ID" EditMode="InPlace" DataKeyNames="BOM_ID">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle CssClass="MyImageButton" Width="20px" />
                            <HeaderStyle Width="20px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn">
                        </telerik:GridButtonColumn>
                        <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="ISOMETRIC No." SortExpression="ISO_TITLE1"
                            UniqueName="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" ReadOnly="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="80%">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SHEET" HeaderText="SHEET" SortExpression="SHEET"
                            UniqueName="SHEET" FilterControlAltText="Filter SHEET column" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL"
                            SortExpression="SPOOL" UniqueName="SPOOL" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PT_NO" FilterControlAltText="Filter PT_NO column" HeaderText="PT NO"
                            SortExpression="PT_NO" UniqueName="PT_NO" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATCODE"
                            SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AllowFiltering="true" ReadOnly="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BOM_RES_FLAG" FilterControlAltText="Filter BOM_RES_FLAG column" HeaderText="BOM_RES_FLAG"
                            SortExpression="BOM_RES_FLAG" UniqueName="BOM_RES_FLAG" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BOM_RES_QTY" FilterControlAltText="Filter BOM_RES_QTY column" HeaderText="BOM_RES_QTY"
                            SortExpression="BOM_RES_QTY" UniqueName="BOM_RES_QTY" AllowFiltering="false" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BOM_RES_REMARKS" FilterControlAltText="Filter BOM_RES_REMARKS column" HeaderText="BOM_RES_REMARKS"
                            SortExpression="BOM_RES_REMARKS" UniqueName="BOM_RES_REMARKS" AllowFiltering="false">
                        </telerik:GridBoundColumn>
                    </Columns>

                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    </EditFormSettings>

                    <BatchEditingSettings EditType="Cell"></BatchEditingSettings>

                    <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
                </MasterTableView>

                <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

                <FilterMenu EnableImageSprites="False"></FilterMenu>
            </telerik:RadGrid>
        </div>
        <asp:ObjectDataSource ID="dsHoldItemDetails" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsMaterialDTableAdapters.VIEW_ADAPTER_RES_BOMTableAdapter" DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
            <DeleteParameters>
                <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />                
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RES_ID" QueryStringField="REQ_ID" Type="Decimal" />
            </SelectParameters>
            <UpdateParameters>                
                <asp:Parameter Name="BOM_RES_REMARKS" Type="String" />
                <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
            </UpdateParameters>
        </asp:ObjectDataSource>

</asp:Content>

