<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CutlenRandomLenErr.aspx.cs" Inherits="CutlenRandomLenErr" Title="Random Length" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <asp:GridView ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="itemsDataSource" PageSize="20" Width="100%">
            <Columns>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Iso Title" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                <asp:BoundField DataField="WALL_THK" HeaderText="Thick" SortExpression="WALL_THK" />
                <asp:BoundField DataField="PIPE_EP1" HeaderText="EP1" SortExpression="PIPE_EP1" />
                <asp:BoundField DataField="PIPE_EP2" HeaderText="EP2" SortExpression="PIPE_EP2" />
                <asp:BoundField DataField="NET_QTY" HeaderText="BOM Qty" SortExpression="NET_QTY" />
                <asp:BoundField DataField="RANDOM_LEN" HeaderText="Random Len" SortExpression="RANDOM_LEN" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_TITLE1, SPOOL, PT_NO, MAT_CODE1, SIZE_DESC, WALL_THK, PIPE_EP1, PIPE_EP2, NET_QTY, RANDOM_LEN FROM VIEW_CUTLEN_RANDOM_LEN_ERR WHERE (ISSUE_ID = :ISSUE_ID) ORDER BY ISO_TITLE1, SPOOL, PT_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ISSUE_ID" QueryStringField="ISSUE_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>