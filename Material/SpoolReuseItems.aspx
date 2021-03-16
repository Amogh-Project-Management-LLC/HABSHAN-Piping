<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolReuseItems.aspx.cs" Inherits="Material_SpoolReuseItems" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="background-color: whitesmoke">
                <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnAddSpool" runat="server" Text="Add Spool" Width="120px" OnClick="btnAddSpool_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" Visible="false"></telerik:RadButton>

            </div>
            <div>
                <table runat="server" id="EntryTable" visible="false">
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Isometric</td>
                        <td>
                            <telerik:RadSearchBox ID="txtSeachIsome" runat="server" Width="200px" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_ID"
                                EmptyMessage="Search Isometric..." Filter="StartsWith" OnSearch="txtSeachIsome_Search">
                            </telerik:RadSearchBox>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlSpoolList" runat="server" DataSourceID="sqlSpoolSource" DataTextField="SPOOL" DataValueField="SPL_ID" CheckBoxes="True"
                                EnableCheckAllItemsCheckBox="true">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Remarks:</td>
                        <td colspan="2">
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="250px"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
                    AllowPaging="true" PageSize="15">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowAutomaticDeletes="true" DataKeyNames="SPL_ID">
                        <Columns>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmTextFormatString="Are you sure you want to delete {0} / {1}?"
                                ConfirmTextFields="ISO_TITLE1, SPOOL" ConfirmDialogType="RadWindow">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO_TITLE1" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WO_NAME" FilterControlAltText="Filter WO_NAME column" HeaderText="WO_NAME" SortExpression="WO_NAME" UniqueName="WO_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="ISSUE_DATE" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DEL_DATE" DataType="System.DateTime" FilterControlAltText="Filter DEL_DATE column" HeaderText="DEL_DATE" 
                                SortExpression="DEL_DATE" UniqueName="DEL_DATE" DataFormatString="{0:dd-MMM-yyyy}">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
            <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_MAT_REUSE_SPLTableAdapter">
                <DeleteParameters>
                    <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="MRN_ID" QueryStringField="REQ_ID" Type="Decimal" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PIP_ISOMETRIC.ISO_ID, ISO_TITLE1
FROM PIP_ISOMETRIC, PIP_SPOOL
WHERE PIP_ISOMETRIC.ISO_ID =PIP_SPOOL.ISO_ID
AND PIP_SPOOL.DEL_DATE IS NOT NULL"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSpoolSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPOOL 
FROM PIP_SPOOL
WHERE DEL_DATE IS NOT NULL AND ISO_ID = :ISO_ID
AND SPL_ID NOT IN (SELECT SPL_ID FROM PIP_MAT_REUSE_SPL) AND SPOOL LIKE 'SPL%' 
ORDER BY SPOOL">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenISOID" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenISOID" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

