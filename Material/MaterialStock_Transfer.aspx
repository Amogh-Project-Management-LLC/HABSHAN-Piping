<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_Transfer.aspx.cs" Inherits="Material_MaterialStock_Transfer" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="80px" OnClick="btnExport_Click"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource1" GridLines="None">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <telerik:GridBoundColumn DataField="TRANSF_NO" FilterControlAltText="Filter TRANSF_NO column" HeaderText="TRANSF_NO" SortExpression="TRANSF_NO" UniqueName="TRANSF_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE_DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATE_BY" SortExpression="CREATE_BY" UniqueName="CREATE_BY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FROM_STORE" FilterControlAltText="Filter FROM_STORE column" HeaderText="FROM_STORE" SortExpression="FROM_STORE" UniqueName="FROM_STORE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TO_STORE" FilterControlAltText="Filter TO_STORE column" HeaderText="TO_STORE" SortExpression="TO_STORE" UniqueName="TO_STORE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANSF_QTY" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_QTY column" HeaderText="TRANSF_QTY" SortExpression="TRANSF_QTY" UniqueName="TRANSF_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TOTAL_WEIGHT" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_WEIGHT column" HeaderText="TOTAL_WEIGHT" SortExpression="TOTAL_WEIGHT" UniqueName="TOTAL_WEIGHT">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECEIVE_DATE" DataType="System.DateTime" FilterControlAltText="Filter RECEIVE_DATE column" HeaderText="RECEIVE_DATE" SortExpression="RECEIVE_DATE" UniqueName="RECEIVE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOB_CODE, TRANSF_NO, CREATE_DATE, CREATE_BY, A_STORE AS FROM_STORE, B_STORE AS TO_STORE, MAT_CODE1, MAT_CODE2, 
       SIZE_DESC, WALL_THK, MAT_DESCR, ITEM_NAM, HEAT_NO,
       PAINT_CODE, BOX_NO, TRANSF_QTY, NO_OF_PIECE, PIPE_LENGTH,
       TRANSF_QTY_NEW, TOTAL_WEIGHT, RECEIVE_DATE, REMARKS 
        FROM VIEW_MAT_TRANSF_REP
        WHERE MAT_ID = :MAT_ID
        Order by TRANSF_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

