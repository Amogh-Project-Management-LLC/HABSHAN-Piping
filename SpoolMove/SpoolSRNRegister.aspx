<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolSRNRegister.aspx.cs" Inherits="SpoolMove_SpoolSRNRegister"
    Title="Register SRN" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">

        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 140px;">Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                        Width="200px" AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="Select SubCon" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="SubconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red" ValidationGroup="submit"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Transmittal No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransNo" runat="server" Width="200px" ReadOnly="true"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="TransNoFieldValidator" runat="server" ControlToValidate="txtTransNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="submit"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Ship No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipNo" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Area</td>
                <td>
                    <telerik:RadTextBox ID="txtArea" runat="server" Width="100px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">ETA Date</td>
                <td>
                    <telerik:RadDatePicker ID="etaDatePicker" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ValidationGroup="submit" ID="etaRequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="etaDatePicker" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Delivery Location</td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadDropDownList ID="ddDelLoc" runat="server" AppendDataBoundItems="True" DataSourceID="deliveryLocDataSource"
                                    DataTextField="DELIVERY_LOCATION" DataValueField="DELIVERY_LOCATION"
                                    Width="200px" AutoPostBack="True" OnSelectedIndexChanged="ddDelLoc_SelectedIndexChanged">
                                    <Items>
                                        <telerik:DropDownListItem Selected="true" Text="Select Delivery Location" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtDelLocation" runat="server" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Issue Date </td>
                <td>
                    <telerik:RadDatePicker ID="txtTransDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ValidationGroup="submit" ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtTransDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Issued By</td>
                <td>
                    <telerik:RadTextBox ID="txtUserName" runat="server" Width="100px" ReadOnly="true"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 140px;">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" ValidationGroup="submit"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) AND (FAB_SC = 'Y' OR PAINT_SC ='Y') ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="deliveryLocDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DELIVERY_LOCATION FROM PIP_SRN_DEL_LOCATION WHERE PROJECT_ID = :PROJECT_ID ORDER BY DELIVERY_LOCATION">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>