<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_TransList.aspx.cs" Inherits="TestPkg_TransList" Title="Test Package Transmittal" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Width="77px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEntryMode" runat="server" OnClick="btnEntryMode_Click" Text="Entry" Width="79px" />
                        </td>
                        <td align="right" style="width: 100%">
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="137px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="itemsDataSource" PageSize="18" Width="100%"
                    OnRowEditing="itemsGridView_RowEditing" OnDataBound="itemsGridView_DataBound"
                    DataKeyNames="TPK_TRANS_ID,TPK_ID">
                    <MasterTableView DataKeyNames="TPK_TRANS_ID,TPK_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="TPK_NUMBER" HeaderText="Test Package No" SortExpression="TPK_NUMBER" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnRefresh" runat="server" Text="Refresh" Width="84px" OnClick="btnRefresh_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Width="84px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="43px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="43px" />
                        </td>
                        <td>
                            <asp:Label ID="lblSC" runat="server" Visible="False"></asp:Label>
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox EmptyMessage="Test Pack No" ID="txtFilter" runat="server" AutoPostBack="True"
                                Visible="False" Width="250px" OnTextChanged="txtIsome_TextChanged" />
                        </td>
                        <td>
                            <asp:DropDownList ID="cboNewTpk" runat="server" DataSourceID="newTpkDataSource" DataTextField="TPK_NUMBER"
                                DataValueField="TPK_ID" Visible="False" Width="250px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnAddTpk" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                OnClick="btnAddTpk_Click" Text="Add Tpk" Visible="False" Width="80px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsTestPkg_BTableAdapters.TPK_TRANS_LISTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
            <asp:Parameter Name="Original_TPK_TRANS_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TPK_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TPK_ID" Type="Decimal" />
            <asp:Parameter Name="Original_TPK_TRANS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TPK_TRANS_ID" QueryStringField="TPK_TRANS_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="newTpkDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TPK_ID, TPK_NUMBER FROM TPK_MASTER WHERE (PROJ_ID = :PROJET_ID) AND (TPK_NUMBER LIKE FNC_FILTER(:FILTER))">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJET_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtFilter" DefaultValue="~" Name="FILTER" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
