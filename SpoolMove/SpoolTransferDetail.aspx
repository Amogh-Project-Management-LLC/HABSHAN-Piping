<%@ Page Title="SpoolTrans Details" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolTransferDetail.aspx.cs" Inherits="SpoolMove_SpoolTransferDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAddSpool" runat="server" Text="Add Spool" Width="100px"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
             AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowPaging="True" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="TRANS_ITEM_ID" EditMode="InPlace">
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                     <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Confirm Delete" ConfirmTextFormatString="Are you sure you want to delete {0}/{1} ?"
                        ConfirmTextFields="ISO_TITLE1,SPOOL">
                    </telerik:GridButtonColumn>
                     <telerik:GridBoundColumn DataField="AREA_L2" ReadOnly="true" FilterControlAltText="Filter AREA_L2 column" HeaderText="AREA L2" SortExpression="AREA_L2" UniqueName="AREA_L2" AllowFiltering="true" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" ReadOnly="true" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" AllowFiltering="true" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" ReadOnly="true" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_REV" ReadOnly="true" FilterControlAltText="Filter SPL_REV column" HeaderText="SPL REV" SortExpression="SPL_REV" UniqueName="SPL_REV" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SCR" ReadOnly="true" FilterControlAltText="Filter SPL_SCR column" HeaderText="SPL SCR" SortExpression="SPL_SCR" UniqueName="SPL_SCR" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_FCR" ReadOnly="true" FilterControlAltText="Filter SPL_FCR column" HeaderText="SPL FCR" SortExpression="SPL_FCR" UniqueName="SPL_FCR" AllowFiltering="false">
                    </telerik:GridBoundColumn>                
                    <telerik:GridBoundColumn DataField="SPL_SIZE" ReadOnly="true" FilterControlAltText="Filter SPL_SIZE column" HeaderText="SPL SIZE" SortExpression="SPL_SIZE" UniqueName="SPL_SIZE" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAIN_MAT" ReadOnly="true" FilterControlAltText="Filter MAIN_MAT column" HeaderText="MAIN MAT" SortExpression="MAIN_MAT" UniqueName="MAIN_MAT" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DOC_NO" ReadOnly="true" FilterControlAltText="Filter DOC_NO column" HeaderText="DOC NO" SortExpression="DOC_NO" UniqueName="DOC_NO" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="true" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSpoolReportsDTableAdapters.VIEW_SPL_TRANSFER_DETAILTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_TRANS_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="TRANS_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_TRANS_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

