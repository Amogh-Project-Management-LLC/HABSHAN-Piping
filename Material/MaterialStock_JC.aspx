<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_JC.aspx.cs" Inherits="Material_MaterialStock_JC" Title="Material - Jobcard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px" OnClick="btnDWN_Click"> </telerik:RadButton>
    </div>

    <div>
        <telerik:RadGrid ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="WO_NAME" DataSourceID="jcDataSource" SkinID="GridViewSkin" PageSize="20" Width="100%">
            <MasterTableView DataSourceID="jcDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="WO_NAME" HeaderText="Job Card" SortExpression="WO_NAME">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Issued On" HtmlEncode="False" SortExpression="ISSUE_DATE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REVISION" HeaderText="Revision" SortExpression="REVISION">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="jcDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT WO_NAME, ISSUE_DATE, REVISION, SUB_CON_NAME FROM VIEW_JC_MAT_SUMMARY WHERE (MAT_ID = :MAT_ID) AND (PROJ_ID = :PROJECT_ID) ORDER BY WO_NAME">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
