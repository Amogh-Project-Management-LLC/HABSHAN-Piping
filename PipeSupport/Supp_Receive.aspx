<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_Receive.aspx.cs" Inherits="PipeSupport_Supp_Receive" Title="Support Receive" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: whitesmoke">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnRegist" runat="server" 
                                Text="Register" Width="80px" OnClick="btnRegist_Click" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                                EmptyMessage="Search Here" Width="195px" BackColor="#FFFF66" Style="background-color: #FFFFCC"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CssClass="DataWebControlStyle" DataSourceID="rowsDataSource" Width="100%" DataKeyNames="RECV_ID"
                            PageSize="15" OnRowEditing="rowsGridView_RowEditing">
                            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                            <MasterTableView DataKeyNames="RECV_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                                
                                <telerik:GridBoundColumn DataField="RECV_NO" HeaderText="Receive No" SortExpression="RECV_NO" />
                                <telerik:GridBoundColumn DataField="RECV_DATE" HeaderText="Receive Date" SortExpression="RECV_DATE"
                                    DataFormatString="{0:dd-MMM-yyyy}"  HtmlEncode="false" />
                                <telerik:GridBoundColumn DataField="AREA_L1" HeaderText="Area Name" SortExpression="AREA_L1" />
                                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Columns>
                                </MasterTableView>                       
                        </telerik:RadGrid>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke;">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnView" runat="server" 
                                Text="Iso Wise List" Width="120px" OnClick="btnView_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnBulkList" runat="server" 
                                Text="Bulk List" Width="100px" OnClick="btnBulkList_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" 
                                Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" 
                                EnableViewState="False" Text="Yes" Visible="False" Width="44px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" 
                                EnableViewState="False" Text="No" Visible="False" Width="44px" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadButton ID="btnPreview" runat="server" OnClick="btnPreview_Click" Text="Preview"
                                Width="80px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_ETableAdapters.VIEW_SUPP_RECEIVETableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_RECV_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="RECV_NO" Type="String" />
            <asp:Parameter Name="RECV_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="Original_RECV_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="RECV_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>