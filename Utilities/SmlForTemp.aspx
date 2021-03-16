<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SmlForTemp.aspx.cs" Inherits="Utilities_SmlForTemp" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table style="width: 100%;" runat="server" id="tbluploadTempData">
                        <%--line mto--%>
                        <tr>
                            <td>
                                <div style="height: 180px; width: 100%;">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="font-weight: bold;">MTO File</td>                                            
                                            <td>
                                                <asp:FileUpload Skin="Default" ID="mtoUploader" runat="server" ToolTip="Select an Excel File" />
                                            </td>
                                            <td><a href="../Import_Format/SampleMTOTempSml.xlsx">
                                                Sample<img alt="Sample File" src="../Images/ms_excel.gif" /></a></td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold;">ETA File</td>                                          
                                            <td>
                                                <asp:FileUpload Skin="Default" ID="matEtaUploader" runat="server" ToolTip="Select an Excel File" />
                                            </td>
                                              <td><a href="../Import_Format/SampleETATempSml.xlsx">
                                                Sample<img alt="Sample File" src="../Images/ms_excel.gif" /></a></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;" colspan="3">
                                                <telerik:RadButton ID="btnTempExcelUpload" runat="server" Text="Upload" OnClick="btnTempExcelUpload_Click"></telerik:RadButton>
                                                <telerik:RadButton ID="btnSimulation" runat="server" Text="Run Simulation" Enabled="false" OnClick="btnSimulation_Click"></telerik:RadButton>
                                              

                                              <%--  <asp:ImageButton ID="btnTempExcelUpload" Height="30px" Width="30px" runat="server"
                                                    ImageUrl="../App_Themes/BlueTheme/images/icons/upload.png" OnClick="btnTempExcelUpload_Click" />
                                                <asp:ImageButton ID="btnTempExcelUpdate" Visible="false" EnableViewState="true" Height="30px" Width="55px" runat="server"
                                                    ImageUrl="../App_Themes/BlueTheme/images/icons/update-button-blue.png" OnClick="btnTempExcelUpdate_Click" />--%>
                                            </td>
                                        </tr>
                                    </table>

                                    <div style="text-align: center;">
                                        <asp:Button ID="btnSmlTemp" runat="server" Text="Run Simulation" Font-Underline="false"
                                            OnClientClick="return confirmation();"  Visible="false"></asp:Button>
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                                            <ProgressTemplate>Please wait while updating files  ... 
                                              
                                                <img src="../Images/ajax-loader-bar.gif" alt="Please wait..." />                                               
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </div>
                                    
                                    <div style="text-align: center; font-weight: bold; font-family: Calibri; font-size: small;">
                                        <asp:Label ClientIDMode="AutoID" runat="server" ID="lblMessage" ForeColor="Green" EnableViewState="false" Text="" Height="20px" Width="100%"></asp:Label>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnTempExcelUpload" />
                </Triggers>
            </asp:UpdatePanel>
   
</asp:Content>

