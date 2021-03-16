<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingJCDetailAdd.aspx.cs" Inherits="SpoolMove_SpoolCoatingJCDetailAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <table>
        <tr>
            <td class="Heading">Spool 
            </td>
            <td>
                <telerik:RadTextBox ID="txtSearch" runat="server" Width="150px" AutoPostBack="true"></telerik:RadTextBox>
            </td>
            <td>
                <telerik:RadDropDownList ID="ddlSpoolList" runat="server" Width="250px" DataSourceID="sqlSpoolSource" DataTextField="SPL_TITLE" DataValueField="SPL_ID" DropDownHeight="100px"></telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Heading">Coating Rep No. 
            </td>
            <td colspan="2">
                <telerik:RadTextBox ID="txtCoatRepNo" runat="server" Width="250px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Coating Date</td>
            <td>
                <telerik:RadDatePicker ID="txtCoatingDate" runat="server" Width="150px" DateInput-DisplayDateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Blast Rep No. 
            </td>
            <td colspan="2">
                <telerik:RadTextBox ID="txtIntBlastRepNo" runat="server" Width="250px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Internal Blast Date</td>
            <td>
                <telerik:RadDatePicker ID="txtIntBlastDate" runat="server" Width="150px" DateInput-DisplayDateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Remarks 
            </td>
            <td colspan="2">
                <telerik:RadTextBox ID="txtRemarks" runat="server" Width="250px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <telerik:RadButton ID="btnAdd" runat="server" Text="Add" Width="80px" OnClick="btnAdd_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sqlSpoolSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VIEW_SPOOL_TITLE.SPL_ID, VIEW_SPOOL_TITLE.SPL_TITLE FROM VIEW_SPOOL_TITLE, PIP_SPOOL WHERE VIEW_SPOOL_TITLE.SPL_ID = PIP_SPOOL.SPL_ID AND (PIP_SPOOL.NDE_CMPLT IS NOT NULL) AND (VIEW_SPOOL_TITLE.SPL_TITLE LIKE FNC_FILTER(:SEARCH)) AND (VIEW_SPOOL_TITLE.SPOOL LIKE 'SPL%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="SEARCH" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

