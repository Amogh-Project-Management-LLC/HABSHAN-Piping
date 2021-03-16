<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Manpower.aspx.cs" Inherits="Manpower_Manpower" Title="Manpower" %>

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
                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="MP_ID" DataSourceID="RadGrid1_DataSource" HierarchyLoadMode="Client" PageSize="15"
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

                        <telerik:GridBoundColumn DataField="EMPLOYEE_CODE" FilterControlAltText="Filter EMPLOYEE_CODE column" HeaderText="Employee Code" SortExpression="EMPLOYEE_CODE" UniqueName="EMPLOYEE_CODE">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="EMPLOYEE_NAME" FilterControlAltText="Filter EMPLOYEE_NAME column" HeaderText="Employee Name" SortExpression="EMPLOYEE_NAME" UniqueName="EMPLOYEE_NAME">
                        </telerik:GridBoundColumn>

                        <telerik:GridTemplateColumn DataField="CATEGORY_NAME" FilterControlAltText="Filter CATEGORY_NAME column" HeaderText="Category" SortExpression="CATEGORY_NAME" UniqueName="CATEGORY_NAME">
                            <ItemTemplate>
                                <asp:Label ID="LabelCategory" runat="server" Text='<%# Bind("CATEGORY_NAME") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownListCategoryEdit" runat="server" DataSourceID="Category_SqlDataSource"
                                    DataTextField="CATEGORY_NAME" DataValueField="CAT_ID" SelectedValue='<%# Bind("CAT_ID") %>'
                                    Width="150px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="Subcon" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                            <ItemTemplate>
                                <asp:Label ID="LabelSubconEdit" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownListSubconEdit" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SUB_CON_ID") %>'
                                    Width="150px">
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
        TypeName="dsManpowerTableAdapters.VIEW_MANPOWER_MASTERTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="EMPLOYEE_CODE" Type="String" />
            <asp:Parameter Name="EMPLOYEE_NAME" Type="String" />
            <asp:Parameter Name="CAT_ID" Type="Decimal" />
            <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MP_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_MP_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="Category_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT CAT_ID, CATEGORY_NAME FROM MANPOWER_CATEGORY ORDER BY CATEGORY_NAME'></asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>