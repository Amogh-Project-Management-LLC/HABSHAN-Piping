<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportViewer.aspx.cs" Inherits="SpoolMove_ReportViewer" Title="Preview Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: #99ccff;">
                <a href="javascript:history.back(1)" onmouseout="document.backicon.src='../images/back_a.png' ;"
                    onmouseover="document.backicon.src='../images/back_b.png' ;">
                    <img border="0" name="backicon" src="../Images/back_a.png" /></a>
            </td>
        </tr>
        <tr style="height: 350px" valign="top">
            <td colspan="3">
                <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="420px" Width="100%">
                    <ServerReport ReportServerUrl="http://localhost/piping" />
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