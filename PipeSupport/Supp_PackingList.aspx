<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_PackingList.aspx.cs" Inherits="PipeSupport_Supp_PackingList" Title="Support Packing List" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%; background-color: gainsboro">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegist" runat="server" Text="New" Width="80" OnClick="btnRegist_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="Support List" Width="110" OnClick="btnView_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Search Here" Width="195px">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="width: 100%">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="rowsDataSource" Width="100%" DataKeyNames="PACKING_ID" SkinID="GridViewSkin"
                    PageSize="18" OnRowEditing="rowsGridView_RowEditing">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView AllowAutomaticUpdates="true" DataKeyNames="PACKING_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="PACKING_NO" HeaderText="Packing No" SortExpression="PACKING_NO" />
                            <telerik:GridBoundColumn DataField="PALLET_NO" HeaderText="Pallet No" SortExpression="PALLET_NO" />
                            <telerik:GridBoundColumn DataField="SHIP_NO" HeaderText="Ship No" SortExpression="SHIP_NO" />
                            <telerik:GridBoundColumn DataField="SHIP_DEPARTURE_DATE" HeaderText="Ship Departure Date" SortExpression="SHIP_DEPARTURE_DATE"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                            <telerik:GridBoundColumn DataField="ISSUE_DATE" HeaderText="Issue Date" SortExpression="ISSUE_DATE"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                            <telerik:GridBoundColumn DataField="ISSUED_BY" HeaderText="Issue By" SortExpression="ISSUED_BY" />
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtSearch" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50" OnClick="btnYes_Click" EnableViewState="false" Visible="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50" EnableViewState="false" Visible="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_ATableAdapters.VIEW_SUPP_PACKINGTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PACKING_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PACKING_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="ISSUED_BY" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="PALLET_NO" Type="String" />
            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="SHIP_DEPARTURE_DATE" Type="DateTime" />
            <asp:Parameter Name="Original_PACKING_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
