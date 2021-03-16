<%@ Page Title="Import Spoolgen Text" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportSGText.aspx.cs" Inherits="Utilities_ImportSGText" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<%@ Register Src="~/UserControls/Cut_List_User.ascx" TagPrefix="uc1" TagName="Cut_List_User" %>
<%@ Register Src="~/UserControls/LOM_User.ascx" TagPrefix="uc1" TagName="LOM_User" %>
<%@ Register Src="~/UserControls/Site_Assy_User.ascx" TagPrefix="uc1" TagName="Site_Assy_User" %>
<%@ Register Src="~/UserControls/Spl_Info_User.ascx" TagPrefix="uc1" TagName="Spl_Info_User" %>
<%@ Register Src="~/UserControls/Weld_User.ascx" TagPrefix="uc1" TagName="Weld_User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnErrorExport" Text="Error Log" Width="120px" OnClick="btnErrorExport_Click" BorderColor="Red"></telerik:RadButton>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div style="width: 100%; height: 350px; overflow: scroll; vertical-align: top; border-width: 1px; border-style: solid; border-color: DodgerBlue; margin-top: 3px">
                    <telerik:RadTabStrip ID="Spoolgen_Import" runat="server" MultiPageID="sgtextimport" SelectedIndex="4">
                        <Tabs>
                            <telerik:RadTab runat="server" Text="CUTLIST" Width="100px" Selected="True"></telerik:RadTab>
                            <telerik:RadTab runat="server" Text="LOM" Width="100px"></telerik:RadTab>
                            <telerik:RadTab runat="server" Text="SITE ASSY" Width="100px"></telerik:RadTab>
                            <telerik:RadTab runat="server" Text="SPL INFO" Width="100px"></telerik:RadTab>
                            <telerik:RadTab runat="server" Text="WELDING" Width="100px"></telerik:RadTab>
                            <telerik:RadTab runat="server" Text="SETTING" Width="100px"></telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>
                    <telerik:RadMultiPage ID="sgtextimport" runat="server" SelectedIndex="0">

                        <%--UserControl 2 Tab--%>
                        <telerik:RadPageView ID="CutListView" runat="server">
                            <asp:UpdatePanel ID="upcutlist" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <uc1:Cut_List_User runat="server" ID="spgcutTextRow" />
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </telerik:RadPageView>

                        <%--UserControl 1 Tab--%>
                        <telerik:RadPageView ID="LOMView" runat="server">
                            <asp:UpdatePanel ID="upLOM" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <uc1:LOM_User ID="LOM_User1" runat="server" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </telerik:RadPageView>

                        <%--UserControl 5--%>
                        <telerik:RadPageView ID="SiteassyView" runat="server">
                            <asp:UpdatePanel ID="upsiteassy" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <uc1:Site_Assy_User runat="server" ID="spgSiteassy"></uc1:Site_Assy_User>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </telerik:RadPageView>

                        <%--<%--UserControl 4--%>
                        <telerik:RadPageView ID="SplInfoView" runat="server">
                            <asp:UpdatePanel ID="upsplinfo" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <uc1:Spl_Info_User runat="server" ID="spgsplinfoTextRow"></uc1:Spl_Info_User>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </telerik:RadPageView>

                        <%--UserControl 3--%>
                        <telerik:RadPageView ID="WeldingView" runat="server">
                            <asp:UpdatePanel ID="upweld" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <uc1:Weld_User runat="server" ID="spgweldTextRow"></uc1:Weld_User>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </telerik:RadPageView>

                        <%--Settings UserControl 6--%>
                        <telerik:RadPageView ID="RadPageView1" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <asp:Panel ID="settingPanel" runat="server" DefaultButton="txtGo">
                                        <table style="font-size: medium;">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkIgnoreImportError" runat="server" Checked="true" Text="Ignore and Log Import Errors" /><br />
                                                    <asp:CheckBox ID="chkDefineNewIso" runat="server" Checked="false" Text="Define new Isometrics if does not exist" /><br />
                                                    <asp:CheckBox ID="chkDontUploadImportedISO" Checked="true" runat="server" Text="Dont Upload Imported Isometric" /></td>
                                            </tr>
                                            <tr runat="server" id="searchLotNumber">
                                                <td>
                                                    <telerik:RadTextBox ID="txtLotNumber" runat="server" EmptyMessage="Put new LOT number from Indonesia" Width="300px"></telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"
                                                        ValidationGroup="gobutton" ControlToValidate="txtLotNumber"></asp:RequiredFieldValidator>
                                                    <telerik:RadButton ID="txtGo" runat="server" Text="Collect Files" OnClick="txtGo_Click" ValidationGroup="gobutton"></telerik:RadButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <div>
                                        <asp:Label ID="lblConfirmation" runat="server" Font-Size="Medium" ForeColor="Green"></asp:Label>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </div>
                <div style="text-align: center">
                    <asp:ImageButton ID="btnTextDataUpdate" Width="100px" runat="server" OnClientClick="return confirm('Are you sure to update spoolgen data!')"
                        ImageUrl="~/Images/icons/upload-button-png.png" OnClick="btnTextDataUpdate_Click" />
                </div>
                <div style="text-align: center; font-weight: bold; font-family: Calibri; font-size: small; height: 20px;">
                    <asp:Label ClientIDMode="AutoID" runat="server" ID="lblMessage" ForeColor="Green" EnableViewState="false" Text="" Height="10px" Width="100%"></asp:Label>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                        <ProgressTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/App_Themes/BlueTheme/images/ajax-loader.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT * FROM VIEW_SG_IMPORT_ERROR"></asp:SqlDataSource>
    </div>
</asp:Content>

