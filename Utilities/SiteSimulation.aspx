<%@ Page Title="Site Simulation" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SiteSimulation.aspx.cs" Inherits="Utilities_SiteSimulation" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="contact-area">
    <div style="width: 100%; background-color: gainsboro;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
    </div>
        <table>
            <tr>
                <td style="width: 100px; background-color: Gainsboro; width: 200px;">Last Run User</td>
                <td>:</td>
                <td>
                    <asp:Label ID="lblSmlUser" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>Last Run Time&nbsp;</td>
                <td>:</td>
                <td>
                    <asp:Label ID="lblSmlTime" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Gainsboro; width: 200px;">Source of Material&nbsp;</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoMaterialSource" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="MRIR" Value="MRIR" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="MRV" Value="MRV"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td>Use Common Store Material</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoUseCommonStore" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Gainsboro; width: 200px;">Subcon for Simulation</td>
                <td>:</td>
                <td>
                    <telerik:RadComboBox ID="ddSubConSelect" runat="server" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" Width="200"
                        DataSourceID="dsSubContractor" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Localization-AllItemsCheckedString="ALL SUBCON">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>Drawing Status</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoDwgStatus" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Mat Check & Back Check Done" Value="MCBC" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Transmitted" Value="TRANSMITTED"></asp:ListItem>
                        <asp:ListItem Text="No Filter" Value="ALL"></asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Gainsboro; width: 200px;">Hold & SWN</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoHoldStatus" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Exclude" Value="Y" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Include " Value="N"></asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr visible="false">
                <td>SFR or Spool Priority</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoSpoolSFR" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="SFR First" Value="Y" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Spool First " Value="N"></asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Gainsboro; width: 200px;">AGUG Status</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoAGUG" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Both" Value="BOTH" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Above Ground" Value="AG"></asp:ListItem>
                        <asp:ListItem Text="Under Ground" Value="UG"></asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td>Priority Option</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoPriority" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Priority Simulation" Value="Y" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Normal Simulation" Value="N"></asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: Gainsboro; width: 200px;">Area</td>
                <td>:</td>
                <td>
                    <telerik:RadComboBox ID="ddAreaForSml" runat="server" CheckBoxes="True"
                        EnableCheckAllItemsCheckBox="True" Width="200px"
                        DataSourceID="dsArea" DataTextField="AREA_L2"
                        DataValueField="AREA_L2" Localization-AllItemsCheckedString="ALL AREA">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; width: 200px;">Select Isome List</td>
                <td>:</td>
                <td>
                    <asp:RadioButtonList ID="rdoSelectedIsome" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rdoSelectedIsome_SelectedIndexChanged">
                        <asp:ListItem Text="All Eligible Isometrics" Value="N" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="On Selected Isome List" Value="Y"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
        <table id="rowSelectedIsome" runat="server">
            <tr>
                <td>
                    <asp:FileUpload Skin="Default" ID="splUploader" runat="server" ToolTip="Select an Excel File" /></td>
                <td style="text-align: left;"><a href="../UTILITIES/Uploads/SimulationIsome.xlsx">
                    <img alt="Bullet" src="../App_Themes/BlueTheme/images/icons/excel.png" />Sample</a></td>
                <td style="text-align: left;">
                    <telerik:RadButton ID="btnIsomeUpload" runat="server" Text="Upload" OnClick="btnIsomeUpload_Click" Skin="Outlook"></telerik:RadButton>
                </td>
                <td>
                    <asp:RadioButtonList ID="rdoUploadOption" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Overwrite Existing & Upload" Value="APPEND"></asp:ListItem>
                        <asp:ListItem Text="Delete Existing & Upload" Value="DELETE" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList></td>
                <td>
                    <telerik:RadButton ID="btnExport" runat="server" Text="Export Exisitng" OnClick="btnExport_Click" Skin="Default"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div style="text-align: center">
        <table style="padding-top: 10px; text-align: center">
            <tr>
                <td>
                    <telerik:RadMenu ID="menuDefaultButton" runat="server" Skin="Default" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                        <Items>
                            <telerik:RadMenuItem CssClass="menu-right">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDefault" runat="server" Text="Restore Default" Font-Underline="false"
                                        OnClick="btnDefault_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenu>
                </td>
                <td>
                    <telerik:RadMenu ID="menuSaveButton" runat="server" Skin="Default" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                        <Items>
                            <telerik:RadMenuItem CssClass="menu-right">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSaveSettings" runat="server" Text="Save Settings" Font-Underline="false"
                                        OnClick="btnSaveSettings_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenu>
                </td>
                <td>
                    <telerik:RadMenu ID="menuRunSimulation" runat="server" Skin="Default" Width="100%" Style="top: 0px; left: 0px" EnableViewState="false">
                        <Items>
                            <telerik:RadMenuItem CssClass="menu-right">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnRunSimulation" runat="server" Text="Run" Font-Underline="false"
                                        OnClick="btnRunSimulation_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenu>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="dsSubContractor" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  SUB_CON_NAME, SUB_CON_ID FROM SUB_CONTRACTOR WHERE FIELD_SC='Y' ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsArea" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT &quot;AREA_L2&quot; FROM &quot;IPMS_AREA&quot; ORDER BY AREA_L2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsExport" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  ISO.ISO_TITLE1 FROM PIP_SML_ISOME,PIP_ISOMETRIC ISO
         WHERE   PIP_SML_ISOME.ISO_ID=ISO.ISO_ID"></asp:SqlDataSource>
</asp:Content>

