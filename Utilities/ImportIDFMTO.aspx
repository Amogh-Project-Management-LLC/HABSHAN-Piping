<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="ImportIDFMTO.aspx.cs" Inherits="Utilities_ImportIDFMTO" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Import ISO MTO">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>Select File</td>
                        <td>
                            <%-- <asp:FileUpload ID="FileUpload1" runat="server" />--%>
                            <%--<telerik:RadUpload ID="RadUpload1" runat="server" MaxFileInputsCount="1"
                                ControlObjectsVisibility="None">
                            </telerik:RadUpload>--%>
                            <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" MaxFileInputsCount="1"></telerik:RadAsyncUpload>
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Import_Format/IdfMTOImport.xlsx">Sample File to Upload</asp:HyperLink>
                        </td>
                    </tr>
                    <tr style="padding-top: 10px">
                        <td></td>
                        <td>

                            <telerik:RadButton ID="btnImport" runat="server" Text="Submit" Width="90" OnClick="btnImport_Click"></telerik:RadButton>


                        </td>
                    </tr>
                </table>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <img src="../Images/ajax-loader-bar.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
            <%--<Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnImport" EventName="OnClick" />
                        </Triggers>--%>
        </asp:UpdatePanel>

    </asp:Panel>
</asp:Content>

