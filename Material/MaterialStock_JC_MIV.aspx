<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_JC_MIV.aspx.cs" Inherits="Material_MaterialStock_JC_MIV" Title="Material-JC-MIV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
            OnClick="btnBack_Click">
        </telerik:RadButton>

          <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px"
            OnClick="btnDWN_Click">
        </telerik:RadButton>

    </div>
    <div style="margin-top: 5px;">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="JCMIVDataSource"
            AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="JCMIVDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="ISSUE_NO" AllowFiltering="true" FilterControlAltText="Filter ISSUE_NO column" HeaderText="Issue No" SortExpression="ISSUE_NO" UniqueName="ISSUE_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_DATE" AllowFiltering="false" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="Issue Date" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WO_NAME" AllowFiltering="false" FilterControlAltText="Filter WO_NAME column" HeaderText="Job Card No" SortExpression="WO_NAME" UniqueName="WO_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" AllowFiltering="false" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="Sub Con Name" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUED_QTY" AllowFiltering="false" FilterControlAltText="Filter ISSUED_QTY column" HeaderText="Issued QTY" SortExpression="ISSUED_QTY" UniqueName="ISSUED_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" AllowFiltering="false" FilterControlAltText="Filter HEAT_NO column" HeaderText="Heat No" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" AllowFiltering="false" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                                    
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="JCMIVDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT *FROM VIEW_JC_MIV_SUMMARY WHERE (MAT_ID = :MAT_ID) AND (PROJECT_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

