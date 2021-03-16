<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_SWN_New.aspx.cs" Inherits="PipeSupport_Supp_SWN_New" Title="Support SWN" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="80px"
                                BackColor="SkyBlue" BorderColor="SteelBlue" CausesValidation="False" />
                        </td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                Width="80px" BackColor="SkyBlue" BorderColor="SteelBlue" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table class="TableStyle" style="width: 100%">
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">SWN No
                                </td>
                                <td>
                                    <asp:TextBox ID="txtJcNumber" runat="server" Width="200px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="JcNumberValidator" runat="server" ControlToValidate="txtJcNumber"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Issue Date
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIssueDate" runat="server" Width="100px"></asp:TextBox>
                                    <cc1:CalendarExtender ID="calExtender5" runat="server" Format="dd-MMM-yyyy" OnClientShowing="DisplayDateToday"
                                        PopupButtonID="btnDate" PopupPosition="BottomRight" TargetControlID="txtIssueDate">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="btnDate" runat="server" ImageUrl="~/images/pdate.gif" />
                                    <asp:RequiredFieldValidator ID="issueDateValidator" runat="server" ControlToValidate="txtIssueDate"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Subcon
                                </td>
                                <td>
                                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                        OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" Width="200px">
                                        <asp:ListItem Selected="True" Value="-1">(Select)</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Location</td>
                                <td>
                                    <asp:DropDownList ID="cboShop" runat="server" AutoPostBack="True"
                                        DataSourceID="shopDataSource" DataTextField="SHOP_NO" DataValueField="SHOP_ID"
                                        Width="200px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 140px; background-color: #ccccff;">Remarks
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRem" runat="server" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="shopDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SHOP_ID, SHOP_NO FROM PIP_FAB_SHOP WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY SHOP_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>