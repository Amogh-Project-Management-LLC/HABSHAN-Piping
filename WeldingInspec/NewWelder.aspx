<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="NewWelder.aspx.cs" Inherits="WeldingInspec_NewWelder" Title="New Welder" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td style="width: 150px; background-color: gainsboro;">Welder Name
            </td>
            <td>
                <telerik:RadTextBox ID="txtName" runat="server" Width="150px"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="NameFieldValidator" runat="server" ControlToValidate="txtName"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr style="color: #000000">
            <td style="width: 150px; background-color: gainsboro;">Welder Code
            </td>
            <td>
                <telerik:RadTextBox ID="txtCode" runat="server" Width="150px"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="CodeFieldValidator" runat="server" ControlToValidate="txtCode"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr style="color: #000000">
            <td style="width: 150px; background-color: gainsboro;">Sub Contractor
            </td>
            <td>
                <telerik:RadDropDownList ID="cboSubcon" runat="server" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME"
                    DataValueField="SUB_CON_ID" Width="180px">
                </telerik:RadDropDownList>
                <asp:RequiredFieldValidator ID="SubconRequiredFieldValidator" runat="server" ControlToValidate="cboSubcon"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 150px; background-color: gainsboro;">Join Date
            </td>
            <td>
                <telerik:RadDatePicker ID="txtJoinDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="JoinDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtJoinDate" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <div style="background-color: whitesmoke; padding: 5px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
