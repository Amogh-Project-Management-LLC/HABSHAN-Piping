<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Consumable.aspx.cs" Inherits="Consumable_Consumable" Title="Consumable" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" />
                </td>
                <td style="text-align: right; width: 100%">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtFilter" runat="server" Width="150" OnTextChanged="txtFilter_TextChanged" EmptyMessage="Search Here" AutoPostBack="True"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="RadGrid1_DataSource"
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnUpdateCommand="RadGrid1_UpdateCommand">
                <ClientSettings EnablePostBackOnRowClick="True">
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="MAT_ID" DataSourceID="RadGrid1_DataSource" HierarchyLoadMode="Client" PageSize="15"
                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true">
                    <Columns>

                        <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                            <ItemStyle Width="50px" />
                        </telerik:GridEditCommandColumn>

                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn" ItemStyle-Width="20px">
                            <ItemStyle Width="20px" />
                        </telerik:GridButtonColumn>

                        <telerik:GridBoundColumn DataField="MAT_CODE" FilterControlAltText="Filter MAT_CODE column" HeaderText="Item Code/ Symbol" SortExpression="MAT_CODE" UniqueName="MAT_CODE">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="DESCRIPTION" FilterControlAltText="Filter DESCRIPTION column" HeaderText="Description" SortExpression="DESCRIPTION" UniqueName="DESCRIPTION">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="CATEGORY" FilterControlAltText="Filter CATEGORY column" HeaderText="Category" SortExpression="CATEGORY" UniqueName="CATEGORY">
                            <ItemTemplate>
                                <asp:Label ID="LabelCategory" runat="server" Text='<%# Bind("CATEGORY") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownListCategoryEdit" runat="server" DataSourceID="Category_SqlDataSource"
                                    DataTextField="CATEGORY" DataValueField="CAT_ID" SelectedValue='<%# Bind("CAT_ID") %>'
                                    Width="150px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                            <ItemTemplate>
                                <asp:Label ID="UOM_Label" runat="server" Text='<%# Bind("UOM") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="UOM_DropDownList" runat="server" DataSourceID="UOM_SqlDataSource" AppendDataBoundItems="true"
                                    DataTextField="UOM" DataValueField="UNIT_ID" SelectedValue='<%# Bind("UOM_ID") %>'
                                    Width="100px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                        </EditColumn>
                        <PopUpSettings Modal="True" />
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:ObjectDataSource ID="RadGrid1_DataSource" runat="server" SelectMethod="GetData"
        TypeName="dsConsumableTableAdapters.VIEW_CONSUMABLE_MASTERTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_CODE" Type="String" />
            <asp:Parameter Name="CAT_ID" Type="Decimal" />
            <asp:Parameter Name="DESCRIPTION" Type="String" />
            <asp:Parameter Name="UOM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_MAT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="Category_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT CAT_ID, CATEGORY FROM CONSUMABLE_CATEGORY ORDER BY CATEGORY'></asp:SqlDataSource>

    <asp:SqlDataSource ID="UOM_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT UNIT_ID, UOM FROM UOM_DESCR ORDER BY UOM'></asp:SqlDataSource>
</asp:Content>