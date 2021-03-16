<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_JobCard_Select.aspx.cs" Inherits="PipeSupport_Supp_JobCard_Select"
    Title="Support Selection" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Src="~/UserControls/NotificationBox.ascx" TagPrefix="uc1" TagName="NotificationBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnApplyFilter" runat="server" Text="Apply Filter" Width="110" OnClick="btnApplyFilter_Click" CausesValidation="false"></telerik:RadButton>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" OnClick="btnMbrs_Click"></telerik:RadButton>
                                </td>
                                <td>
                                    <asp:HiddenField ID="PipingJC_HiddenField" runat="server" Value="Y" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <uc1:NotificationBox runat="server" ID="NotificationBox" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 160px; background-color: Gainsboro;">Piping Job-Card</td>
                                <td style="text-align: left">
                                    <asp:CheckBox ID="PipingJC_CheckBox" runat="server" AutoPostBack="True" Text="Issued" OnCheckedChanged="PipingJC_CheckBox_CheckedChanged" Checked="True" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: Gainsboro;">Material Type </td>
                                <td style="text-align: left">
                                    <asp:DropDownList ID="ddMaterialType" runat="server" AppendDataBoundItems="True" DataSourceID="MaterialTypeDataSource" DataTextField="MAT_TYPE" DataValueField="MAT_TYPE" Width="200px">
                                        <asp:ListItem Selected="True" Text="ANY" Value="ANY"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: Gainsboro;">Paint Code</td>
                                <td style="text-align: left">
                                    <asp:DropDownList ID="ddPaintCode" runat="server" AppendDataBoundItems="True" DataSourceID="PaintCodeDataSource" DataTextField="PAINT_CODE" DataValueField="PAINT_CODE" Width="200px">
                                        <asp:ListItem Selected="True" Text="ANY" Value="ANY"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: Gainsboro;">Isometric No</td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtIso" runat="server" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: Gainsboro;">Support Tag
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtSuppTagNo" runat="server" Width="200"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 160px; background-color: Gainsboro;">Support Description
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtSuppDesc" runat="server" Width="400"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td style="background-color: gainsboro; border-radius: 4px; text-align: center;">All Supports
                                </td>
                                <td style="background-color: gainsboro; border-radius: 4px; text-align: center;">Selected Supports
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadListBox ID="All_Supports" runat="server" Width="500px" Height="350px" DataSourceID="AllSupportDataSource"
                                                DataTextField="SUPP_DESC_ISO" DataValueField="BOM_ID" AllowTransfer="True" TransferToID="Selected_Supports" SelectionMode="Multiple">
                                            </telerik:RadListBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>

                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <telerik:RadListBox ID="Selected_Supports" runat="server" Width="500px" Height="350px" SelectionMode="Multiple"></telerik:RadListBox>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="AllSupportDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, SUPP_DESC_ISO
FROM VIEW_TOTAL_SUPP
WHERE PROJ_ID = :PROJECT_ID AND
SUPP_JC_NO IS NULL AND
(ISO_SPL_FAB_JC = :ISO_SPL_FAB_JC OR :ISO_SPL_FAB_JC = 'N') AND
ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1) AND
MAT_CODE1 LIKE FNC_FILTER(:MAT_CODE1) AND
MAT_DESCR LIKE FNC_FILTER(:MAT_DESCR) AND
(SPL_MAT_TYPE = :SPL_MAT_TYPE OR :SPL_MAT_TYPE = 'ANY') AND
(SPL_PAINT_CODE = :PS OR :PS = 'ANY') AND
ISO_ON_HOLD = 'N' AND
(BOM_HOLD_DATE IS NULL OR BOM_REL_DATE IS NOT NULL) AND
SF &lt;&gt; 8
ORDER BY SUPP_DESC_ISO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="PipingJC_HiddenField" DefaultValue="N" Name="ISO_SPL_FAB_JC" PropertyName="Value" />
            <asp:ControlParameter ControlID="txtIso" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtSuppTagNo" DefaultValue="%" Name="MAT_CODE1" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtSuppDesc" DefaultValue="%" Name="MAT_DESCR" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddMaterialType" DefaultValue="ANY" Name="SPL_MAT_TYPE" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddPaintCode" DefaultValue="ANY" Name="PS" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MaterialTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_TYPE FROM PIP_SPOOL WHERE (NOT (MAT_TYPE IS NULL)) ORDER BY MAT_TYPE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="PaintCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PAINT_CODE, JC_CODE FROM PIP_WORK_ORD_PS WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY PAINT_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>