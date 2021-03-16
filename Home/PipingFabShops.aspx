<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipingFabShops.aspx.cs" Inherits="Home_PipingFabShops" Title="Fabrication Shops" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;padding:5px;">

        <telerik:RadButton ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            Text="Back" Width="80px" OnClick="btnBack_Click" CausesValidation="False" />
        <telerik:RadButton ID="btnEntry" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
        <telerik:RadButton ID="btnSave" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            Visible="false" Text="Save" Width="80px" OnClick="btnSave_Click" />
       
    </div>

    <table style="width: 100%">

        <tr>
            <td>
                <table style="width: 100%" runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Shop ID
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubconID" runat="server" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="subconIdValidator" runat="server" ControlToValidate="txtSubconID"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Shop No
                        </td>
                        <td>
                            <asp:TextBox ID="txtShopNo" runat="server" Width="160px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="shopNoValidator" runat="server" ControlToValidate="txtShopNo"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Shop Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtSubconName" runat="server" Width="160px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="subconNameValidator" runat="server" ControlToValidate="txtSubconName"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 160px; background-color: #ccccff">Subcon Name
                        </td>
                        <td>
                            <asp:DropDownList ID="ddSubcon" runat="server" Width="160px" AppendDataBoundItems="True"
                                DataSourceID="subconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID">
                                <asp:ListItem Value="-1" Text="&lt;Subcon&gt;" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="ddSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="PipingSpecGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="matTypeDataSource" PageSize="15" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                    Width="100%"  DataKeyNames="SHOP_ID">
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <MasterTableView DataSourceID="matTypeDataSource" DataKeyNames="SHOP_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="10px" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this Sub Store?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="Shop ID" SortExpression="SHOP_ID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SHOP_ID") %>' Width="50px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("SHOP_ID") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Shop No" SortExpression="SHOP_NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("SHOP_NO") %>' Width="120px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SHOP_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Shop Name" SortExpression="SHOP_NAME">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SHOP_NAME") %>' Width="120px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("SHOP_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Subcon Name" SortExpression="SUB_CON_NAME">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("SUB_CON_ID") %>'
                                        Width="120px" DataSourceID="subconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>

    </table>
    <asp:ObjectDataSource ID="matTypeDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsGeneralBTableAdapters.VIEW_PIP_FAB_SHOPTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_SHOP_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SHOP_ID" Type="Decimal" />
            <asp:Parameter Name="SHOP_NO" Type="String" />
            <asp:Parameter Name="SHOP_NAME" Type="String" />
            <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_SHOP_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
