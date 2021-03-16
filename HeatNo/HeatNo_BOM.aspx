<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_BOM.aspx.cs" Inherits="HeatNo_HeatNo_BOM" Title="Heat No - BOM" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="bomGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="bomDataSource" Width="100%" AllowPaging="True" PageSize="18" OnDataBound="bomGridView_DataBound">
            <MasterTableView>
                <Columns>                    
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool No" SortExpression="SPOOL" />
                    <telerik:GridBoundColumn DataField="PT_NO" HeaderText="Part No" SortExpression="PT_NO" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" />
                    <telerik:GridBoundColumn DataField="SF_FLG" HeaderText="SF_FLG" SortExpression="SF_FLG" />
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat No" SortExpression="HEAT_NO" />
                    <telerik:GridBoundColumn DataField="AVAILABLE" HeaderText="Available" SortExpression="AVAILABLE" />
                    <telerik:GridBoundColumn DataField="NET_QTY" HeaderText="Net Qty" SortExpression="NET_QTY"
                        DataFormatString="{0:f}" HtmlEncode="False" />
                    <telerik:GridBoundColumn DataField="PIPE_EP1" HeaderText="Pipe EP1" SortExpression="PIPE_EP1" />
                    <telerik:GridBoundColumn DataField="PIPE_EP2" HeaderText="Pipe EP2" SortExpression="PIPE_EP2" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_BOM_TOTAL WHERE PROJ_ID = :PROJECT_ID AND HEAT_NO = :HEAT_NO ORDER BY ISO_TITLE1, PT_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
