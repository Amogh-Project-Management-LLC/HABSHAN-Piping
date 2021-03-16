<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Users.aspx.cs" Inherits="Admin_Users" Title="Users" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:ImageButton ID="ImageButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" />
                </td>
                <td>
                    <telerik:RadButton ID="btnRoles" runat="server" Text="Roles" Width="80"></telerik:RadButton>
                </td>
                <td style="text-align: right; width: 100%">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtFilter" runat="server" Width="150" EmptyMessage="Search User" AutoPostBack="True"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="itemsDataSource"
                    OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged" OnUpdateCommand="RadGrid1_UpdateCommand">
                    <ClientSettings EnablePostBackOnRowClick="True">
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="USER_ID" DataSourceID="itemsDataSource"
                        EditMode="InPlace" HierarchyLoadMode="Client" PageSize="20">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" ItemStyle-Width="20px">
                            </telerik:GridButtonColumn>

                            <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="User Name" SortExpression="USER_NAME" UniqueName="USER_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EMP_CODE" FilterControlAltText="Filter EMP_CODE column" HeaderText="Employee Code" SortExpression="EMP_CODE" UniqueName="EMP_CODE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DISABLED" FilterControlAltText="Filter DISABLED column" HeaderText="Disabled" SortExpression="DISABLED" UniqueName="DISABLED">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EMAIL" FilterControlAltText="Filter EMAIL column" HeaderText="Email" SortExpression="EMAIL" UniqueName="EMAIL">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QUESTION" FilterControlAltText="Filter QUESTION column" HeaderText="Security Question" SortExpression="QUESTION" UniqueName="QUESTION" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ANSWER" FilterControlAltText="Filter ANSWER column" HeaderText="Security Answer" SortExpression="ANSWER" UniqueName="ANSWER" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="IS_ADMIN" FilterControlAltText="Filter IS_ADMIN column" HeaderText="Is Admin" SortExpression="IS_ADMIN" UniqueName="IS_ADMIN">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HIDE_ID" FilterControlAltText="Filter HIDE_ID column" HeaderText="Master Module Hide" SortExpression="HIDE_ID" UniqueName="HIDE_ID">
                            </telerik:GridBoundColumn>
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
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsUsersTableAdapters.VIEW_USERSTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" OnSelecting="itemsDataSource_Selecting" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_USER_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFilter" DefaultValue="%" Name="USER_NAME" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="USER_NAME" Type="String" />
            <asp:Parameter Name="EMP_CODE" Type="String" />
            <asp:Parameter Name="DISABLED" Type="String" />
            <asp:Parameter Name="EMAIL" Type="String" />
            <asp:Parameter Name="IS_ADMIN" Type="String" />
             <asp:Parameter Name="HIDE_ID" Type="String" />
            <asp:Parameter Name="Original_USER_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>