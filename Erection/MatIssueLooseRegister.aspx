<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatIssueLooseRegister.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Register Field Job Card" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadMenu ID="RadMenu9" runat="server" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false" CssClass="RadMenuStyle">
        <Items>
            <telerik:RadMenuItem CssClass="menu-right">
                <ItemTemplate>
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: left; width: 100%;">
                                <td style="text-align: right;">
                                    <asp:LinkButton ID="btnBack" runat="server" Text="Back" Font-Underline="false"
                                        OnClick="btnBack_Click1" CausesValidation="false"></asp:LinkButton>
                                </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadMenuItem>
        </Items>
    </telerik:RadMenu>

    <table style="width: 100%" class="TableStyle">
        <tr>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label5" runat="server" Text="Subcon"></asp:Label>
            </td>
            <td>
                <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="150px" AutoPostBack="True"
                    OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" CausesValidation="false">
                    <Items>
                        <telerik:DropDownListItem Text="(Select)" Value="-1" />
                    </Items>
                </telerik:RadDropDownList>
                <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                    ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
            </td>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label1" runat="server" Text="Issue Number"></asp:Label>
            </td>
            <td>
                <telerik:RadTextBox ID="txtIssueNumber" runat="server" Width="250px" ReadOnly="true" EmptyMessage="Select a Subcon" Font-Bold="true"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="issueNoValidator" runat="server" ControlToValidate="txtIssueNumber"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label7" runat="server" Text="Material Subcon"></asp:Label>
            </td>
            <td>
                <telerik:RadDropDownList ID="cboMatSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="MatSubconDataSource"
                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="150px" CausesValidation="False" SelectedText="(Select)">
                    <Items>
                        <telerik:DropDownListItem Text="(Select)" Value="" Selected="True" />
                    </Items>
                </telerik:RadDropDownList>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboSubcon"
                    ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
            </td>
            <td style="width: 120px; background-color: whitesmoke">Material Type
            </td>
            <td>
                <telerik:RadTextBox ID="txtMaterialType" runat="server" Width="100px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label2" runat="server" Text="Issue Date"></asp:Label>
            </td>
            <td>
                <telerik:RadDatePicker ID="txtIssueDate" runat="server" Width="120px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="issueDateValidator" runat="server" ControlToValidate="txtIssueDate"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
            <td style="width: 120px; background-color: whitesmoke">Revision Date
            </td>
            <td>
                <telerik:RadDatePicker ID="txtRevDate" runat="server" Width="120px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label3" runat="server" Text="Issued by"></asp:Label>
            </td>
            <td>
                <telerik:RadTextBox ID="txtIssuedBy" runat="server" Width="130px" ReadOnly="true"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="issueByValidator" runat="server" ControlToValidate="txtIssuedBy"
                    ErrorMessage="*"></asp:RequiredFieldValidator>
            </td>
            <td style="width: 120px; background-color: whitesmoke">JC Revision
            </td>
            <td>
                <telerik:RadTextBox ID="txtJC_REV" runat="server" Width="100px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label4" runat="server" Text="Job Card Type"></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="checkJCType" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="100% Material" Value="MATERIAL_AVAILABLE"></asp:ListItem>
                    <asp:ListItem Text="Partial Material" Value="PARTIAL_AVAILABLE" Selected="True"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 120px; background-color: whitesmoke">WBS/AREA
            </td>
            <td>
                <telerik:RadAutoCompleteBox ID="txtArea" runat="server" DataSourceID="sqlAreaSource" DataTextField="AREA_L1"
                    DataValueField="AREA_L1" EmptyMessage="Start typing Area...." InputType="Text">
                    <TextSettings SelectionMode="Single" />
                </telerik:RadAutoCompleteBox>
            </td>
            <td style="width: 120px; background-color: whitesmoke">
                <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
            </td>
            <td>
                <telerik:RadTextBox ID="txtRemarks" runat="server" Width="450px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: left; padding-top: 20px">
                <telerik:RadButton ID="btnSubmit" runat="server"
                    Text="Submit" Width="80px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR 
WHERE (PROJ_ID = :PROJECT_ID)
AND (FIELD_SC = 'Y')
 ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) AND (SC_ID = :SC_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAreaSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT AREA_L1 FROM IPMS_AREA ORDER BY AREA_L1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MatSubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR 
WHERE (PROJ_ID = :PROJECT_ID)
AND (SUB_CON_ID = :SUB_CON_ID OR COMMON_STORE='Y')  ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SUB_CON_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
