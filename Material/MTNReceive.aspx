<%@ Page Title="MTN Receive" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MTNReceive.aspx.cs" Inherits="Material_MTNReceive" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="btnMaterial" runat="server" Text="Material" Width="80px" OnClick="btnMaterial_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
        <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
            EmptyMessage="Search Here" Width="200px" AutoPostBack="True">
        </telerik:RadTextBox>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" CellSpacing="-1">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" AllowAutomaticDeletes="true" DataKeyNames="RCV_ID"
                AllowAutomaticUpdates="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmTextFormatString="Are you sure you want to delete {0}?"
                        ConfirmTextFields="RCV_NUMBER" ConfirmDialogType="RadWindow">
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="RCV_NUMBER" ReadOnly="true" FilterControlAltText="Filter RCV_NUMBER column" HeaderText="RECEIVE NO" SortExpression="RCV_NUMBER" UniqueName="RCV_NUMBER">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_DATE" ReadOnly="true" DataType="System.DateTime" FilterControlAltText="Filter RCV_DATE column" HeaderText="RECEIVE DATE"
                        SortExpression="RCV_DATE" UniqueName="RCV_DATE" DataFormatString="{0:dd-MMM-yyyy}">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_BY" ReadOnly="true" FilterControlAltText="Filter RCV_BY column" HeaderText="RECEIVE BY" SortExpression="RCV_BY" UniqueName="RCV_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANSF_NO" ReadOnly="true" FilterControlAltText="Filter TRANSF_NO column" HeaderText="TRANSFER NO" SortExpression="TRANSF_NO" UniqueName="TRANSF_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CONTAINER_NO" ReadOnly="false" FilterControlAltText="Filter CONTAINER_NO column" HeaderText="CONTAINER NO" SortExpression="CONTAINER_NO" UniqueName="CONTAINER_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PACKING_LIST_NO" ReadOnly="false" FilterControlAltText="Filter PACKING_LIST_NO column" HeaderText="PACKING LIST NO" SortExpression="PACKING_LIST_NO" UniqueName="PACKING_LIST_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECEIVE_STORE" ReadOnly="true" FilterControlAltText="Filter RECEIVE_STORE column" HeaderText="RECEIVE STORE" SortExpression="RECEIVE_STORE" UniqueName="RECEIVE_STORE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" ReadOnly="false" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCVTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CONTAINER_NO" Type="String" />
            <asp:Parameter Name="PACKING_LIST_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

