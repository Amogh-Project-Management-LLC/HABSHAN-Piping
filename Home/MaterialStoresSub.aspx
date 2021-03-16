<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStoresSub.aspx.cs" Inherits="Material_StoresSub" Title="Substores" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="77px" OnClick="btnBack_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEntry" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Entry" Width="80px" OnClick="btnEntry_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="storeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="SUBSTORE_ID" DataSourceID="storeDataSource"
                    OnRowEditing="storeGridView_RowEditing" PageSize="15" Width="100%" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
                    <ClientSettings Selecting-AllowRowSelect="true">
                    </ClientSettings>

                    <MasterTableView EditMode="InPlace" DataSourceID="storeDataSource" DataKeyNames="SUBSTORE_ID">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="10px" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this Sub Store?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                            </telerik:GridButtonColumn>

                            <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Main Store" ReadOnly="True" SortExpression="STORE_NAME" />
                            <telerik:GridTemplateColumn HeaderText="Substore" SortExpression="STORE_L1">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="TextBox1" runat="server" Text='<%# Bind("STORE_L1") %>' Width="100px"></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("STORE_L1") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Location" SortExpression="LOCATION">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="TextBox4" runat="server" Text='<%# Bind("LOCATION") %>' Width="107px"></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <telerik:RadLabel ID="Label4" runat="server" Text='<%# Bind("LOCATION") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>

                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox ID="txtStore" runat="server" Visible="true" Width="200px"
                                EmptyMessage="New Substore">
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" BorderColor="SteelBlue"
                                Text="Submit" Width="84px" Visible="true" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="storeDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialATableAdapters.PIP_STORE_SUBTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SUBSTORE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="STORE_L1" Type="String" />
            <asp:Parameter Name="LOCATION" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_SUBSTORE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="STORE_ID" QueryStringField="STORE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
