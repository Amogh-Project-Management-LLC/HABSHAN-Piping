<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_ReportViewer.aspx.cs" Inherits="Supp_ReportViewer" Title="Preview Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table style="width: 100%">
        <tr>
            <td>
                <a href="javascript:history.back(1)" onmouseover="document.backicon.src='../images/back_b.png' ;"
                    onmouseout="document.backicon.src='../images/back_a.png' ;">
                    <img alt="" src="../Images/back_a.png" name="backicon" border="0" />
                </a>
            </td>
        </tr>
        <tr style="height: 320px" valign="top">
            <td>
                <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="330px" Width="100%">
                    <LocalReport EnableExternalImages="True" EnableHyperlinks="True" OnSubreportProcessing="ReportPreview_SubreportProcessing">
                    </LocalReport>
                </rsweb:ReportViewer>
            </td>
        </tr>
    </table>
</asp:Content>