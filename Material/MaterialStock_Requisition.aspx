<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_Requisition.aspx.cs" Inherits="Material_MaterialStock_Requistion" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
             OnClick="btnBack_Click"></telerik:RadButton>
        
  <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px"
            OnClick="btnDWN_Click">
        </telerik:RadButton>
    </div>
    <div style="margin-top:5px;">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="MatRequisitonDS"
         AllowFilteringByColumn="true">
<GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
        <MasterTableView AutoGenerateColumns="False" DataSourceID="MatRequisitonDS">
            <Columns>
                <telerik:GridBoundColumn DataField="MR_NO" AllowFiltering="true" FilterControlAltText="Filter MR_NO column" HeaderText="MR_NO" SortExpression="MR_NO" UniqueName="MR_NO">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MR_REV" AllowFiltering="false" FilterControlAltText="Filter MR_REV column" HeaderText="MR_REV" SortExpression="MR_REV" UniqueName="MR_REV">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="MR_TITLE" AllowFiltering="false" FilterControlAltText="Filter MR_TITLE column" HeaderText="MR_TITLE" SortExpression="MR_TITLE" UniqueName="MR_TITLE">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DISCIPLINE_CODE" AllowFiltering="false" FilterControlAltText="Filter DISCIPLINE_CODE column" HeaderText="DISCIPLINE_CODE" SortExpression="DISCIPLINE_CODE" UniqueName="DISCIPLINE_CODE">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="STATUS" AllowFiltering="false" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TAG_NO" AllowFiltering="false"  FilterControlAltText="Filter TAG_NO column" HeaderText="TAG_NO" SortExpression="TAG_NO" UniqueName="TAG_NO">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ITEM_DESCR" AllowFiltering="false" FilterControlAltText="Filter ITEM_DESCR column" HeaderText="ITEM_DESCR" SortExpression="ITEM_DESCR" UniqueName="ITEM_DESCR">
                </telerik:GridBoundColumn>              
                <telerik:GridBoundColumn DataField="MR_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MR_QTY column" HeaderText="MR_QTY" SortExpression="MR_QTY" UniqueName="MR_QTY">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PREV_QTY" AllowFiltering="false" FilterControlAltText="Filter PREV_QTY column" HeaderText="PREV_QTY" SortExpression="PREV_QTY" UniqueName="PREV_QTY">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DELTA_QTY" AllowFiltering="false" FilterControlAltText="Filter DELTA_QTY column" HeaderText="DELTA_QTY" SortExpression="DELTA_QTY" UniqueName="DELTA_QTY">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DELIVERY_POINT" AllowFiltering="false" FilterControlAltText="Filter DELIVERY_POINT column" HeaderText="DELIVERY_POINT" SortExpression="DELIVERY_POINT" UniqueName="DELIVERY_POINT">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CONSTRUCTION_AREA" AllowFiltering="false" FilterControlAltText="Filter CONSTRUCTION_AREA column" HeaderText="CONSTRUCTION_AREA" SortExpression="CONSTRUCTION_AREA" UniqueName="CONSTRUCTION_AREA">
                </telerik:GridBoundColumn>
           
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="MatRequisitonDS" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT *FROM VIEW_MAT_REQUISITION WHERE CLIENT_PART_NO = :CLIENT_PART_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" DefaultValue="XXX" Name="CLIENT_PART_NO" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>

