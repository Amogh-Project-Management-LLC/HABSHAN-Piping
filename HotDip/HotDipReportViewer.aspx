<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HotDipReportViewer.aspx.cs" Inherits="ColdBending_ColdBendingReportViewer"
    Title="Peview Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table style="width: 100%">
        <tr style="background-color: gainsboro;">
            <td>
                <a href="javascript:history.back(1)" onmouseout="document.backicon.src='../images/back_a.png' ;"
                    onmouseover="document.backicon.src='../images/back_b.png' ;">
                    <img border="0" name="backicon" src="../Images/back_a.png" /></a>
            </td>
        </tr>
        <tr>
            <td>
                <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="380px" Width="100%">
                    <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
            </td>
        </tr>
    </table>
</asp:Content>