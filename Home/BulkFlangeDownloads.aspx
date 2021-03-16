<%@ Page Title="Bulk Flange PDF Download" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BulkFlangeDownloads.aspx.cs" Inherits="Home_BulkFlangeDownloads_1" %>

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
            <table style="width: 100%" >
                <tr style="background-color: #E2E2E2; height: 25px; color: black; text-align: center; font-weight: 500">
                   <td>Flange</td>
                </tr>
               <tr>
                   <td style="vertical-align: top; border-color: #E2E2E2; border-style: Solid; border-width: 2px">
                        <asp:RadioButtonList ID="CheckFlangeList" runat="server" RepeatDirection="Vertical" Width="100%" Height="170px"
                            Enabled="true" OnSelectedIndexChanged="CheckFlangeList_SelectedIndexChanged" AutoPostBack="true">
                            <%--<asp:ListItem Value="FLANGE_BARCODE">FLANGE BARCODE STICKER</asp:ListItem>--%>
                            <asp:ListItem Value="FLANGE_QRCODE">FLANGE QRCODE STICKER</asp:ListItem>
                            <asp:ListItem Value="PIDHC">FLANGE PID Hcopy</asp:ListItem>
                            <asp:ListItem Value="PIDMARKUP">FLANGE PID Markup</asp:ListItem>
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
                      
                          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, ISO_TITLE1, JOINT_NO, USER_NAME, CREATE_DATE, EXPORT_OPTION, JOINT_ID, ITEM_ID FROM BULK_FLANGE_BARCODE_DOWNLOAD WHERE (USER_NAME = :USER_NAME) AND JOINT_ID IS NOT NULL">
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

