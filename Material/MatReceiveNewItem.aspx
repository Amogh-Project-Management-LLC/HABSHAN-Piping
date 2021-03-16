<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceiveNewItem.aspx.cs" Inherits="Material_MatReceiveNewItem" Title="MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 150px; background-color: whitesmoke">
                    <asp:Label ID="Label8" runat="server" Text="MR Item Number"></asp:Label>
                </td>
                <td style="height: 20px">
                    <asp:TextBox ID="txtMrItem" runat="server" Width="45px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="mrItemValidator" runat="server" ControlToValidate="txtMrItem"
                        ErrorMessage="*" Width="12px" ForeColor="Red" Text="1"></asp:RequiredFieldValidator>
                </td>
            </tr>            
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label3" runat="server" Text="PO Item Number"></asp:Label>
                </td>
                <td style="height: 20px">
                    <asp:TextBox ID="txtPoItem" runat="server" Width="45px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="itemNoValidator" runat="server" ControlToValidate="txtPoItem"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="SRN Number"></asp:Label>
                </td>
                <td style="height: 20px">
                    <asp:TextBox ID="txtSRNNo" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSRNNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode" runat="server" AutoPostBack="True" OnTextChanged="txtMatCode_TextChanged"
                        Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
           <%-- <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Heat No"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtHeatNo" runat="server" Width="115px" AutoPostBack="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>--%>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label6" runat="server" Text="Received Qty"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="63px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label4" runat="server" Text="Unit Weight"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtUnitWeight" runat="server" Width="63px"></asp:TextBox>                    
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="matIdField" runat="server" />
</asp:Content>