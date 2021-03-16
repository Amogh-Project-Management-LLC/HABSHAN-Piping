<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportViewer.aspx.cs" MasterPageFile="~/MasterPage.master"  
    Inherits="WeldingInspec_ReportViewer" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-color: whitesmoke;">
        <a href="javascript:history.back(1)" onmouseout="document.getElementById('backicon').src='../images/back_a.png' ;"
            onmouseover="document.getElementById('backicon').src='../images/back_b.png' ;">
            <img border="0" id="backicon" src="../Images/back_a.png" /></a>
    </div>

    <div>
        <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="420px" Width="100%">
            <LocalReport EnableExternalImages="True">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>

</asp:Content>