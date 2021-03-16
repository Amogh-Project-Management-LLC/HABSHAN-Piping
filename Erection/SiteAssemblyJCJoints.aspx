<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SiteAssemblyJCJoints.aspx.cs" Inherits="Erection_MatIssueLooseJoints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <table runat="server" id="EntryTable" visible="false">
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="txtIsomeSearch" runat="server" Width="200px" EmptyMessage="Search Isometric.." AutoPostBack="true"></telerik:RadTextBox>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlJointList" runat="server" Width="300px" DataSourceID="sqlJointSource" DataTextField="JOINT_TITLE" 
                                    DataValueField="JOINT_ID" Filter="Contains" EmptyMessage="(Select Joint)"
                                    EnableCheckAllItemsCheckBox="true" CheckBoxes="true"></telerik:RadComboBox>
                            </td>
                            <td>
                                <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:2px">
        <telerik:RadGrid ID="itemsGridView" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" AllowPaging="true"
             PageSize="15">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="JC_ID, JOINT_ID" AllowAutomaticDeletes="true"
                 AllowFilteringByColumn="true">
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" ConfirmText="Are you sure you want to delete ?" ConfirmDialogType="RadWindow"></telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" AllowFiltering="true" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO_TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                    </telerik:GridBoundColumn>
                  
                    <telerik:GridBoundColumn DataField="JOINT_NO" AllowFiltering="false" FilterControlAltText="Filter JOINT_NO column" HeaderText="JOINT NO" SortExpression="JOINT_NO" UniqueName="JOINT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JOINT_TYPE" AllowFiltering="false" FilterControlAltText="Filter JOINT_TYPE column" HeaderText="JOINT TYPE" SortExpression="JOINT_TYPE" UniqueName="JOINT_TYPE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JOINT_SIZE" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter JOINT_SIZE_DEC column" HeaderText="JOINT SIZE" SortExpression="JOINT_SIZE" UniqueName="JOINT_SIZE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionTableAdapters.VIEW_MAT_ISSUE_ASSEMBLY_JOINTTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlJointSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, ISO_TITLE1||'_'||JOINT_NO AS JOINT_TITLE 
FROM VIEW_ADAPTER_SITE_JNTS
WHERE ISO_TITLE1 = :ISO_TITLE1 AND JOINT_ID NOT IN (SELECT JOINT_ID FROM PIP_MAT_ISSUE_ASSEMBLY_JOINT)
ORDER BY JOINT_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsomeSearch" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

