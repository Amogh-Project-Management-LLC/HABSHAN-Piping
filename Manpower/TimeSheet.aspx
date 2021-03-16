<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TimeSheet.aspx.cs" Inherits="Manpower_TimeSheet" Title="Timesheet" %>

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
                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataKeyNames="LOG_ID" DataSourceID="RadGrid1_DataSource" HierarchyLoadMode="Client" PageSize="15"
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

                        <telerik:GridBoundColumn DataField="EMPLOYEE_CODE" FilterControlAltText="Filter EMPLOYEE_CODE column" HeaderText="Employee Code" SortExpression="EMPLOYEE_CODE" UniqueName="EMPLOYEE_CODE" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="EMPLOYEE_NAME" FilterControlAltText="Filter EMPLOYEE_NAME column" HeaderText="Employee Name" SortExpression="EMPLOYEE_NAME" UniqueName="EMPLOYEE_NAME" ReadOnly="true">
                        </telerik:GridBoundColumn>

                        <telerik:GridDateTimeColumn DataField="IN_TIME" DataType="System.DateTime" FilterControlAltText="Filter IN_TIME column"
                            HeaderText="In Time" SortExpression="IN_TIME" UniqueName="IN_TIME"
                            DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" EditDataFormatString="dd-MMM-yyyy hh:mm tt">
                        </telerik:GridDateTimeColumn>

                        <telerik:GridDateTimeColumn DataField="OUT_TIME" DataType="System.DateTime" FilterControlAltText="Filter OUT_TIME column"
                            HeaderText="Out Time" SortExpression="OUT_TIME" UniqueName="OUT_TIME"
                            DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" EditDataFormatString="dd-MMM-yyyy hh:mm tt">
                        </telerik:GridDateTimeColumn>
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
        TypeName="dsManpowerTableAdapters.VIEW_MANPOWER_TIME_SHEETTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtFilter" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="IN_TIME" Type="DateTime" />
            <asp:Parameter Name="OUT_TIME" Type="DateTime" />
            <asp:Parameter Name="Original_LOG_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LOG_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    </asp:Content>