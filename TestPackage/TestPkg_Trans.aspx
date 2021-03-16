<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_Trans.aspx.cs" Inherits="TestPkg_Trans" Title="Test Package Transmittal" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="79px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click" />
                        </td>
                        <td style="width: 100%" align="right">
                            <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                                AutoPostBack="True" Width="200px"></telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="TransGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="TPK_TRANS_ID" DataSourceID="tpkTransDataSource"
                    OnRowEditing="TransGridView_RowEditing" Width="100%" PageSize="15" OnDataBound="TransGridView_DataBound">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="TPK_TRANS_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton">
                            <ItemStyle Width="20px" />
                        </telerik:GridEditCommandColumn>
                        
                        <telerik:GridTemplateColumn HeaderText="TRANS_NO" SortExpression="TRANS_NO">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TRANS_NO") %>' Width="103px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("TRANS_NO") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="CREATE DATE" SortExpression="CREATE_DATE">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="67px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="100px" />
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                        
                        <telerik:GridBoundColumn DataField="TRANS_TYPE" HeaderText="CATEGORY" SortExpression="TRANS_TYPE"
                            ReadOnly="True" />
                        <telerik:GridTemplateColumn HeaderText="REMARKS" SortExpression="REMARKS">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("REMARKS") %>' Width="98%"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="40%" />
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                   </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnViewSpools" runat="server" OnClick="btnViewSpools_Click" Text="List"
                                Width="80px" BackColor="SkyBlue"/>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNewTrans" runat="server" Text="Register" Width="80px"  OnClick="btnNewTrans_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" Text="Yes" Visible="False"
                                Width="44px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False"
                                Width="44px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="tpkTransDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsTestPkg_BTableAdapters.TPK_TRANSTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_TRANS_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TRANS_NO" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TPK_TRANS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
