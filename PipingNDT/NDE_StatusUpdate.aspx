<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_StatusUpdate.aspx.cs" Inherits="PipingNDT_NDE_StatusUpdate" Title="NDT Status Update" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <div>
            <table style="width: 100%; background-color: whitesmoke">
                <tr>
                    <td>
                        <telerik:RadLinkButton runat="server" Text="Back" Width="100" NavigateUrl="NDE_Status.aspx"></telerik:RadLinkButton>
                    </td>
                  
                    <td style="width: 100%; text-align: right"></td>
                </tr>
            </table>
        </div>
    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Status
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddPassFlag" runat="server" AppendDataBoundItems="True" DataSourceID="PassFlgDataSource"
                        DataTextField="PASS_FLG" DataValueField="PASS_FLG_ID" Width="150px" DefaultMessage="Select">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">
                    <asp:Label ID="Label3" runat="server" Text="NDE Report No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRepNo" runat="server" Width="250px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtRepNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">NDE Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtRepDate" runat="server" Width="150px" DateInput-DateFormat="dd-MMM-yyyy" Culture="en-US">
                    </telerik:RadDatePicker>

                    <asp:RequiredFieldValidator ID="NDE_DateValidator" runat="server" ControlToValidate="txtRepDate"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            </tr>
            <tr runat="server" id="row_PT_MT_ReportNo" visible="false">
                <td style="width: 150px; background-color: Gainsboro">
                    <asp:Label ID="lbl_PT_MT_ReportNo" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPT_MT_ReportNo" runat="server" Width="250px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr runat="server" id="row_PT_MT_ReportDate" visible="false">
                <td style="width: 150px; background-color: Gainsboro">
                    <asp:Label ID="lbl_PT_MT_ReportDate" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtPT_MT_ReportDate" runat="server" Width="150px" DateInput-DateFormat="dd-MMM-yyyy" Culture="en-US">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr runat="server" id="row_film1" visible="false">
                <td style="width: 150px; background-color: Gainsboro">Total Films
                </td>
                <td>
                    <telerik:RadTextBox ID="txtFilm1" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr runat="server" id="row_film2" visible="false">
                <td style="width: 150px; background-color: Gainsboro">Accepted Films
                </td>
                <td>
                    <telerik:RadTextBox ID="txtFilm2" runat="server" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
           
        </table>
    </div>
      <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="PassFlgDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand=''></asp:SqlDataSource>
</asp:Content>