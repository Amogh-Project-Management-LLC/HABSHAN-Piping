<%@ Page Title="Bulk PDF Download" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BulkPDFDownloads.aspx.cs" Inherits="Home_BulkPDFDownloads" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .fontClass {
            font-weight: 500;
            font-size: medium;
            color: black
        }
    </style>
    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <div>
        <div style="background-color: #E2E2E2; color: darkgrey; height: 30px; padding-top: 5px; padding-left: 5px">
            <asp:Label ID="Label1" runat="server" Text="Select Category to Download" CssClass="fontClass"></asp:Label>
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
                        </asp:RadioButtonList>
                    </td>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckSpoolList" runat="server" RepeatDirection="Vertical" Width="100%" Height="170px"
                            Enabled="true" OnSelectedIndexChanged="CheckSpoolList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="PIPSPLHS">Spool History Sheet</asp:ListItem>
                            <asp:ListItem Value="PIPSPLHSHYDRO">Spool History Sheet For Hydro Test</asp:ListItem>
                            <asp:ListItem Value="SPL_HS">Spool History Sheet (Scanned Copy)</asp:ListItem>
                            <asp:ListItem Value="FLUSHING">FLUSHING</asp:ListItem>
                            <asp:ListItem Value="SPL_GALV">GALVANIZING</asp:ListItem>
                            <asp:ListItem Value="PAINTING">PAINTING</asp:ListItem>
                            <asp:ListItem Value="PICKLING">PICKLING</asp:ListItem>
                            <asp:ListItem Value="SPL_BARCODE">SPOOL BARCODE STICKER</asp:ListItem>
                            <asp:ListItem Value="SFR_BARCODE">SFR PIPE BARCODE STICKER</asp:ListItem>
                            <asp:ListItem Value="SPL_QRCODE">SPOOL QRCODE STICKER</asp:ListItem>
                            <asp:ListItem Value="SFR_QRCODE">SFR PIPE QRCODE STICKER</asp:ListItem>

                        </asp:RadioButtonList>
                    </td>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckJointList" runat="server" RepeatDirection="Vertical" RepeatColumns="2" Width="100%"
                            Height="170px" Enabled="true" OnSelectedIndexChanged="CheckJointList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="FITUP">Fitup</asp:ListItem>
                            <asp:ListItem Value="WELDING">Welding</asp:ListItem>
                            <asp:ListItem Value="DIM_CHECK">DIM CHECK</asp:ListItem>
                            <asp:ListItem Value="RT">RT</asp:ListItem>
                            <asp:ListItem Value="PT">PT</asp:ListItem>
                            <asp:ListItem Value="MT">MT</asp:ListItem>
                            <asp:ListItem Value="UT">UT</asp:ListItem>
                            <asp:ListItem Value="PWHT">PWHT</asp:ListItem>
                            <asp:ListItem Value="PMI">PMI</asp:ListItem>
                            <asp:ListItem Value="HT">HT</asp:ListItem>
                            <asp:ListItem Value="FT">FT</asp:ListItem>
                            <%--   <asp:ListItem Value="NDT_Field_Summary">NDT_Field_Summary</asp:ListItem>
                            <asp:ListItem Value="NDT_Shop_Summary">NDT_Shop_Summary</asp:ListItem>
                            <asp:ListItem Value="Line_NDT_Summary">Line_NDT_Summary</asp:ListItem>--%>
                        </asp:RadioButtonList>
                    </td>
                    <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckMaterialList" runat="server" RepeatDirection="Vertical" Width="100%" Height="170px"
                            Enabled="true" OnSelectedIndexChanged="CheckMaterialList_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="MRIR">MRIR</asp:ListItem>
                            <asp:ListItem Value="ESD">ESD</asp:ListItem>
                            <asp:ListItem Value="MTC">MTC</asp:ListItem>
                            <asp:ListItem Value="PO">PO</asp:ListItem>
                            <asp:ListItem Value="DAILYFITUP">DAILY FITUP REPORT</asp:ListItem>
                            <asp:ListItem Value="DAILYWELD">DAILY WELD REPORT</asp:ListItem>
                            <asp:ListItem Value="DAILYNDT">DAILY NDT REPORT</asp:ListItem>
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
                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MaxFileInputsCount="1"></telerik:RadAsyncUpload>
                    </td>
                    <td>
                        <telerik:RadButton ID="btnDownload" runat="server" Text="Download" OnClick="btnDownload_Click"></telerik:RadButton>
                    </td>
                    <td>
                        <asp:HyperLink ID="linkSample" runat="server">Sample File</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 200px" colspan="4">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, ISO_TITLE1, SPOOL_NO, USER_NAME, CREATE_DATE, EXPORT_OPTION, SPL_ID, ITEM_ID FROM BULK_SPOOL_BARCODE_DOWNLOAD WHERE (USER_NAME = :USER_NAME)">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="~" Name="USER_NAME" SessionField="USER_NAME" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, MAT_CODE1, HEAT_NO, PAINT_CODE, USER_NAME, CREATE_DATE, EXPORT_OPTION, ITEM_ID, ITEM_ID AS SPL_ID FROM BULK_BARCODE_SFR WHERE (USER_NAME = :USER_NAME)">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="~" Name="USER_NAME" SessionField="USER_NAME" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <telerik:RadLabel ID="lblMessage" Text="" runat="server" ForeColor="Red"></telerik:RadLabel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <%--   </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

