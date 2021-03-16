<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV_Register.aspx.cs" Inherits="Material_MatReceiveNew" Title="Job Card MIV" %>

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
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">MIV Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMIV" runat="server" Width="220px" BackColor="LightGray" Enabled="false" Font-Bold="true" ForeColor="DarkRed"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtMIV"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Issue Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtIssueDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
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
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Created By
                </td>
                <td>
                    <telerik:RadDropDownList ID="createdDDL" runat="server" AppendDataBoundItems="True" DataSourceID="userDataSource"
                        DataTextField="USER_NAME" DataValueField="USER_ID" Width="200px" Enabled="false">
                    </telerik:RadDropDownList>

                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        Width="200px" AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Value="-1" Text="(SELECT ONE)" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="scValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" SetFocusOnError="True" ValueToCompare="-1" Operator="NotEqual" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Store
                </td>
                <td style="height: 24px">
                    <telerik:RadComboBox ID="rcbStore" runat="server" DataSourceID="StoreDataSource" DataTextField="STORE_NAME" DataValueField="STORE_ID"
                        Width="200px" AllowCustomText="true" Filter="Contains" Enabled="false">
                    </telerik:RadComboBox>
                      <asp:RequiredFieldValidator ID="storeValidator" runat="server" ErrorMessage="*" ControlToValidate="rcbStore" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Job Card Number
                </td>
                <td style="height: 24px">

                    <telerik:RadComboBox ID="JCNumber" runat="server" DataSourceID="woDataSource" DataTextField="wo_name" DataValueField="wo_id"
                        Width="200px" OnSelectedIndexChanged="cboWO_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false"
                        AllowCustomText="true" Filter="Contains">
                    </telerik:RadComboBox>
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

    
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID =:PROJECT_ID AND (SC_ID = :SC_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="woDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WO_ID, WO_NAME FROM VIEW_ADAPTER_FAB_JC WHERE (PROJ_ID = :PROJECT_ID) AND (SUB_CON_ID = :SUB_CON_ID) ORDER BY WO_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SUB_CON_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="userDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT USER_ID, USER_NAME FROM USERS"></asp:SqlDataSource>
</asp:Content>
