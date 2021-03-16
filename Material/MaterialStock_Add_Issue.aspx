<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_Add_Issue.aspx.cs" Inherits="Material_MaterialStock_Add_Issue" %>

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
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="MatAddDataSource"
            AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="MatAddDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" AllowFiltering="false" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="Isometric" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" AllowFiltering="false" FilterControlAltText="Filter SPOOL column" HeaderText="Spool" SortExpression="SPOOL" UniqueName="SPOOL">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PT_NO" AllowFiltering="false" FilterControlAltText="Filter PT_NO column" HeaderText="Part No" SortExpression="PT_NO" UniqueName="PT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_NO" AllowFiltering="true" FilterControlAltText="Filter ISSUE_NO column" HeaderText="Add Issue No" SortExpression="ISSUE_NO" UniqueName="ISSUE_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_DATE" AllowFiltering="false" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="Add Issue Date" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" AllowFiltering="false" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="Sub Con" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" AllowFiltering="false" FilterControlAltText="Filter QTY column" HeaderText="Add Issued Qty" SortExpression="QTY" UniqueName="QTY">
                    </telerik:GridBoundColumn>               
                    <telerik:GridBoundColumn DataField="REMARKS" AllowFiltering="false"  FilterControlAltText="Filter REMARKS column" HeaderText="Remarks" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>                 
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="MatAddDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT *FROM VIEW_ADD_ISSUE_BOM_REP  WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

