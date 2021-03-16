<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="ReportLauncher.aspx.cs" Inherits="Isome_IsomeIndex" Title="Isometric Index" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 3px; background-color: gainsboro;">
        <telerik:RadButton runat="server" ID="btnBack" OnClick="btnBack_Click" Text="Back"></telerik:RadButton>
        <telerik:RadDropDownList ID="ddMainMat" runat="server" AppendDataBoundItems="true" DataSourceID="materialDataSource" 
            DataTextField="MAT_TYPE" DataValueField="MAT_TYPE">
            <Items>
                <telerik:DropDownListItem Text="All Material" Value="ALL"/>
            </Items>
        </telerik:RadDropDownList>
        <telerik:RadButton runat="server" ID="btnPreview" OnClick="btnPreview_Click" Text="Preview"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="materialDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT DISTINCT nvl(main_mat,'NA') AS MAT_TYPE FROM pip_isometric">
    </asp:SqlDataSource>
</asp:Content>
