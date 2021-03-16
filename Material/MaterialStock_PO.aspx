<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_PO.aspx.cs" Inherits="Material_MaterialStock_PO" Title="Material PO" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px" OnClick="btnDWN_Click"> </telerik:RadButton>
    </div>

    <div>
        <telerik:RadGrid ID="poGridView" runat="server" AutoGenerateColumns="False" DataSourceID="poDataSource"
            AllowPaging="True" DataKeyNames="PO_ID" PageSize="20" Width="100%">
            <MasterTableView AutoGenerateColumns="false" DataSourceID="poDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="PO_NO" HeaderText="PO Number" SortExpression="PO_NO" />
                    <telerik:GridBoundColumn DataField="PO_DATE" HeaderText="PO Date" SortExpression="PO_DATE"
                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                    <telerik:GridBoundColumn DataField="PO_ITEM" HeaderText="PO Item" SortExpression="PO_ITEM" />
                    <telerik:GridBoundColumn DataField="PA_ITEM" HeaderText="Par No" SortExpression="PA_ITEM" />
                    <telerik:GridBoundColumn DataField="PO_QTY" HeaderText="PO Qty" SortExpression="PO_QTY" />
                    <telerik:GridBoundColumn DataField="ETA" HeaderText="ETA" SortExpression="ETA"
                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                    <telerik:GridBoundColumn DataField="RECEIVED_DT" HeaderText="Recvd Date" SortExpression="RECEIVED_DT"
                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="poDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID, PO_NO, PO_DATE, PO_ITEM, PA_ITEM, PO_QTY, CUR_DEL, ETA, RECEIVED_DT FROM VIEW_TOTAL_PO WHERE (MAT_ID = :MAT_ID) ORDER BY PO_NO, PO_ITEM">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
