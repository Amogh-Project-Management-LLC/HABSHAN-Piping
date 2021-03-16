<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FOIDateSelectionProg.aspx.cs" Inherits="BasicReports_FOIDateSelectionProg"
    Title="Piping Progrss" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            var datepicker = $find("<%=txtDateFrom.ClientID %>");
            datepicker.clear();
            var datepicker2 = $find("<%=txtDateTo.ClientID %>");
            datepicker2.clear();
        }

        function ValidateDateFrom(sender, args) {
            var datepicker = $find("<%=txtDateFrom.ClientID %>");
            if (datepicker.get_textBox().control.get_value() == "")
                args.IsValid = false;
            else
                args.IsValid = true;
        }

        function ValidateDateTo(sender, args) {
            var datepicker = $find("<%=txtDateTo.ClientID %>");
            if (datepicker.get_textBox().control.get_value() == "")
                args.IsValid = false;
            else
                args.IsValid = true;
        }
    </script>

    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            
            <tr>
                <td style="width: 125px; background-color: Gainsboro">Date From
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateFrom" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateFrom">
                    </asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 125px; background-color: Gainsboro">Date To
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtDateTo" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="*" EnableClientScript="true" ClientValidationFunction="ValidateDateTo">
                    </asp:CustomValidator>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnArea" runat="server" Text="Area Wise" Width="80" OnClick="btnArea_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSize" runat="server" Text="Subcon Wise" Width="80" OnClick="btnSize_Click"></telerik:RadButton>
                </td>
                
            </tr>
        </table>
    </div>
</asp:Content>