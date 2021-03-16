<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SiteMIVCreate.aspx.cs" Inherits="Erection_SiteMIVCreate" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            padding-left: 5px;
            background-color: whitesmoke;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">MIV Type
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlJCType" runat="server" Width="200px" DataSourceID="MIVTypeDataSource" DataTextField="JC_TYPE" DataValueField="JC_TYPE_ID" OnSelectedIndexChanged="txtType_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">MIV Number
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtSiteMIVNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="submit"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSiteMIVNo" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Site MIV Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtMIVDate" runat="server" Width="200px"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Issue By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtIssueBy" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">JC Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlJCSubcon" DefaultMessage="(Select Subcon)" runat="server" Width="200px" AutoPostBack="True" DataSourceID="sqlJCSubconSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnSelectedIndexChanged="ddlJCSubcon_SelectedIndexChanged"></telerik:RadDropDownList>
                </td>

                <td class="Heading">JC No
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cboJCNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="submit"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboJCNo" EmptyMessage="(Select JC)" runat="server" Width="230px" DataSourceID="sqlJCNoSource" DataTextField="ISSUE_NO" DataValueField="JC_ID" Filter="Contains" Visible="true"></telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Material Subcon
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMatSubcon"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="submit"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlMatSubcon" DefaultMessage="(Material Subcon)" runat="server" Width="200px" AutoPostBack="True" DataSourceID="sqlMatSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"></telerik:RadDropDownList>
                </td>
                <td class="Heading">Store
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlStoreList"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="submit"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlStoreList" DefaultMessage="(Select Store)" runat="server" Width="230px" DataSourceID="sqlStoreSource" DataTextField="STORE_NAME" DataValueField="STORE_ID"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks
                </td>
                <td colspan="3">
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="100%" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td colspan="3">
                    <telerik:RadButton ID="btnSave" runat="server" Width="100px" Text="Save" OnClick="btnSave_Click" ValidationGroup="submit"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlJCSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (FIELD_SC = 'Y') ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlJCNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM PIP_MAT_ISSUE_LOOSE
WHERE SC_ID = :SC_ID
ORDER BY ISSUE_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlJCSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlFlangeJCSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM PIP_MAT_ISSUE_ASSEMBLY
WHERE SC_ID = :SC_ID
ORDER BY ISSUE_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlJCSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (SUB_CON_ID = :FIELD_SC) OR (COMMON_STORE = 'Y') ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlJCSubcon" DefaultValue="-1" Name="FIELD_SC" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME
FROM STORES_DEF
WHERE SC_ID = :SC_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MIVTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JC_TYPE_ID, JC_TYPE FROM PIP_MAT_ISSUE_JC_TYPE"></asp:SqlDataSource>
</asp:Content>

