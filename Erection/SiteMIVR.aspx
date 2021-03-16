<%@ Page Title="Site MIV Revisions" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SiteMIVR.aspx.cs" Inherits="Erection_SiteMIVR" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="NewRev" runat="server" Text="New Revision" Width="110px"></telerik:RadButton>
        <telerik:RadButton ID="btnItem" runat="server" Text="Items" Width="80px" OnClick="btnItem_Click"></telerik:RadButton>
        <telerik:RadDropDownList ID="ddlReportType" runat="server">
            <Items>
                <telerik:DropDownListItem Text="(Select)" Value="" />
                <telerik:DropDownListItem Text="Summary" Value="1" />
            </Items>
        </telerik:RadDropDownList>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowPaging="True" PageSize="15">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                DataKeyNames="REV_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete ?"
                         ConfirmDialogType="RadWindow">
                        <ItemStyle Width="20px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_NO" ReadOnly="true" FilterControlAltText="Filter ISSUE_NO column" HeaderText="ISSUE NO" SortExpression="ISSUE_NO" UniqueName="ISSUE_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_NO" DataType="System.Decimal" FilterControlAltText="Filter REV_NO column" HeaderText="REV NO" SortExpression="REV_NO" UniqueName="REV_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MIVR_NO" FilterControlAltText="Filter MIVR_NO column" HeaderText="MIVR NO" SortExpression="MIVR_NO" UniqueName="MIVR_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_CREATED_AT" ReadOnly="true" DataType="System.DateTime" FilterControlAltText="Filter REV_CREATED_AT column" HeaderText="CREATE DATE" SortExpression="REV_CREATED_AT" UniqueName="REV_CREATED_AT">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_ISSUE_BY" ReadOnly="true" DataType="System.Decimal" FilterControlAltText="Filter REV_ISSUE_BY column" HeaderText="REV ISSUE BY" SortExpression="REV_ISSUE_BY" UniqueName="REV_ISSUE_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_REMARKS" FilterControlAltText="Filter REV_REMARKS column" HeaderText="REMARKS" SortExpression="REV_REMARKS" UniqueName="REV_REMARKS">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PDF_FLG" ReadOnly="true" FilterControlAltText="Filter PDF_FLG column" HeaderText="PDF_FLG" SortExpression="PDF_FLG" UniqueName="PDF_FLG">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionBTableAdapters.VIEW_SITE_MIV_REVTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_REV_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="id" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REV_NO" Type="Decimal" />
            <asp:Parameter Name="MIVR_NO" Type="String" />
            <asp:Parameter Name="REV_REMARKS" Type="String" />
            <asp:Parameter Name="original_REV_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

