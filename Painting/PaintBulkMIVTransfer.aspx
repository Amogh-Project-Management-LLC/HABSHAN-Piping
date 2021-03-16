<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PaintBulkMIVTransfer.aspx.cs" Inherits="Painting_PaintBulkMIVTransfer" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <telerik:RadGrid ID="itemsGrid" runat="server"></telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlItemsSource" runat="server"></asp:SqlDataSource>
</asp:Content>

