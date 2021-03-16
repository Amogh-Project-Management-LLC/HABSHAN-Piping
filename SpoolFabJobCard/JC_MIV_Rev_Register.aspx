<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JC_MIV_Rev_Register.aspx.cs" 
    MasterPageFile="~/PopupMasterPage.master"  Inherits="SpoolFabJobCard_JC_MIV_Rev_Register" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
               
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>          
          <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Revision
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMIVRev" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>      
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">MIVR Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMIVR" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
