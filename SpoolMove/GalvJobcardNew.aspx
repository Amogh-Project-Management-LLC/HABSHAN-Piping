<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="GalvJobcardNew.aspx.cs" Inherits="SpoolMove_GalvJobcardNew" Title="Galvanising Jobcard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table style="width: 100%" class="TableStyle">
            <tr>
                <td style="width: 100px; background-color: Whitesmoke;">Jobcard No
                </td>
                <td>
                    <asp:TextBox ID="txtSerialNo" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="serialValidator" runat="server" ControlToValidate="txtSerialNo"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Whitesmoke;">Issue Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Whitesmoke;">Subcon
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                        Width="156px" AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Whitesmoke;">Remarks
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="450px"></asp:TextBox>
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
</asp:Content>