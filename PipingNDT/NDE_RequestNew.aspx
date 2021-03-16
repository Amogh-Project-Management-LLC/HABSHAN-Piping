<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_RequestNew.aspx.cs" Inherits="WeldingInspec_NDE_RequestNew" Title="New NDE Request" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="padding-left: 10px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table style="width: 100%">
                <tr>
                    <td style="width: 100px; background-color: Gainsboro;">NDE Type
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboNdeType" runat="server" AppendDataBoundItems="True" DataSourceID="ndetypeDataSource"
                            DataTextField="NDE_TYPE" DataValueField="NDE_TYPE_ID" Width="200px" CausesValidation="false" AutoPostBack="true" OnSelectedIndexChanged="cboNdeType_SelectedIndexChanged">
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:CompareValidator ID="ndetypeValidator" runat="server" ControlToValidate="cboNdeType"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>

                <tr>
                    <td style="width: 100px; background-color: Gainsboro;">Subcon
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="200px"
                            AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" CausesValidation="false">
                            <Items>
                                <telerik:DropDownListItem Text="Select" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>

                <tr>
                    <td style="width: 100px; background-color: Gainsboro;">Request No
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtReqNo" runat="server" Width="200px"></telerik:RadTextBox>
                        <asp:RequiredFieldValidator ID="ReqNoValidator" runat="server" ControlToValidate="txtReqNo"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; background-color: Gainsboro;">Issue Date
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="txtIssueDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Culture="en-US" Width="200px">
                        </telerik:RadDatePicker>

                        <asp:RequiredFieldValidator ID="IssueDateValidator" runat="server" ControlToValidate="txtIssueDate"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td style="width: 100px; background-color: Gainsboro;">Remarks
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtRemarks" runat="server" Width="300px"></telerik:RadTextBox>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="ndetypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT NDE_TYPE_ID, NDE_TYPE FROM PIP_NDE_TYPE ORDER BY NDE_TYPE'></asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>