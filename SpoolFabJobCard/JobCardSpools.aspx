<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JobCardSpools.aspx.cs" Inherits="Material_FabricationJobCardItems" Theme="Blue"
    Title="Jobcard Spools" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnJCList" runat="server" Text="Back" Width="80" OnClick="btnJCList_Click"></telerik:RadButton>
                        </td>
                        <td style="width: 100%; text-align: right">
                            <telerik:RadTextBox ID="txtSearch" runat="server" 
                                EmptyMessage="Search Here" Width="200px" AutoPostBack="True">
                            </telerik:RadTextBox>
                        </td>
                        <td style="width: 100%; text-align: right;">
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="140px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="spoolsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="JcSpoolsDataSource" Width="100%" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" OnItemCommand="spoolsGridView_ItemCommand"
                    PageSize="20" OnDataBound="spoolsGridView_DataBound" DataKeyNames="WO_ID,SPL_ID"
                    OnInsertCommand="spoolsGridView_InsertCommand" OnUpdateCommand="spoolsGridView_UpdateCommand" OnDeleteCommand="spoolsGridView_DeleteCommand">
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <MasterTableView DataSourceID="JcSpoolsDataSource" DataKeyNames="WO_ID,SPL_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="10px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this Spool?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                            </telerik:GridButtonColumn>

                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="JC_REV" HeaderText="JC Rev" SortExpression="JC_REV" />
                            <telerik:GridBoundColumn DataField="JC_SCR" HeaderText="JC SCR" SortExpression="JC_SCR" />
                            <telerik:GridBoundColumn DataField="JC_FCR" HeaderText="JC FCR" SortExpression="JC_FCR" />
                            <telerik:GridBoundColumn DataField="SPL_REV" HeaderText="Latest Rev" SortExpression="SPL_REV" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SPL_SIZE" HeaderText="Spool Size" SortExpression="SPL_SIZE" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="MAT_TYPE" HeaderText="Mat Type" SortExpression="MAT_TYPE" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SHOP_ID" HeaderText="Shop ID" SortExpression="SHOP_ID" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="PS" HeaderText="PS" SortExpression="PS" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="WBS_AREA" HeaderText="WBS AREA" SortExpression="WBS_AREA" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>

    </table>
    <asp:ObjectDataSource ID="JcSpoolsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsFabricationJCTableAdapters.PIP_WORK_ORD_SPOOLTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_WO_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="JC_REV" Type="String" />
            <asp:Parameter Name="JC_SCR" Type="String" />
            <asp:Parameter Name="JC_FCR" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_WO_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
