<%@ Page Language="C#" MasterPageFile="~/ReportViewerMasterPage.master" AutoEventWireup="true"
    CodeFile="ReportViewer.aspx.cs" Inherits="WeldingInspec_ReportViewer" Title="Preview Report" %>

<%@ MasterType VirtualPath="~/ReportViewerMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="450px" Width="100%">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>
</asp:Content>