<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="HydroTestNew.aspx.cs" Inherits="HydroTest_HydroTestNew" Title="Hydro Test" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Test No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTestNo" runat="server" Width="220px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="PaintNoValidator" runat="server" ControlToValidate="txtTestNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Issue Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtIssueDate" runat="server" Width="150px" DateInput-DateFormat="dd-MMM-yyyy">
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
                <td style="width: 120px; background-color: whitesmoke;">Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboSubcon" runat="server" Width="150px" AppendDataBoundItems="True"
                        DataSourceID="subconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" AutoPostBack="True"  CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="(Select)" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="SubconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
             <tr>
                <td style="width: 130px; background-color: whitesmoke;">Created By
                </td>
                <td>
                    <telerik:RadDropDownList ID="createdDDL" runat="server" AppendDataBoundItems="True" DataSourceID="userDataSource"
                        DataTextField="USER_NAME" DataValueField="USER_ID" Width="150px" Enabled="false">
                    </telerik:RadDropDownList>

                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Test Pressure
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTestPress" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Test Medium
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTestMed" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Holding Time
                </td>
                <td>
                    <telerik:RadTextBox ID="txtHoldingTime" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="Label5" runat="server" Text="Remarks"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="userDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT USER_ID, USER_NAME FROM USERS"></asp:SqlDataSource>

</asp:Content>