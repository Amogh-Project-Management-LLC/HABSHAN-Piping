<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MRAdd.aspx.cs" Inherits="Material_MRAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
        .Heading {
            background-color:whitesmoke;
            width:120px;
            padding-left:5px
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">MR Number</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtMRNo" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">MR Revision</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtRevision" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">MR Title</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtMRTitle" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Discipline Code</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtDisCode" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">MR Status</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtStatus" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtRemarks" Width="250px" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton runat="server" ID="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

