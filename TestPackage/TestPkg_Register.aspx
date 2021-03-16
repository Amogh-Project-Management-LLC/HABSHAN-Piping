<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_Register.aspx.cs" Inherits="TestPkg_Register" Title="Test Package" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">       
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            System No
                        </td>
                        <td>
                            <asp:DropDownList ID="cboSysNo" runat="server" DataSourceID="sysDataSource" DataTextField="SYS_NO"
                                DataValueField="SYS_ID" Width="281px" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="sysValidator" runat="server" ControlToValidate="cboSysNo"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            Test Package No
                        </td>
                        <td>
                            <asp:TextBox ID="txtTP_No" runat="server" Width="196px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="tpValidator" runat="server" ControlToValidate="txtTP_No"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            Test Pressure
                        </td>
                        <td>
                            <asp:TextBox ID="txtTestPress" runat="server" Width="70px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            Test Medium
                        </td>
                        <td>
                            <asp:TextBox ID="txtMedium" runat="server" Width="70px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            Line Service
                        </td>
                        <td>
                            <asp:TextBox ID="txtService" runat="server" Width="70px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            Remarks
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="250px"></asp:TextBox>
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
    <asp:SqlDataSource ID="sysDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SYS_ID, SYS_NUMBER || '/ ' || SUB_SYS_NO AS SYS_NO FROM TPK_SYSTEM_DEFINITION WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SYS_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
