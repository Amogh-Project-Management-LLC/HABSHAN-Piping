<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SuppRequest.aspx.cs" Inherits="PipeSupport_SuppRequest" Title="Support Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: whitesmoke">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnRegist" runat="server" Text="Register" Width="80px" OnClick="btnRegist_Click" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                                EmptyMessage="Search Here" Width="195px" BackColor="#FFFF66" Style="background-color: #FFFFCC">
                            </telerik:RadTextBox>
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
                            CssClass="DataWebControlStyle" DataSourceID="rowsDataSource" Width="100%" DataKeyNames="REQ_ID"
                            PageSize="15" OnRowEditing="rowsGridView_RowEditing">
                            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                            <MasterTableView DataKeyNames="REQ_ID" AllowAutomaticUpdates="true">
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                                    
                                    <telerik:GridBoundColumn DataField="SUPP_REQ_NO" HeaderText="Receive No" SortExpression="SUPP_REQ_NO" />
                                    <telerik:GridBoundColumn DataField="REQ_DATE" HeaderText="Receive Date" SortExpression="REQ_DATE"
                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
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
                            <telerik:RadButton ID="btnView" runat="server" Text="Support List" Width="100px" OnClick="btnView_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" Text="Yes" Visible="False" Width="44px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="44px" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadButton ID="btnPreview" runat="server" OnClick="btnPreview_Click" Text="Preview" Width="80px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_BTableAdapters.VIEW_SUPP_REQUESTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SUPP_REQ_NO" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SUPP_REQ_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
