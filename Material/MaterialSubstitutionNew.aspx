<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialSubstitutionNew.aspx.cs" Inherits="Material_MaterialSubstitutionNew" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            background-color:whitesmoke;
            width:120px;
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
        <table>
            <tr>
                <td class="Heading">
                    Request Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReqNo" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Request Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtReqDate" runat="server" Width="200px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Create By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCreateBy" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" Width="80px"></telerik:RadButton>

                </td>
            </tr>
        </table>
    
    </div>
        </ContentTemplate>
    </asp:UpdatePanel>
       
</asp:Content>

