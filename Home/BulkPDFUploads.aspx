<%@ Page Title="Bulk PDF Upload" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BulkPDFUploads.aspx.cs" Inherits="Home_BulkPDFUploads" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .fontClass {
            font-weight: 500;
            font-size: medium;
            color: black
        }
    </style>
    <script type="text/javascript">
            function DeleteFiles()
            {
             var upload = $find("<%= RadAsyncUpload1.ClientID %>");
             var inputs = upload.getUploadedFiles().length;
              for (i = 0; i <= inputs; i++)
             {
              upload.deleteFileInputAt(i);
             }
            }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <div>
        <div style="background-color: #E2E2E2; color: darkgrey; height: 30px; padding-top: 5px; padding-left: 5px">
            <asp:Label ID="Label1" runat="server" Text="Select Category to Upload" CssClass="fontClass"></asp:Label>
        </div>
        <div style="margin-top: 3px;">
            <table style="width: 100%" cellspacing="0">
                <tr style="background-color: #E2E2E2; height: 25px; color: black; text-align: center; font-weight: 500">
                    <td>Isometric/Spool PDF</td>
                    <td>Spool Reports</td>
                    <td>Joint Reports (Welding/NDE)</td>
                    <td>Material Reports</td>
                </tr>
                <tr>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckIsomeList" runat="server" RepeatDirection="Vertical" Width="100%" Height="170px"
                            Enabled="true" OnSelectedIndexChanged="CheckIsomeList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="PIPISO">Isometric Spoolgen</asp:ListItem>
                            <asp:ListItem Value="PIPISOHC">Isometric Hard Copy</asp:ListItem>
                            <asp:ListItem Value="PIPISOAB">Isometric As-built</asp:ListItem>
                            <asp:ListItem Value="PIPSPL">Spool Copy</asp:ListItem>
                            <asp:ListItem Value="PIPSPLAB">Spool As-built</asp:ListItem>
                            <asp:ListItem Value="PID">P&ID Reports</asp:ListItem>
                            <asp:ListItem Value="PIPISOMD">Isometric Marking</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckSpoolList" runat="server" RepeatDirection="Vertical" RepeatColumns="2" Width="100%" Height="170px"
                            Enabled="true" OnSelectedIndexChanged="CheckSpoolList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="PIPSPLHS">Spool History Sheet</asp:ListItem>
                            <asp:ListItem Value="FLUSHING">FLUSHING</asp:ListItem>
                            <asp:ListItem Value="GALVANIZING">GALVANIZING</asp:ListItem>
                            <asp:ListItem Value="PAINTING">PAINTING</asp:ListItem>
                            <asp:ListItem Value="PICKLING">PICKLING</asp:ListItem>
                            <asp:ListItem Value="ARN">IRN BEFORE PAINT(ARN)</asp:ListItem>
                            <asp:ListItem Value="SPL_IRN">IRN AFTER PAINT</asp:ListItem>
                            <asp:ListItem Value="SRN">SRN</asp:ListItem>
                             <asp:ListItem Value="SPL_TRANSFER">SPOOL TRANSFER</asp:ListItem>
                             <asp:ListItem Value="SPL_RECEIVE">SPOOL RECEIVE</asp:ListItem>
                             <asp:ListItem Value="SPL_SITE_INSP">SITE INSPECTION</asp:ListItem>
                            <asp:ListItem Value="SPL_ISSUED_SITE_SC">ISSUED TO SITE SUBCON</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckJointList" runat="server" RepeatDirection="Vertical" RepeatColumns="2" Width="100%"
                            Height="170px" Enabled="true" OnSelectedIndexChanged="CheckJointList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="FITUP">Fitup</asp:ListItem>
                            <asp:ListItem Value="WELDING">Welding</asp:ListItem>
                            <asp:ListItem Value="DIM CHECK">DIM CHECK</asp:ListItem>
                            <asp:ListItem Value="RT">RT</asp:ListItem>
                            <asp:ListItem Value="PT">PT</asp:ListItem>
                            <asp:ListItem Value="MT">MT</asp:ListItem>
                            <asp:ListItem Value="UT">UT</asp:ListItem>
                            <asp:ListItem Value="PWHT">PWHT</asp:ListItem>
                            <asp:ListItem Value="PMI">PMI</asp:ListItem>
                            <asp:ListItem Value="HT">HT</asp:ListItem>
                            <asp:ListItem Value="FT">FT</asp:ListItem>
                            <asp:ListItem Value="PAUT">PAUT</asp:ListItem>
                            <%--   <asp:ListItem Value="NDT_Field_Summary">NDT_Field_Summary</asp:ListItem>
                            <asp:ListItem Value="NDT_Shop_Summary">NDT_Shop_Summary</asp:ListItem>
                            <asp:ListItem Value="Line_NDT_Summary">Line_NDT_Summary</asp:ListItem>--%>
                        </asp:RadioButtonList>
                    </td>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px;display:none">
                        <asp:RadioButtonList ID="CheckMaterialList" runat="server" RepeatDirection="Vertical" Width="100%" Height="170px"
                            Enabled="true" OnSelectedIndexChanged="CheckMaterialList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="MRIR">MRIR</asp:ListItem>
                            <asp:ListItem Value="ESD">ESD</asp:ListItem>
                            <asp:ListItem Value="MTC">MTC</asp:ListItem>
                            <asp:ListItem Value="PO">PO</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        </div>
        <div style="background-color: #E2E2E2; padding-left: 5px">
            <table>
                <tr>
                    <td>Select File:
                    </td>
                    <td>
                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MultipleFileSelection="Automatic" UploadedFilesRendering="BelowFileInput"></telerik:RadAsyncUpload>
                    </td>
                    <td style="vertical-align:top;padding-left:200px">
                        <telerik:RadButton ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"></telerik:RadButton>
                    </td>
                    <td style="vertical-align:top;padding-left:10px">
                        <telerik:RadButton ID="btnClear"  runat="server" Text="Clear" OnClientClick="DeleteFiles(); return false;"></telerik:RadButton>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 200px" colspan="4">
                        <telerik:RadLabel ID="lblMessage" Text="" runat="server" ForeColor="Red"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <%--   </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

