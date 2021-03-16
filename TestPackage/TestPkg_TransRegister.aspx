<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_TransRegister.aspx.cs" Inherits="TestPkg_TransRegister" Title="Test Package Transmittal" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">       
        <tr>
            <td>
                <table class="TableStyle" style="width: 100%">
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">
                            <asp:Label ID="Label1" runat="server" Text="Transmittal No"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTransNo" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="TransNoFieldValidator" runat="server" ControlToValidate="txtTransNo"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">
                            <asp:Label ID="Label2" runat="server" Text="Issue Date"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTransDate" runat="server" Width="89px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="TransDateValidator" runat="server" ControlToValidate="txtTransDate"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke;">
                            <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="393px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke">
                <telerik:RadButton ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                    Width="78px" BackColor="SkyBlue" BorderColor="SteelBlue" />
            </td>
        </tr>
    </table>
</asp:Content>
