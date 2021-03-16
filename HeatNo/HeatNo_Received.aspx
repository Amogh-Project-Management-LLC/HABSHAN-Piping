<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_Received.aspx.cs" Inherits="HeatNo_HeatNo_Received" Title="Heat No - MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="ReceiveGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="receiveDataSource" Width="100%" AllowPaging="True" PageSize="13"
            OnDataBound="ReceiveGridView_DataBound">
            <MasterTableView>
                <Columns>                    
                    <telerik:GridBoundColumn DataField="MIR_NO" HeaderText="Receive No" SortExpression="MIR_NO" />
                    <telerik:GridBoundColumn DataField="INSP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Insp Date"
                        HtmlEncode="False" SortExpression="INSP_DATE" />
                    <telerik:GridBoundColumn DataField="CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Receive Date"
                        HtmlEncode="False" SortExpression="CREATE_DATE" />
                    <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thick" SortExpression="WALL_THK" />
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM" />
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat Number" SortExpression="HEAT_NO" />
                    <telerik:GridBoundColumn DataField="RCV_QTY" HeaderText="Recv'd Qty" SortExpression="RCV_QTY" />
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="receiveDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM VIEW_MAT_MRIR_SUMMARY
WHERE ((PROJECT_ID = :PROJECT_ID) AND (HEAT_NO = :HEAT_NO))'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
