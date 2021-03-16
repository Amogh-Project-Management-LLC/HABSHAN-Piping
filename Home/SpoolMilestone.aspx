<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolMilestone.aspx.cs" Inherits="SpoolMileStone" Title="Spool Milestone" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
 

    <div>
        <telerik:RadGrid ID="PipingSpecGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="spoolmilestoneSource" SkinID="GridViewSkin" 
            PageSize="13" Width="100%" >
            <MasterTableView>
                <Columns>                   
                    <%--    <asp:BoundField DataField="WELD_GROUP" HeaderText="Weld Group" SortExpression="WELD_GROUP" />--%>
                    <telerik:GridBoundColumn DataField="STATUS_ID" HeaderText="Status Id" SortExpression="STATUS_ID"/>
                    <telerik:GridBoundColumn DataField="STATUS_CODE" HeaderText="Status_code" SortExpression="STATUS_CODE" />
                    <%--   <asp:BoundField DataField="SIZE_THICK_DESC" HeaderText="Size" SortExpression="SIZE_THICK_DESC" />--%>
                    <telerik:GridBoundColumn DataField="STATUS" HeaderText="Status" SortExpression="STATUS"></telerik:GridBoundColumn>
                  <%--  <telerik:GridBoundColumn DataField="EXTDB_CODE" HeaderText="ExtDB Code" SortExpression="EXTDB_CODE" />--%>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="spoolmilestoneSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM PIP_SPOOL_MILESTONE ORDER BY STATUS_ID"></asp:SqlDataSource>
    
</asp:Content>
