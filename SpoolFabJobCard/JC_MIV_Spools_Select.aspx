<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JC_MIV_Spools_Select.aspx.cs"
    MasterPageFile="~/MasterPage.master" Inherits="SpoolFabJobCard_JC_MIV_Spools_Select" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
               
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add Spools" Width="90" OnClick="btnAdd_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="JCMIVSpoolGrid" AutoGenerateColumns="true" DataSourceID="JCMIVSpoolDataSource" runat="server" AllowPaging="true"  Height="600px"
            AllowMultiRowSelection="true" AllowFilteringByColumn="true" MasterTableView-EditFormSettings-EditColumn-AutoPostBackOnFilter="true"  PagerStyle-AlwaysVisible="true">
            <ClientSettings>
                <Scrolling AllowScroll="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="SPL_ID">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn">
                    </telerik:GridClientSelectColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="JCMIVSpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_TITLE1, SPOOL,SPL_ID,MAT_TYPE,SPL_SIZE FROM VIEW_JC_MIV_SPOOL_SRC WHERE PROJ_ID = :PROJECT_ID AND WO_ID=:WO_ID AND ISSUE_NO IS NULL ORDER BY ISO_TITLE1,SPOOL">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
