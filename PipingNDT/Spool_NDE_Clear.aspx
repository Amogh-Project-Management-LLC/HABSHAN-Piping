<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Spool_NDE_Clear.aspx.cs" Inherits="Spool_NDE_Clear" Title="Spool NDE Clearance" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:UpdatePanel ID="AutoUpdatePanel" runat="server">
            <ContentTemplate>
                <table>
                    <tr>

                        <td>
                            <telerik:RadButton ID="btnAutoNDE" runat="server" Text="Auto Update" Width="120" OnClick="btnAutoNDE_Click" CausesValidation="False"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                         <td>
                            <telerik:RadButton ID="btnBulk" runat="server" Text="Bulk NDE Complete(<100%)" Width="200" OnClick="btnBulk_Click"
                                 CausesValidation="false"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <table style="width: 100%;">
            <tr>
                <td style="width: 160px; background-color: Gainsboro;">Spool NDE Clear Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtClearDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Culture="en-US">
                    </telerik:RadDatePicker>

                    <asp:RequiredFieldValidator ID="ClearDateValidator" runat="server" ControlToValidate="txtClearDate"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 160px; background-color: Gainsboro;">Subcon Name
                </td>
                <td>
                    <asp:DropDownList ID="ddSubcon" runat="server" Width="200px" AppendDataBoundItems="True"
                        AutoPostBack="True" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME"
                        DataValueField="SUB_CON_ID" OnSelectedIndexChanged="ddSubcon_SelectedIndexChanged">
                        <asp:ListItem Value="-1">(Select Subcon)</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 160px; background-color: Gainsboro;">Isometric Number
                </td>
                <td>
                    <asp:TextBox ID="txtIsome" runat="server" Width="200px" AutoPostBack="True"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table>
            <tr>
                <td style="text-align: center; background-color: gainsboro">
                    <span style="font-weight: bold;">All Spools</span>
                </td>
                <td style="text-align: center; background-color: gainsboro">
                    <span style="font-weight: bold;">Selected Spools</span>
                </td>
            </tr>
            <tr>
                <td style="width: 360px; vertical-align: top">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <telerik:RadListBox runat="server" ID="SPL_ListBoxSource" Height="350px" Width="350px"
                                AllowTransfer="True" TransferToID="SPL_ListBoxDestination" AllowTransferOnDoubleClick="True" DataSourceID="spoolsDataSource" DataTextField="SPL_TITLE" DataValueField="SPL_ID">
                                <Items>
                                </Items>
                            </telerik:RadListBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="vertical-align: top;">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadListBox runat="server" ID="SPL_ListBoxDestination" Height="350px" Width="350px">
                                <Items>
                                </Items>
                            </telerik:RadListBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="spoolsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, SPL_ID, SPL_TITLE
FROM VIEW_SPL_NDE_STATUS
WHERE (NDE_CMPLT_DT IS NULL) AND (WO_NAME IS NOT NULL) AND
(WELD_DATE IS NOT NULL OR TOTAL_JNTS = 0) AND (SUB_CON_ID = :SC_ID) AND (SUPP_JNT_BAL = 0) AND
NDE_BALANCE = 'N' AND HOLD_FLG = 'N' AND
PROJ_ID = :PROJECT_ID AND ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1)
ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>