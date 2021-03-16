<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReturnRegister.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Material Return - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <asp:Label ID="Label1" runat="server" Text="Return Number"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRetNumber" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="retNoValidator" runat="server" ControlToValidate="txtRetNumber"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <asp:Label ID="Label2" runat="server" Text="Return Date"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <asp:Label ID="Label3" runat="server" Text="Return by"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRetby" runat="server" Width="160px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <asp:Label ID="Label4" runat="server" Text="From Store"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboStore1" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px" AutoPostBack="True"
                        OnSelectedIndexChanged="cboStore1_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="storeValidator" runat="server" ControlToValidate="cboStore1"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <asp:Label ID="Label5" runat="server" Text="To Store"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboStore2" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboStore2"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: WhiteSmoke">
                    <asp:Label ID="Label7" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: gainsboro;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>