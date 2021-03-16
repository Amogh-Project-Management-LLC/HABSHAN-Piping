<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MRItemAdd.aspx.cs" Inherits="Material_MRItemAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            background-color: whitesmoke;
            width:120px;
            padding-left:5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">MR Item No</td>
                <td>
                    <telerik:RadTextBox runat="server" id="txtMRItem" Width="100px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Item Code</td>
                <td>
                    <telerik:RadTextBox runat="server" id="txtTagNo" Width="150px" EmptyMessage="Tag No"></telerik:RadTextBox>
                    <telerik:RadTextBox runat="server" id="txtClientPartNo" Width="150px" EmptyMessage="Client Part No"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Item Description</td>
                <td>
                    <telerik:RadTextBox runat="server" id="txtMatDescr" Width="303px" EmptyMessage="Material Description" TextMode="MultiLine"></telerik:RadTextBox>                   
                </td>
            </tr>
            <tr>
                <td class="Heading">Quantity</td>
                <td>
                    <telerik:RadTextBox runat="server" id="txtMRQty" Width="150px" EmptyMessage="Current MR Qty"></telerik:RadTextBox>
                    <telerik:RadTextBox runat="server" id="txtPrevQty" Width="150px" EmptyMessage="Previous Qty"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Delivery Point</td>
                <td>
                    <telerik:RadTextBox runat="server" id="txtDelPoint" Width="303px" EmptyMessage="Delivery Point"></telerik:RadTextBox>                   
                </td>
            </tr>
              <tr>
                <td class="Heading">Construction Area</td>
                <td>
                    <telerik:RadTextBox runat="server" id="txtConstArea" Width="303px" EmptyMessage="Construction Area"></telerik:RadTextBox>                   
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>                   
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

