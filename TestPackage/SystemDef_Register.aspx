<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SystemDef_Register.aspx.cs" Inherits="SystemDef_Register" Title="System Definition" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">      
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                    <tr>
                        <td style="width: 150px; background-color: whitesmoke">
                            <asp:Label ID="Label1" runat="server" Text="System No"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtSys" runat="server"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="sysValidator" runat="server" ControlToValidate="txtSys"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px; background-color: whitesmoke">
                            <asp:Label ID="Label2" runat="server" Text="Sub System No"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtSubSys" runat="server"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="subSysValidator" runat="server" ControlToValidate="txtSubSys"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px; background-color: whitesmoke">
                            <asp:Label ID="Label3" runat="server" Text="System Description"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtDesc" runat="server" Width="250px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="descValidator" runat="server" ControlToValidate="txtDesc"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                     <tr>
                        <td style="width: 150px; background-color: whitesmoke">
                            <asp:Label ID="Label5" runat="server" Text="Sub System Description"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtSubSysDesc" runat="server" Width="250px"></telerik:RadTextBox>                           
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px; background-color: whitesmoke">
                            <asp:Label ID="Label4" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRem" runat="server" Width="250px"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke">
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Submit" Width="74px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
