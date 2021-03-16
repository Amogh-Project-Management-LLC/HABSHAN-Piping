<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolTransRegister.aspx.cs" Inherits="SpoolMove_SpoolTransRegister"
    Title="Register Spool Transmittal" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
    <div>
        <table>
            <tr>
                <td style="width: 140px;">Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        Width="200px" AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="Select SubCon" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="SubconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Transmittal No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransNo" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="TransNoFieldValidator" runat="server" ControlToValidate="txtTransNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Ship No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipNo" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Area</td>
                <td>
                    <telerik:RadTextBox ID="txtArea" runat="server" Width="100px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Issue Date </td>
                <td>
                    <telerik:RadDatePicker ID="txtTransDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ValidationGroup="submit" ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtTransDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Issued By</td>
                <td>
                    <telerik:RadTextBox ID="txtUserName" runat="server" Width="100px" ReadOnly="true"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" ValidationGroup="submit"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>