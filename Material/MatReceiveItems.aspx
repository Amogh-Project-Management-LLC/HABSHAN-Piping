<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceiveItems.aspx.cs" Inherits="Material_MatReceiveItems" Title="MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .RadMenuStyle {
            z-index: 10;
            /*position:absolute;*/
        }
    </style>
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 180 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>

    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>

                </td>
                <td>
                    <telerik:RadButton ID="btnAddItems" runat="server" Text="Add Mats" Width="100" OnClick="btnAddItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Import From SRN" Width="140px" OnClick="btnImport_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtMatCode" runat="server" Width="200px" EmptyMessage="Search.." AutoPostBack="true"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="RCV_ITEM_ID" DataSourceID="RecvItemsDataSource" SkinID="GridViewSkin"
            Width="100%" PageSize="50" OnDataBound="itemsGridView_DataBound" OnRowUpdating="itemsGridView_RowUpdating"
            OnPageIndexChanged="itemsGridView_PageIndexChanged" OnSelectedIndexChanged="itemsGridView_SelectedIndexChanged">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" EnablePostBackOnRowClick="false" Scrolling-EnableColumnClientFreeze="true">
                <Selecting AllowRowSelect="True"></Selecting>
                <Scrolling AllowScroll="True" UseStaticHeaders="True" EnableColumnClientFreeze="True"></Scrolling>
            </ClientSettings>
            <MasterTableView EditMode="InPlace" DataKeyNames="RCV_ITEM_ID" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="50px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" ButtonType="ImageButton" ConfirmTitle="Confirm Delete" ConfirmText="Are you sure you want to Delete this record ?"
                        CommandName="Delete">
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM" HeaderText="MR_ITEM" ReadOnly="true" ItemStyle-Width="50px"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_NO" HeaderText="SRN_NO" ReadOnly="true"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" HeaderText="PO_ITEM" ReadOnly="true"></telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN_NO" UniqueName="IRN_NO" ReadOnly="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="IRN_NOTextBox" runat="server" Text='<%# Bind("IRN_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="IRN_NOLabel" runat="server" Text='<%# Eval("IRN_NO") %>' Width="150px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MAT_CODE1" ReadOnly="true"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_QTY" HeaderText="SRN Qty" ReadOnly="true"></telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RECV_QTY" FilterControlAltText="Filter RECV_QTY column" HeaderText="Receive Qty" UniqueName="RECV_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="RECV_QTYTextBox" runat="server" Text='<%# Bind("RECV_QTY") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RECV_QTYLabel" runat="server" Text='<%# Eval("RECV_QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ACT_LEN" HeaderText="Length(Pipe)" ReadOnly="true"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                    <telerik:GridTemplateColumn DataField="UNIT_WEIGHT" FilterControlAltText="Filter UNIT_WEIGHT column" HeaderText="Unit Weight" SortExpression="UNIT_WEIGHT" UniqueName="UNIT_WEIGHT">
                        <EditItemTemplate>
                            <asp:TextBox ID="UNIT_WEIGHTTextBox" runat="server" Text='<%# Bind("UNIT_WEIGHT") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="UNIT_WEIGHTLabel" runat="server" Text='<%# Eval("UNIT_WEIGHT") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />

                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>

            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="RecvItemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsPO_ShipmentATableAdapters.PIP_MAT_RECEIVE_DETAILTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="RECV_QTY" Type="Decimal" />
            <asp:Parameter Name="UNIT_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RCV_ID" QueryStringField="MAT_RCV_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="statusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STATUS_ID, STATUS_CODE FROM PIP_MAT_STATUS"></asp:SqlDataSource>
</asp:Content>
