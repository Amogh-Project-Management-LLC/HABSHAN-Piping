<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="JointsPaintNew.aspx.cs" Inherits="WeldingInspec_JointPaintNew" Title="Joints Painting" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 4px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">
                    <asp:Label ID="Label1" runat="server" Text="Joint Paint No"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtJntPaintNo" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PaintNoValidator" runat="server" ControlToValidate="txtJntPaintNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">
                    <asp:Label ID="Label2" runat="server" Text="Issue Date"></asp:Label>
                </td>
                <td>

                    <telerik:RadDatePicker ID="txtIssueDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtIssueDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">
                    <asp:Label ID="Label3" runat="server" Text="Issued by"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtIssuedby" runat="server" Width="122px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="IssuedbyValidator" runat="server" ControlToValidate="txtIssuedby"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">
                    <asp:Label ID="Label4" runat="server" Text="Subcon"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" Width="207px" AppendDataBoundItems="True"
                        DataSourceID="subconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" AutoPostBack="True">
                        <asp:ListItem Selected="True">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="SubconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: gainsboro;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="454px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>