<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SelectSubcon.aspx.cs" Inherits="BasicReports_SelectSubconArea"
    Title="Select Subcontractor" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 5px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: Gainsboro; vertical-align: top">Subcon
                </td>
                <td>
                   <telerik:RadDropDownList DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_NAME" runat="server" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlSubCon_SelectedIndexChanged" AutoPostBack="true" ID="ddlSubCon" >
                       <Items>
                           <telerik:DropDownListItem Text="Select Subcon" Value="XX" />
                           <telerik:DropDownListItem Text="All" Value="ALL" />
                       </Items>
                   </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

 <div>
        <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="450px" Width="100%">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT SUB_CON_NAME FROM VIEW_UNIQUE_SUB_CON WHERE (PROJ_ID = :PROJECT_ID) AND (FAB_SC='Y') ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>