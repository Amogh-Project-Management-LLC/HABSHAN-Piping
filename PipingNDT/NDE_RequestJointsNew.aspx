<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PopupMasterPage.master"
    CodeFile="NDE_RequestJointsNew.aspx.cs" Inherits="PipingNDT_NDE_RequestJointsNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Isometric-Joint
                    </td>
                    <td>
                        <telerik:RadComboBox ID="rcbIsoJnt" runat="server" DataSourceID="newjointDataSource" DataTextField="JOINT_TITLE" AllowCustomText="true"
                            Filter="Contains" DataValueField="JOINT_ID" Width="250px"
                            AutoPostBack="true" EmptyMessage="Iso/Joint/Rev_code/CRW_code" EnableVirtualScrolling="true">
                        </telerik:RadComboBox>

                        <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="rcbIsoJnt"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="padding-top: 10px; padding-bottom: 10px">
                        <telerik:RadLabel runat="server" Text="Enter below details only if NDT report to be updated together else leave empty" Font-Bold="true" Font-Italic="true" BackColor="WhiteSmoke"></telerik:RadLabel>
                    </td>
                </tr>

                <tr>
                    <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Status
                    </td>
                    <td>
                        <telerik:RadDropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="true" Width="200px" DataSourceID="passFlagDataSource" DataTextField="pass_flg" DataValueField="pass_flg_id">
                            <Items>
                                <telerik:DropDownListItem Text="Select Status" Value="-1" Selected="true" />
                            </Items>
                        </telerik:RadDropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlStatus"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Report Number
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtReportNo" runat="server" Width="200px"></telerik:RadTextBox>

                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Report Date
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="txtReportDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                            <Calendar runat="server">
                                <SpecialDays>
                                    <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                    </telerik:RadCalendarDay>
                                </SpecialDays>
                            </Calendar>
                        </telerik:RadDatePicker>

                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Total Films
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFilm1" runat="server" Width="200px"></telerik:RadTextBox>

                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Accepted Films
                    </td>
                    <td>
                        <telerik:RadTextBox ID="txtFilm2" runat="server" Width="200px"></telerik:RadTextBox>

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
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div style="background-color: whitesmoke">
        <table>
            <tr>

                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="newjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="userDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT USER_ID, USER_NAME FROM USERS"></asp:SqlDataSource>
    <asp:SqlDataSource ID="passFlagDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PASS_FLG_ID,PASS_FLG FROM PIP_NDE_PASS_FLG"></asp:SqlDataSource>
</asp:Content>
